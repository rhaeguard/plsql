-- the most basic procedure setup [no input, no declare section]
-- this will create a procedure if doesn't exist or will replace it, otherwise
CREATE OR REPLACE PROCEDURE
-- its name
printEmployeeNames
-- AS keyword is used to denote the body part. 
-- can be remembered as such that, the following procedure does the action AS follows.
AS
BEGIN
    FOR employee IN (SELECT first_name fn FROM EMPLOYEES) LOOP
        DBMS_OUTPUT.PUT_LINE(employee.fn);
    END LOOP;
-- it has to end with its name
END printEmployeeNames;


/*
-- a stored procedure can be invoked in 2 different ways:

-- EXECUTE command
EXECUTE procedureName(args)

-- Just by its name inside of another procedure either stored or anonymous
*/