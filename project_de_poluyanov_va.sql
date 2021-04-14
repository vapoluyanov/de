CREATE TABLE country_final_agr
(
    c_continent VARCHAR2 (100),
    c_af NUMBER (10, 0),
    c_reserve_af NUMBER (10, 0),
    c_total_af NUMBER (10, 0),
    c_people NUMBER (10, 0)
);
/
CREATE TABLE country_final
(
    c_name VARCHAR2(200),
    c_full_name VARCHAR2(200),
    c_continent VARCHAR2 (100),
    c_location VARCHAR2 (100),
    c_af NUMBER (10, 0),
    c_reserve NUMBER (10, 0),
    c_people NUMBER (10, 0)
);
/
CREATE TABLE country
(
    c_name         VARCHAR2(200),
    c_full_name   VARCHAR2 (200),
    c_continent    VARCHAR2 (100),
    c_location       VARCHAR2 (100)
);
/
CREATE TABLE population
(
    c_name         VARCHAR2(200),
    c_people       NUMBER (10, 0)
);
/
CREATE TABLE af
(
    c_name         VARCHAR2(200),
    c_af   NUMBER,
    c_reserve    NUMBER (10, 0)
);
/
DROP TABLE country_final_agr
/
DROP TABLE country_final
/
DROP TABLE country
/
DROP TABLE population
/
DROP TABLE af
/
SELECT * FROM country
/
SELECT * FROM country_final
/
SELECT * FROM country_final_agr
/
SELECT * FROM population
/
SELECT * FROM af
/
CREATE OR REPLACE PACKAGE pkg_poluyanov
AS
END pkg_poluyanov;
/
CREATE OR REPLACE PACKAGE BODY pkg_poluyanov
AS
END pkg_poluyanov;
/
BEGIN
  pkg_poluyanov.make_country_final_agr;
END;
