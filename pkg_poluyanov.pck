CREATE OR REPLACE PACKAGE pkg_poluyanov
AS
       PROCEDURE make_country_final;
       PROCEDURE make_country_final_agr;
END pkg_poluyanov;
/
CREATE OR REPLACE PACKAGE BODY pkg_poluyanov
AS

       PROCEDURE make_country_final
       IS
       BEGIN
       EXECUTE IMMEDIATE 'truncate table country_final DROP STORAGE';

       INSERT INTO country_final
            (
            c_name
            ,c_full_name
            ,c_continent
            ,c_location
            ,c_af
            ,c_reserve
            ,c_people
            )
       SELECT
            c.c_name,
            c.c_full_name,
            c.c_continent,
            c.c_location,
            af.c_af,
            af.c_reserve,
            p.c_people
       FROM country c
            JOIN population p on c.c_name = p.c_name
            JOIN af on c.c_name = af.c_name
       ORDER BY 1;
       COMMIT;
       EXECUTE IMMEDIATE 'truncate table country DROP STORAGE';
       EXECUTE IMMEDIATE 'truncate table population DROP STORAGE';
       EXECUTE IMMEDIATE 'truncate table af DROP STORAGE'; 
       END make_country_final;


                    
       PROCEDURE make_country_final_agr
       IS
       BEGIN
       EXECUTE IMMEDIATE 'truncate table country_final_agr DROP STORAGE'; 
       INSERT INTO country_final_agr
          (
          c_continent
          ,c_af
          ,c_reserve_af
          ,c_total_af
          ,c_people
          )
       SELECT c_continent,
          SUM(c_af),
          SUM(c_reserve),
          SUM (c_af  + c_reserve),
          SUM(c_people)
       FROM country_final
          GROUP BY c_continent
          ORDER BY 1, 2 DESC;
       COMMIT;
       END make_country_final_agr;



END pkg_poluyanov;
/
