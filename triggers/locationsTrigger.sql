-- triggered when locations table has encountered an insertion, deletion or modification
create or replace trigger locationsTrigger
    after insert or update or delete on locations
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
    UPDATEINFOTABLEPROCEDURE('locations', action);
end;