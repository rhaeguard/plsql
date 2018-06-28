/**
this procedure updates the tableInformation's corresponding row and column based upon the parameters
table_name - corresponds to the row
operation - i for insertion, d for deletion, u for update/modification
*/
set serveroutput on;
create or replace procedure updateInfoTableProcedure(
    table_name varchar2,
    operation char
)
AS
    sqltext varchar2(100);
    updateError exception;
BEGIN
    if operation='i' then
        sqltext := ' last_insertion ';
    elsif operation='u' then
        sqltext := ' last_updated ';
    elsif operation='d' then
        sqltext := ' last_deletion ';
    end if;
    -- form the sql query string and execute it immediately
    -- note to self, don't use system reserved words for bind variables inside of the string, such as table, create, start, etc.
    execute immediate 'update tableInformation set'||sqltext||'= :dateofsys where table_name = :tableu' using sysdate,table_name;
    if sql%rowcount <> 1 then
        raise updateError;
    end if;
    dbms_output.put_line('No problem');
EXCEPTION
    when updateError then
        dbms_output.put_line('Error While updating');
    when others then
        dbms_output.put_line('Now that is bad! - '||sqlerrm);
END updateInfoTableProcedure;