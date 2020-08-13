-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/vZz66B
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Title" (
    "titleID" VARCHAR(20)   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Title" PRIMARY KEY (
        "titleID"
     )
);

CREATE TABLE "Departments" (
    "deptNo" VARCHAR(20)   NOT NULL,
    "deptName" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "deptNo"
     )
);

CREATE TABLE "EmployeeDept" (
    "employeeNo" int   NOT NULL,
    "deptNo" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_EmployeeDept" PRIMARY KEY (
        "employeeNo"
     )
);

CREATE TABLE "DeptManager" (
    "deptNo" VARCHAR(20)   NOT NULL,
    "employeeNo" int   NOT NULL
);

CREATE TABLE "Salaries" (
    "employeeNo" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Employees" (
    "employeeNo" int   NOT NULL,
    "EmpTitleID" VARCHAR(255)   NOT NULL,
    "BirthDate" VARCHAR(255)   NOT NULL,
    "FirstName" VARCHAR(255)   NOT NULL,
    "LastName" VARCHAR(255)   NOT NULL,
    "Sex" VARCHAR(255)   NOT NULL,
    "HireDate" VARCHAR(255)   NOT NULL
);

ALTER TABLE "EmployeeDept" ADD CONSTRAINT "fk_EmployeeDept_deptNo" FOREIGN KEY("deptNo")
REFERENCES "Departments" ("deptNo");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_deptNo" FOREIGN KEY("deptNo")
REFERENCES "Departments" ("deptNo");

ALTER TABLE "DeptManager" ADD CONSTRAINT "fk_DeptManager_employeeNo" FOREIGN KEY("employeeNo")
REFERENCES "EmployeeDept" ("employeeNo");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_employeeNo" FOREIGN KEY("employeeNo")
REFERENCES "EmployeeDept" ("employeeNo");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_employeeNo" FOREIGN KEY("employeeNo")
REFERENCES "EmployeeDept" ("employeeNo");

