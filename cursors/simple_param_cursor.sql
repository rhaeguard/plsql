DECLARE
    emp VARCHAR2(100);
    email VARCHAR2(20);
    man VARCHAR2(100);
    salary PLS_INTEGER;
    -- cursor declaration start
    CURSOR cur_email_emp (emp_id PLS_INTEGER) IS
    select 
    CONCAT(e.FIRST_NAME,CONCAT(' ',e.LAST_NAME)) employee,
    e.EMAIL,
    e.SALARY,
    CONCAT(m.FIRST_NAME,CONCAT(' ',m.LAST_NAME)) manager
    from employees e
    join EMPLOYEES m
    on e.MANAGER_ID=m.EMPLOYEE_ID
    WHERE e.EMPLOYEE_ID = emp_id;
    -- cursor declaration end
BEGIN
    OPEN cur_email_emp(104);
    LOOP
    
        FETCH cur_email_emp INTO emp, email, salary, man;
        
        EXIT WHEN cur_email_emp%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Dear '||man||', ');
        DBMS_OUTPUT.PUT_LINE('I''m '||emp||' and I''d like you to increase my salary from '||salary||' to '||(salary*1.22)||'. Thank You!');
        DBMS_OUTPUT.PUT_LINE('Sent from '||CONCAT(LOWER(email), '@company.com'));
    
    END LOOP;
    
    CLOSE cur_email_emp;
    
END;
/