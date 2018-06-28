create or replace procedure persistToAdvancedLog(
    action_msg ADVANCEDLOG.action_msg%type,
    action_old_value ADVANCEDLOG.action_old_value%type,
    action_new_value ADVANCEDLOG.action_new_value%type
)
AS
BEGIN
    INSERT INTO ADVANCEDLOG VALUES(
        USER,SYSDATE,action_msg,action_old_value,action_new_value
    );
END;