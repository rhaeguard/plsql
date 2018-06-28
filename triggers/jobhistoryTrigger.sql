-- triggered when job_history table has encountered an insertion, deletion or modification
create or replace trigger job_historyTrigger
    after insert or update or delete on job_history
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
    UPDATEINFOTABLEPROCEDURE('job_history', action);
end;