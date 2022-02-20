-- 9.1 give the total number of recordings in this table
-- 9.2 the number of packages listed in this table?
-- 9.3 How many times the package "Rcpp" was downloaded?
-- 9.4 How many recordings are from China ("CN")?
-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")
-- 9.9 Print the average length of the package name of all the UNIQUE packages
-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).
-- 9.11 Print the name of the package whose download count is bigger than 1000.
-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).




    IMPORT TABLE employees (
    date INT PRIMARY KEY,
    birth_date DATE NOT NULL,
    first_name STRING NOT NULL,
    last_name STRING NOT NULL,
    gender STRING NOT NULL,
    hire_date DATE NOT NULL
  ) CSV DATA ('https://s3-us-west-1.amazonaws.com/cockroachdb-movr/datasets/employees-db/csv/employees.csv.gz');

  "date","time","size","r_version","r_arch","r_os","package","version","country","ip_id"

  create table cran (
      id serial primary key,
      date DATE,
      time TIME, 
      size INT,
      r_version STRING,
      r_arch STRING,
      r_os STRING,
      package STRING,
      version STRING,
      country STRING,
      ip_id STRING
)

import into cran (date, time, size, r_version, r_arch, r_os, package, version, country, ip_id) csv data ('http://localhost:3000/cran_logs_2015-01-01.csv');