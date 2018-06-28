CREATE OR REPLACE PROCEDURE performIncrease
(
    emp_id IN employees.employee_id%TYPE,
    salary IN employees.salary%type,
    mean IN NUMBER,
    thresholdPct NUMBER
)
AS
-- percentahge
    pct NUMBER(14,12);
    
-- negative mean exception flag
    negativeMean EXCEPTION;
-- update error exception flag   
    updateError EXCEPTION;
BEGIN
    pct := 100*(mean-salary)/salary;
    
    IF (pct <= thresholdPct) THEN
        UPDATE employees SET salary = salary*(1+pct/100) WHERE employee_id = emp_id;
        IF (SQL%ROWCOUNT <> 1) THEN
            RAISE updateError;
        ELSE
            DBMS_OUTPUT.PUT_LINE('Success for the employee : id = '||emp_id||'; pct : '||pct||'%');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('For the employee : id = '||emp_id||' increase is impossible');
    END IF;
    
EXCEPTION
    WHEN negativeMean THEN
        DBMS_OUTPUT.PUT_LINE('Mean Cannot be Negative');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error Occured whilst Performing Increase');
END performIncrease;