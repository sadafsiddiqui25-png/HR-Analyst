use project_hr;
select * from hr_masterdata;

#KPI'S Toatl Employee,Attrition Count & Active Employe
SELECT 
  COUNT(*) AS TotalEmployees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
  SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS ActiveEmployees
FROM hr_masterdata;

SELECT AVG(Age) AS AverageAge
FROM hr_masterdata;

#Job Satisfaction ration
SELECT AVG(JobSatisfaction) AS AvgJobSatisfaction
FROM hr_masterdata;

SELECT 
  COUNT(*) * 100.0 / (SELECT COUNT(*) FROM hr_masterdata) AS HighSatisfactionRate
FROM hr_masterdata
WHERE JobSatisfaction >= 3;	
#Average Attrition rate for all Departments
SELECT 
  Department,
  COUNT(*) AS TotalEmployees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
  ROUND(
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS AttritionRate_Percent
FROM hr_masterdata
GROUP BY Department;

#Average Hourly rate of Male Research Scientist
SELECT 
  AVG(HourlyRate) AS AvgHourlyRate_Male_RS
FROM hr_masterdata
WHERE Gender = 'Male' 
  AND JobRole = 'Research Scientist';
  
  #Attrition rate Vs Monthly income stats
  SELECT 
  IncomeBand,
  COUNT(*) AS TotalEmployees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePercent,
  ROUND(AVG(MonthlyIncome), 2) AS AvgMonthlyIncome
FROM hr_masterdata
GROUP BY IncomeBand
ORDER BY IncomeBand;

#Average working years for each Department
SELECT 
  Department,
  ROUND(AVG(TotalWorkingYears), 2) AS AvgWorkingYears
FROM hr_masterdata
GROUP BY Department
ORDER BY AvgWorkingYears DESC;

#Job Role Vs Work life balance
SELECT 
  JobRole,
  ROUND(AVG(WorkLifeBalance), 2) AS AvgWorkLifeBalance
FROM hr_masterdata
GROUP BY JobRole
ORDER BY AvgWorkLifeBalance DESC;

#Attrition rate Vs Year since last promotion relation
SELECT 
  YearsSinceLastPromotion,
  COUNT(*) AS TotalEmployees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
  ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS AttritionRatePercent
FROM hr_masterdata
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;