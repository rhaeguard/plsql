-- triggered when jobs table has encountered an insertion, deletion or modification
create or replace trigger jobsTrigger
    after insert or update or delete on jobs
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
    UPDATEINFOTABLEPROCEDURE('jobs', action);
end;