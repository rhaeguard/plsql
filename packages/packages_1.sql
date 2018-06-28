/*
HR Scheme
Package is basically PLSQL's Abstract Class (it allows for global variables) 
and Interface (function/procedure specification/prototyping)) as Java

We can do package specification and package body (implementation) in separate files. But here we did it alltogether.
*/

-- package name
CREATE OR REPLACE PACKAGE employeePack
AS
-- this is the place for package specification
-- define the procedure's name and arguments OR
-- define the function's name, arguments and return type

    procedure getEmployeeById(
        emp_id IN employees.employee_id%type
    
    );
    procedure addEmployee(
        first_name      IN employees.first_name%type,
        last_name       IN employees.last_name%type,
        job_id          IN employees.job_id%type
    );
    procedure deleteEmployeeById(
        emp_id IN employees.employee_id%type
        
    );
    procedure updateEmployeeById(
        employee_id     IN employees.employee_id%type,
        first_name      IN employees.first_name%type        DEFAULT null,
        last_name       IN employees.last_name%type         DEFAULT null,        
        email           IN employees.email%type             DEFAULT null, 
        phone_number    IN employees.phone_number%type      DEFAULT null,
        hire_date       IN employees.hire_date%type         DEFAULT null,
        job_id          IN employees.job_id%type            DEFAULT null,
        salary          IN employees.salary%type            DEFAULT null,
        commission_pct  IN employees.commission_pct%type    DEFAULT null,
        manager_id      IN employees.manager_id%type        DEFAULT null,
        department_id   IN employees.department_id%type     DEFAULT null
    );
END employeePack;
-- this / forward slash symbol says to the compiler to continue even though it already encountered END
/
-- package body declaration
-- any function/procedure apart from the specification, is declared as PRIVATE
CREATE OR REPLACE PACKAGE BODY employeePack
AS
    -- PRIVATE FUNCTIONS/PROCEDURES
    -- print
    procedure print(str VARCHAR2)
    AS
    BEGIN
        dbms_output.put_line(str);
    END print;
    
    -- get next employee id, since it doesn't auto_increment
    function getNextEmpId
    RETURN employees.employee_id%type
    IS
        maxID employees.employee_id%type;
    BEGIN
        select max(employee_id) into maxID from employees;
        return maxID+1;
    END getNextEmpId;
    
    -- generate an email
    function generateEmail(
        first_name      IN employees.first_name%type,
        last_name       IN employees.last_name%type
    )
    RETURN employees.email%type
    IS
    BEGIN
        return UPPER(CONCAT(
            SUBSTR(first_name, 1, 1), last_name
        ));    
    END generateEmail;
    
    -- generate phone number
    function generatePhoneNumber
    RETURN employees.phone_number%type
    IS
        num1 number(3);
        num2 number(3);
        num3 number(4);
    BEGIN
        select
        dbms_random.value(100,999),
        dbms_random.value(100,999),
        dbms_random.value(1000,9999)
        into num1, num2, num3
        from dual;
        return num1 || '.' || num2 || '.' || num3;
    END generatePhoneNumber;
    
    -- assign department
    function assignDepartment(job_id IN employees.job_id%type)
    return employees.department_id%type
    IS
        dep employees.department_id%type;
    BEGIN
        for ind IN (select distinct e.department_id ii
        from employees e 
        where e.job_id = job_id and rownum<=1
        ) LOOP
        dep := ind.ii;
        END LOOP;
        return dep;
    EXCEPTION
        WHEN OTHERS THEN
            print('Error Occurred in assignDepartment : '||SQLERRM);
        return 1;
    END;
    
    -- assign manager
    function assignManager(job_id IN employees.job_id%type)
    RETURN employees.manager_id%type
    IS
    manid employees.manager_id%type;
    BEGIN
        for ind IN (select distinct D.manager_id ii
        from departments D, job_history J
        where D.department_id = J.DEPARTMENT_ID
        AND
        J.JOB_ID = job_id and rownum<=1
        ) LOOP
        manid := ind.ii;
        END LOOP;
        return manid;
    END assignManager;
    
    -- assign salary
    function assignSalary
    RETURN employees.manager_id%type
    IS
    BEGIN
        return 1912;
    END assignSalary;
    
    -- PUBLIC PROCEDURES/FUNCTIONS
    -- retrieve an employee by speficied id
    procedure getEmployeeById(emp_id IN employees.employee_id%type)
    AS
        rec_emp employees%rowtype;
    BEGIN
        select * into rec_emp from employees where employee_id = emp_id;
        print('First Name : '||rec_emp.first_name);
        print('Last Name : '||rec_emp.last_name);
    END getEmployeeById;

    -- add an employee
    procedure addEmployee(
        first_name      IN employees.first_name%type,
        last_name       IN employees.last_name%type,
        job_id          IN employees.job_id%type
    )
    AS
        emp_id employees.employee_id%type       := getNextEmpId();
        email employees.email%type              := generateEmail(first_name, last_name);
        phone_num employees.phone_number%type   := generatePhoneNumber();
        dep_id employees.department_id%type     := assignDepartment(job_id);
        man_id employees.manager_id%type        := assignManager(job_id);
        salary employees.salary%type            := assignSalary();
        hire_date employees.hire_date%type      := CURRENT_DATE;
    BEGIN
        INSERT INTO 
        employees(
            employee_id,
            first_name,
            last_name,
            job_id,
            email,
            phone_number,
            manager_id,
            department_id,
            salary,
            hire_date
        )
        VALUES
        (emp_id, first_name, last_name, job_id, email, phone_num, man_id, dep_id, salary, hire_date);
        
        IF SQL%ROWCOUNT = 1 THEN
            print('Success');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            print('Error Occurred addEmployee : '||SQLERRM);
    END addEmployee;

    -- delete the employee     
    procedure deleteEmployeeById(
        emp_id IN employees.employee_id%type
    )
    AS
    BEGIN
        DELETE FROM employees WHERE employee_id=emp_id;
        
        IF SQL%ROWCOUNT = 1 THEN
            print('Success!');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            print('Error occurred deleteEmployeeById : '||SQLERRM);
    END deleteEmployeeById;
    
    -- modify the employee record, it has flaws tho.
    procedure updateEmployeeById(
        employee_id     IN employees.employee_id%type,
        first_name      IN employees.first_name%type        DEFAULT null,
        last_name       IN employees.last_name%type         DEFAULT null,        
        email           IN employees.email%type             DEFAULT null, 
        phone_number    IN employees.phone_number%type      DEFAULT null,
        hire_date       IN employees.hire_date%type         DEFAULT null,
        job_id          IN employees.job_id%type            DEFAULT null,
        salary          IN employees.salary%type            DEFAULT null,
        commission_pct  IN employees.commission_pct%type    DEFAULT null,
        manager_id      IN employees.manager_id%type        DEFAULT null,
        department_id   IN employees.department_id%type     DEFAULT null
    ) AS
        queryString varchar2(255) := 'UPDATE employees SET ';
    BEGIN
        IF first_name IS NOT NULL THEN
            queryString := CONCAT(queryString, 'first_name = '''||first_name||'''');
        END IF;
        
        IF last_name IS NOT NULL THEN
            queryString := CONCAT(queryString, ', last_name = '''||last_name||'''');
        END IF;
        
        IF email IS NOT NULL THEN
            queryString := CONCAT(queryString, ', email = '''||email||'''');
        END IF;
        
        IF phone_number IS NOT NULL THEN
            queryString := CONCAT(queryString, ', phone_number = '''||phone_number||'''');
        END IF;
        
        IF hire_date IS NOT NULL THEN
            queryString := CONCAT(queryString, ', hire_date = '||hire_date);
        END IF;
        
        IF job_id IS NOT NULL THEN
            queryString := CONCAT(queryString, ', job_id = '''||job_id||'''');
        END IF;
        
        IF salary IS NOT NULL THEN
            queryString := CONCAT(queryString, ', salary = '||salary);
        END IF;
        
        IF commission_pct IS NOT NULL THEN
            queryString := CONCAT(queryString, ', commission_pct =' ||commission_pct);
        END IF;
        
        IF manager_id IS NOT NULL THEN
            queryString := CONCAT(queryString, ', manager_id = '||manager_id);
        END IF;
        
        IF department_id IS NOT NULL THEN
            queryString := CONCAT(queryString, ', department_id = '||department_id);
        END IF;
        
        queryString := CONCAT(queryString, ' WHERE employee_id = '||employee_id);
        
        -- executes a sql queries...
        EXECUTE IMMEDIATE queryString;
        IF SQL%ROWCOUNT=1 THEN
            print('Success!');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            print('Error Occured updateEmployeeById : '||SQLERRM);
    END updateEmployeeById;
    
END employeePack;
