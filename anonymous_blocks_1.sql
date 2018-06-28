DECLARE
name VARCHAR2(15);
birth DATE;
year NUMBER(11);
BEGIN
name := 'Owary';
birth := '13-NOV-1997';
year := months_between(sysdate, birth)/12; 
dbms_output.put_line('Name is '||name||', and is '||year||' years old');
EXCEPTION
WHEN OTHERS THEN
    dbms_output.put_line('Exception');
    null;
END;