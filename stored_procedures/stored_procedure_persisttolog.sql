create or replace procedure persistToLog(log_text varchar2)
AS
begin
    insert into logs(log, date_added) values (log_text, sysdate);
end persistToLog;
