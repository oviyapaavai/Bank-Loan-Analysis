USE bank_loan;
SELECT * FROM bank_loan.financial_loan;

/* ALTER TABLE bank_loan.financial_loan
MODIFY issue_date DATE; 
ALTER TABLE bank_loan.financial_loan
MODIFY last_credit_pull_date DATE; 
ALTER TABLE bank_loan.financial_loan
MODIFY last_payment_date DATE;
ALTER TABLE bank_loan.financial_loan
MODIFY next_payment_date DATE; */

-- 1. Total loan applications --
SELECT COUNT(id) AS 'Total Applications' FROM bank_loan.financial_loan; 

-- 2. MTD loan applications --
SELECT COUNT(id) AS 'Total Applications' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12;

-- 3. PMTD loan applications --
SELECT COUNT(id) AS 'Total Applications' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 11; 

-- 4. Total funded amount --
SELECT SUM(loan_amount) AS 'Total Funded Amount' FROM bank_loan.financial_loan; 

-- 5. MTD Total Funded Amount --
SELECT SUM(loan_amount) AS 'Total Funded Amount' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12;

-- 6. PMTD Total funded amount --
SELECT SUM(loan_amount) AS 'Total Funded Amount' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 11; 

-- 7. Total amount received -- 
SELECT SUM(total_payment) AS 'Total Amount Collected' FROM bank_loan.financial_loan;

-- 8. MTD total amount received --
SELECT SUM(total_payment) AS 'Total Amount Collected' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12; 

-- 9. PMTD total amount received --
SELECT SUM(total_payment) AS 'Total Amount Collected' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 11;

-- 10. Avg intrest rate --
SELECT AVG(int_rate)*100 AS 'Avg intrest rate' FROM bank_loan.financial_loan; 

-- 11. MTD avg intrest rate --
SELECT AVG(int_rate)*100 AS 'MTD avg intrest rate' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12; 

-- 12. PMTD avg intrest rate --
SELECT AVG(int_rate)*100 AS 'PMTD avg intrest rate' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 11;

-- 13.Avg dti --
SELECT AVG(dti)*100 AS 'Avg DTI' FROM bank_loan.financial_loan;  

-- 14. MTD avg dti --
SELECT AVG(dti)*100 AS 'Avg MTD DTI' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12;

-- 15. PMTD avg dti --
SELECT AVG(dti)*100 AS 'Avg PMTD DTI' FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 11; 

-- Good Loan --
-- 1. good loan percentage --
SELECT
   ROUND((COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id),2) AS 'Good Loan Percentage'
FROM bank_loan.financial_loan; 

-- 2. good loan applications --
SELECT COUNT(id) AS 'Good Loan Applications' FROM bank_loan.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 3. good loan funded amount --
SELECT SUM(loan_amount) AS 'Good Loan Funded amount' FROM bank_loan.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

-- 4. good loan amount received --
SELECT SUM(total_payment) AS 'Good Loan amount received' FROM bank_loan.financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Bad Loan --
-- 1. bad loan percentage --
SELECT
    ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id),2) AS 'Bad Loan Percentage'
FROM bank_loan.financial_loan; 

-- 2. bad loan applications --
SELECT COUNT(id) AS 'Bad Loan Applications' FROM bank_loan.financial_loan
WHERE loan_status = 'Charged Off'; 

-- 3. bad loan funded amount -- 
SELECT SUM(loan_amount) AS 'Bad Loan Funded amount' FROM bank_loan.financial_loan
WHERE loan_status = 'Charged Off'; 

-- 4. bad loan amount received --
SELECT SUM(total_payment) AS 'Bad Loan amount received' FROM bank_loan.financial_loan
WHERE loan_status = 'Charged Off'; 

-- Loan status --
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM bank_loan.financial_loan
    GROUP BY loan_status; 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan.financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status; 

-- month report --

SELECT 
    MONTH(issue_date) AS Month_Number, 
    MONTHNAME(issue_date) AS Month_Name, 
    COUNT(id) AS Total_Loan_Applications,
    SUM(loan_amount) AS Total_Funded_Amount,
    SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);


-- State --
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY address_state
ORDER BY address_state; 

-- Term --
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY term
ORDER BY term; 

-- Employee length -- 
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY emp_length
ORDER BY emp_length; 

-- Purpose --
SELECT 
	purpose AS Purpose, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY purpose
ORDER BY purpose; 

-- Home ownership --
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
GROUP BY home_ownership
ORDER BY home_ownership; 

/*SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan.financial_loan
WHERE grade = "A" AND address_state ='CA'
GROUP BY home_ownership
ORDER BY home_ownership;*/






    







