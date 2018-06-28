-- triggered when countries table has encountered an insertion, deletion or modification
create or replace trigger countriesTrigger
    after insert or update or delete on countries
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
    UPDATEINFOTABLEPROCEDURE('countries', action);
end;