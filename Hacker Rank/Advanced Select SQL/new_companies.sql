--Requirement :
--A query to print company_code, founder name, total number of lead managers,
--total number of senior managers, total number of managers, and total number of employees.
--Order your output by ascending company_code.

--Tables :
-- Company : company_code, founder (string)
-- Lead_Manager : lead_manager_code, company_code (string)
-- Senior_Manager : senior_manager_code, lead_manager_code, company_code (string)
-- Manager : manager_code, senior_manager_code, lead_manager_code, company_code (string)
-- Employee : employee_code, manager_code, senior_manager_code, lead_manager_code, company_code (string)

SELECT C.company_code, C.founder, COUNT(DISTINCT(E.lead_manager_code)), COUNT(DISTINCT(E.senior_manager_code)), COUNT(DISTINCT(E.manager_code)), COUNT(DISTINCT(E.employee_code)) FROM Employee AS E JOIN Company AS C ON C.company_code = E.company_code GROUP BY C.company_code, C.founder ORDER BY C.company_code;