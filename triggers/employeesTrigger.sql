-- triggered when employees table has encountered an insertion, deletion or modification
create or replace trigger employeesTrigger
    after insert or update or delete on employees
declare
    action char(1);
begin
    if inserting then
        action := 'i';
    elsif updating then
        action := 'u';    
    elsif deleting then
        action := 'd';
    end if;
    UPDATEINFOTABLEPROCEDURE('employees', action);
end;