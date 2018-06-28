CREATE OR REPLACE PROCEDURE salaryIncreasePerc
AS
    is_eligible BOOLEAN := FALSE;
    mean NUMBER(8);
    thresholdPct CONSTANT NUMBER(4,2) DEFAULT 2.30; 
BEGIN
    FOR rec IN (SELECT EMPLOYEE_ID, JOB_ID, SALARY FROM EMPLOYEES) LOOP
        checkEligibility(rec.job_id, rec.salary, is_eligible, mean);
        IF is_eligible THEN
            performIncrease(rec.employee_id, rec.salary, mean, thresholdPct);
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Occured : '||SQLERRM);
END salaryIncreasePerc;