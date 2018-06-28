-- triggered when regions table has encountered an insertion, deletion or modification
create or replace trigger regionsTrigger
    after insert or update or delete on regions
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
    UPDATEINFOTABLEPROCEDURE('regions', action);
end;