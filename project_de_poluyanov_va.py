# -*- coding: utf-8 -*-
"""
Created on Thu Apr  1 20:23:22 2021

@author: poluy
"""
import cx_Oracle as ora
import sqlalchemy as adb
from sqlalchemy import MetaData
import pandas as pd
import sys
import time

with open('log.txt') as fp:
    l_user = fp.read()

with open('pas.txt') as fp:
    l_pass = fp.read()

l_tns = ora.makedsn('13.95.167.129', 1521, service_name = 'pdb1')

l_conn_ora = adb.create_engine(r'oracle://{p_user}:{p_pass}@{p_tns}'.format(
    p_user = l_user
    , p_pass = l_pass
    , p_tns = l_tns
    ))

print('\n1. Подключение к базе, пожалуйста подождите...\n')
try:
    l_meta = MetaData(l_conn_ora)
    l_meta.reflect()
except:
    print('Истекло время ожидания, попробуйте еще раз!')
    sys.exit(0)
 
    
print('2. Началась загрузка!\n', ) 
l_file_excel = pd.read_excel(r'world.xlsx', sheet_name = 0)
l_list = l_file_excel.values.tolist()
x = 0
l_table = l_meta.tables['country']
for i in l_list:
    l_table.insert([l_table.c.c_name, l_table.c.c_full_name, l_table.c.c_continent, l_table.c.c_location]).values(
        c_name = i[0]
        , c_full_name = i[1]
        , c_continent = i[2]
        , c_location = i[3]
    ).execute()
    x += 1
    print(x)
print('Всего импортировано в таблицу Страны: ', x)

l_file_excel2 = pd.read_excel(r'world.xlsx', sheet_name = 1)
l_list2 = l_file_excel2.values.tolist()
x = 0   
l_table = l_meta.tables['population']
for i in l_list2:
    l_table.insert([l_table.c.c_name, l_table.c.c_people]).values(
        c_name = i[0]
        , c_people = i[1]
    ).execute()
    x += 1
    print(x)
print('Всего импортировано в таблицу Население: ', x)

l_file_excel3 = pd.read_excel(r'world.xlsx', sheet_name = 2)
l_list3 = l_file_excel3.values.tolist()
x = 0 
l_table = l_meta.tables['af']
for i in l_list3:
    l_table.insert([l_table.c.c_name, l_table.c.c_af, l_table.c.c_reserve]).values(
        c_name = i[0]
        , c_af = i[1]
        , c_reserve = i[2]
    ).execute()
    x += 1
    print(x)
print('Всего импортировано в таблицу Вооруженные силы: ', x)


print ('\n3. Формирование базовой таблицы...\n')

l_conn_ora.execute(adb.text('BEGIN pkg_poluyanov.make_country_final; END;'))

time.sleep(10)

l_table = l_meta.tables['country_final']
print('4. Базовая таблица сформирована!')

print('\nСтрана, Полное наименование, Часть света, Расположение, Вооруженные силы, В резерве, Население\n')      
l_select = l_table.select().where(l_table.c.c_name == 'Россия').execute()
for i in l_select:
    print(i)


print ('\n5. Агрегация данных...\n')

time.sleep(10)    

l_conn_ora.execute(adb.text('BEGIN pkg_poluyanov.make_country_final_agr; END;'))

print ('6. Агрегация данных завершена!\n')

l_table = l_meta.tables['country_final_agr']
print('Континент, Вооруженныесилы, В резерве, Всего ВС, Население\n')      
l_select = l_table.select().where(l_table.c.c_continent == 'Европа').execute()
for i in l_select:
    print(i)
print ('\n7. Программа выполнена!')