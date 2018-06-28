CREATE OR REPLACE PROCEDURE checkEligibility
(
    job_id IN EMPLOYEES.JOB_ID%type,
    salary IN EMPLOYEES.salary%TYPE,
    is_eligible OUT BOOLEAN,
    mean OUT NUMBER
)
AS
BEGIN
    SELECT (min_salary+max_salary)/2 INTO mean FROM JOBS WHERE job_id = checkEligibility.job_id;
    IF salary < mean THEN
        is_eligible := TRUE;
    ELSE
        is_eligible := FALSE;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Occured whilst Checking Eligibility!');
END checkEligibility;
