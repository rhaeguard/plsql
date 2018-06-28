/*
    checks if the employee salary is valid by 
    checking if it is inbetween min and max salary for the corresponding job
*/
create or replace function isBtwMinMaxEmpSalary(
    salary employees.salary%type,
    job_id employees.job_id%type
)
return boolean
IS
    min_sal NUMBER;
    max_sal NUMBER;
BEGIN
    SELECT MIN_SALARY, MAX_SALARY INTO min_sal, max_sal FROM JOBS J WHERE J.JOB_ID = job_id;
    IF salary < MIN_SAL OR salary > MAX_SAL THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END isBtwMinMaxEmpSalary;