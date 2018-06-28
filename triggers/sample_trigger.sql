/**
Logs Table 
create table logs(
    log varchar2(1000),
    date_added date default sysdate
);
**/

-- standard create or replace syntax
create or replace trigger sample_trigger
-- this is the part where we mention when trigger should be fired
-- syntax is easy
-- before/after insert [or] delete [or] update [of column_name] on table_name
-- we can use multiple operations such as:
-- "after update or delete on logs"
    before update on employees
-- standard anonymous block structure
declare
begin
    insert into logs(log, date_added) values('Before Action Triggered', SYSDATE);
end;
/

/**
this is an example of STATEMENT LEVEL TRIGGER
which means if will only fire once for each transaction
**/