Use Ibm_Hr;

-- 1) ATTRITION OVERVIEW

-- 1. Total Number of Employees by Attrition Status

Select 
     Attrition, Count(*) As Total_Employees
     From Employees
     Group By Attrition ;

-- 2. Attrition Rate

Select 
     Round(Sum(Case When Attrition = "Yes" Then 1 Else 0 End) * 100/ Count(*)) As Attrition_Rate
     From Employees;
     
-- 2) DEPARTMENT AND SALARY ANALYSIS

-- 1. Average Salary by Department

Select 
     Department As Department_Name, Avg(MonthlyIncome) As Average_Salary 
     From Employees Group By Department_Name
	 Order By Average_Salary Desc ;
     
-- 2. Highest Attrition by Department

Select 
     Department as Department_Name, Count(*) as Attrition_Count
     From Employees 
     Where Attrition = "Yes"
     Group By Department_Name
     Order By Attrition_Count 
     Desc ;
     
-- 3) PROMOTIONS AND CAREER GROWTH

-- 1. Average Years before Promotion

Select 
     Round(Avg(YearsSinceLastPromotion),2) As Avg_Promotion_Waiting_Period_In_Years
     From Employees;

-- 2. Promotion Gap by Working Years

Select
     TotalWorkingYears, Avg(YearsSinceLastPromotion) As Avg_Promotion_Gap
     From Employees 
     Group By TotalWorkingYears
     Order By TotalWorkingYears ;
     
-- 4) WORK-LIFE BALANCE AND OVERTIME

-- 1. Employees doing Overtime vs Not

Select 
     OverTime, Count(*) As Employee_Count
     From Employees
     Group By OverTime ;
     
-- 2. Attrition Rate among Overtime Workers

select 
     OverTime, Count(*) As Total_Employees,
     Sum(Case When Attrition = "Yes" Then 1 Else 0 End) as Attrition_Count,
     (Sum(Case When Attrition = "Yes" Then 1 Else 0 End) * 100 / Count(*)) as Attrition_Rate
     From Employees
     Group By OverTime ;
     
-- 5) DEMOGRAPHICS AND RETENTION

-- 1. Average Age of Employees who Left vs Stayed

Select 
	 Attrition, Round(Avg(Age)) As Average_Age_Left_Stayed
     From Employees
     Group By Attrition ;
     
-- 2. Attrition by Marital Status

Select 
     MaritalStatus, Count(*) As Employee_Count
	 From Employees
     Where Attrition = "Yes"
     Group By MaritalStatus
     Order By Employee_Count Desc;
     
-- 6) Career Progression (Advanced SQL)

-- 1. Peer Groups

select 
     A.Emp_No As Emp_1, B.Emp_No As Emp_2,
     A.JobRole, A.TotalWorkingYears
     From Employees A 
     Join Employees B
     On A.JobRole = B.JobRole
     And A.TotalWorkingYears = B.TotalWorkingYears
     And A.Emp_No < B.Emp_No ;
     
-- 2. Income Ranking by Role 

Select 
     Emp_No, JobRole, Gender, MonthlyIncome,
     Dense_Rank() Over (Partition By JobRole Order By MonthlyIncome Desc) As Income_Ranking
     From Employees;
     
-- 3. Longest Serving Employee in each Department

Select 
     Department, Emp_No, TotalWorkingYears
     From (
         Select
			  Department, Emp_No, TotalWorkingYears,
              Row_Number() Over (Partition By Department Order By TotalWorkingYears Desc) as Work_Experience_Rank
			  From Employees ) as Ranked
			  Where Work_Experience_Rank = 1 ;
              

     

     

    
     










