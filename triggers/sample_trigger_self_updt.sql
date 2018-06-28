/**
Firing this trigger will cause the following error:
ORA-00036: maximum number of recursive SQL levels (50) exceeded

Because this trigger is adding an element 
before each insertion to the table but this 
trigger also adds an element to that table when it is triggered
Hence, it causes an infinite recursive calls. Oracle doesn't allow more than 50 calls

**/
create or replace trigger sample_self_updating_trigger
    before insert on logs
declare
begin
    insert into logs(log, date_added) values('Before Action Triggered from Self Updt. Trigger', SYSDATE);
end;
/