-- triggered when departments table has encountered an insertion, deletion or modification
create or replace trigger departmentsTrigger
    after insert or update or delete on departments
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
    UPDATEINFOTABLEPROCEDURE('departments', action);
end;