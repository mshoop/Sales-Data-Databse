# Sales-Data-Databse

## Part 1: Identifying Functional Dependencies 

Consider the following database : MySales (pname, discount, month, price)

Revise the table schema given the file "mySalesData.csv" by reverse engineering and normalizing the database

### Steps:

1. Create a table "MySales" using a PostgreSQL database

2. Load the data from the provided file "mySalesData.csv" (refer to instructions on how to import a.csv file in PostgreSQL)

2. Find all functional dependencies in the relation through reverse engineering

3. Decompose the table to BCNF relations and create SQL tables for the decomposed schema (create keys and foreign keys where appropriate)

4. Populate your BCNF tables from the original data using SQL queries that insert data into tables created in Step 3


## Part 2: BCNF Decomposition

Consider the following relations and functional dependencies:

1. R(A,B,C,D,E) and FD's A → E, BC → A, DE → B

2. S(A,B,C,D) and FD's C → D, C → A, B → C


For each relation:

* Identify the minimal key(s) for the relation

* Identify whether the relation is in BCNF, if not in BCNF decompose it into a set of BCNF relations

* If you decomposed the relation in part b, argue whether the composition preserved functionaldependencies
