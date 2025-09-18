📊 HR Analytics with SQL – IBM HR Dataset
📌 Project Overview

This project explores employee attrition, salary trends, promotions, and work-life balance using the IBM HR Analytics dataset.

The dataset was imported into MySQL Workbench and analyzed using SQL.
Queries were designed to answer HR-related business questions and uncover actionable insights.

✅ Skills Demonstrated:

SQL (Joins, Aggregations, Window Functions, Self Joins)

HR Analytics (attrition, salary analysis, promotions, demographics)

Query optimization and structured reporting

🗂 Dataset Details

Name: IBM HR Analytics Dataset

Rows: 1470

Columns: 35+ (EmployeeNumber, Age, Gender, Department, JobRole, MonthlyIncome, TotalWorkingYears, Attrition, etc.)

Source: IBM sample HR dataset (available on Kaggle)

This dataset contains employee demographics, career progression, work-life balance, income, and attrition details.

🏗 Database Setup

1️⃣ Create Database and Table

CREATE DATABASE Ibm_Hr;
USE Ibm_Hr;

CREATE TABLE Employees (
    Emp_No INT PRIMARY KEY,
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    NumCompaniesWorked INT,
    OverTime VARCHAR(10),
    PercentSalaryHike INT,
    PerformanceRating INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

2️⃣ Import Data

Used MySQL Workbench → Table Data Import Wizard to load ibm_hr_dataset.csv.

Verified import:
SELECT COUNT(*) FROM Employees;  -- 1470 rows

❓ Business Questions & Queries
### 1) Attrition Overview

##### 1. How many employees left vs stayed?

Select 
     Attrition, Count(*) As Total_Employees
     From Employees
     Group By Attrition ;

##### 2. What is the attrition rate?

Select 
     Round(Sum(Case When Attrition = "Yes" Then 1 Else 0 End) * 100/ Count(*)) As Attrition_Rate
     From Employees;

### 2) Department & Salary Analysis

##### 1. What is the average salary per department?

Select 
     Department As Department_Name, Avg(MonthlyIncome) As Average_Salary 
     From Employees Group By Department_Name
	 Order By Average_Salary Desc ;

##### 2. Which department has the highest attrition?

Select 
     Department as Department_Name, Count(*) as Attrition_Count
     From Employees 
     Where Attrition = "Yes"
     Group By Department_Name
     Order By Attrition_Count 
     Desc ;

### 3) Promotions & Career Growth

##### 1. Average Years before Promotion

Select 
     Round(Avg(YearsSinceLastPromotion),2) As Avg_Promotion_Waiting_Period_In_Years
     From Employees;

##### 2. Promotion Gap by Working Years

Select
     TotalWorkingYears, Avg(YearsSinceLastPromotion) As Avg_Promotion_Gap
     From Employees 
     Group By TotalWorkingYears
     Order By TotalWorkingYears ;

### 4) WORK-LIFE BALANCE AND OVERTIME

##### 1. Employees doing Overtime vs Not

Select 
     OverTime, Count(*) As Employee_Count
     From Employees
     Group By OverTime ;
     
##### 2. Attrition Rate among Overtime Workers

select 
     OverTime, Count(*) As Total_Employees,
     Sum(Case When Attrition = "Yes" Then 1 Else 0 End) as Attrition_Count,
     (Sum(Case When Attrition = "Yes" Then 1 Else 0 End) * 100 / Count(*)) as Attrition_Rate
     From Employees
     Group By OverTime ;

### 5) DEMOGRAPHICS AND RETENTION

##### 1. Average Age of Employees who Left vs Stayed

Select 
	 Attrition, Round(Avg(Age)) As Average_Age_Left_Stayed
     From Employees
     Group By Attrition ;
     
##### 2. Attrition by Marital Status

Select 
     MaritalStatus, Count(*) As Employee_Count
	 From Employees
     Where Attrition = "Yes"
     Group By MaritalStatus
     Order By Employee_Count Desc;

### 6) Career Progression (Advanced SQL)

##### 1. Peer Groups

Select 
     A.Emp_No As Emp_1, B.Emp_No As Emp_2,
     A.JobRole, A.TotalWorkingYears
     From Employees A 
     Join Employees B
     On A.JobRole = B.JobRole
     And A.TotalWorkingYears = B.TotalWorkingYears
     And A.Emp_No < B.Emp_No ;
     
##### 2. Income Ranking by Role 

Select 
     Emp_No, JobRole, Gender, MonthlyIncome,
     Dense_Rank() Over (Partition By JobRole Order By MonthlyIncome Desc) As Income_Ranking
     From Employees;
     
##### 3. Longest Serving Employee in each Department

Select 
     Department, Emp_No, TotalWorkingYears
     From (
         Select
			  Department, Emp_No, TotalWorkingYears,
              Row_Number() Over (Partition By Department Order By TotalWorkingYears Desc) As Work_Experience_Rank
			  From Employees ) As Ranked
			  Where Work_Experience_Rank = 1 ;

📈 Key Insights

Attrition:

Overall attrition rate ≈ 16%

R&D department has the highest attrition.

Salary Trends:

Sales offers higher average salaries compared to R&D.

Promotions:

Employees wait ~2 years on average for a promotion.

Promotion gaps increase with more experience → career progression slows at higher levels.

Work-Life Balance:

Employees doing overtime are ~2x more likely to leave.

Demographics:

Younger employees have higher attrition.

Single employees show more attrition than married employees.

Advanced Analysis:

Peer groups identified within roles.

Top earners within each role ranked using DENSE_RANK.

Longest-serving employees per department highlighted using ROW_NUMBER.
