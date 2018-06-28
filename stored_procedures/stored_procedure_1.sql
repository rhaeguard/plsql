-- it will increase the salary of the employees in given job_id, by given percentage
-- it will create a procedure if doesn't exist and replace it otherwise
CREATE OR REPLACE PROCEDURE incSalaryOfAJobByPerc
(
-- parameters; they are IN (we have OUT, IN OUT as well)
jobid IN employees.job_id%TYPE,
perc IN NUMBER
)
-- AS keyword
AS
-- ghost DECLARE keyword :D seriosly, we don't need it here!
    emp_id employees.employee_id%type;
    emp_salary employees.salary%type;

-- okay, we got exceptions here...unlike other languages PLSQL's exceptions are quite logical :D and 
-- they are basically flags, so for specific reasons unique flags are raised
-- if the Percentage is invalid
    invalidPerc EXCEPTION;
-- if error occured while updating, see no-brainer for now :D
    updateError EXCEPTION;
-- now, we know it from anonymous blocks or we better call em' unnamed not stored procedures :D, 
-- it's cool, trust me
BEGIN
    -- now, our 'must have' IF statement; it does check the validity of the percentage
    IF (perc > 50) OR (perc <= 0) THEN
    -- and raises error if problem is found
        RAISE invalidPerc;
    END IF;
    
    -- wooow wow, wait, don't be afraid, let me explain
    -- this FOR LOOP, retrieves the ids and salaries of employees of indicated job
    FOR ind IN (SELECT employee_id i, salary s FROM employees WHERE job_id=jobid) LOOP
        emp_id := ind.i;
        emp_salary := ind.s;
        
        -- validity checking and calculation of new salary value
        IF (emp_salary < 5000) THEN
            emp_salary := emp_salary * (1+(perc/100));
        END IF;
        
        -- updating the table
        UPDATE employees SET salary = emp_salary WHERE employee_id=emp_id;
        
        -- logically, for each update one row has to be affected, otherwise is wrong anyway
        IF (SQL%ROWCOUNT <> 1) THEN
            RAISE updateError;
        -- or print success, at least something has to be shown, no?
        ELSE
            DBMS_OUTPUT.PUT_LINE('Success!');
        END IF;
    END LOOP;
    
-- hey, wait a second I know this, right?
-- yeap, it is an exception clause
EXCEPTION
-- basically if any flag is raised, corresponding action is done; in this case, print and rollback;
    WHEN invalidPerc THEN
        DBMS_OUTPUT.PUT_LINE('Percentage is not valid!');
        ROLLBACK;
    WHEN updateError THEN
        DBMS_OUTPUT.PUT_LINE('Error Occured While Updating');
        ROLLBACK;
-- or any unindicated error comes here
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Internal Error Occured!');
        ROLLBACK;
END incSalaryOfAJobByPerc;
