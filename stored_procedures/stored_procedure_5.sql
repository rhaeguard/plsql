-- fills missing commission percentages
CREATE OR REPLACE PROCEDURE fillMissingCPCT
AS
    pct employees.commission_pct%type;
    CURSOR emp_id_and_salary IS (SELECT employee_id eid, salary sal FROM employees WHERE commission_pct IS NULL); 
    
    updateException EXCEPTION;
BEGIN
    FOR emp IN emp_id_and_salary LOOP
        select findMissingCPCT(emp.sal) into pct from dual;
        UPDATE EMPLOYEES SET commission_pct = pct WHERE employee_id = emp.eid;
        IF (SQL%ROWCOUNT<>1) THEN
            RAISE updateException;
        END IF;
    END LOOP;
EXCEPTION
    WHEN updateException THEN
        show('Error while updating');
    WHEN OTHERS THEN
        show('Error occurred!');
END;
/