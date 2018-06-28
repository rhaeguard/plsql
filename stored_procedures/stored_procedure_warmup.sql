create or replace procedure randomNameStartsWith(
    initialCh IN CHAR
)
AS
    CURSOR names IS (
        SELECT first_name as rname FROM employees WHERE first_name LIKE CONCAT(UPPER(initialCh), '%') 
        UNION
        SELECT last_name as rname FROM employees WHERE last_name LIKE CONCAT(UPPER(initialCh), '%')
    );
BEGIN
    FOR i IN names LOOP
        DBMS_OUTPUT.PUT_LINE(i.rname);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Exception Occurred');
END randomNameStartsWith;