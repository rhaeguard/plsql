/**
advanced log table

create table advancedLog(
    action_user varchar2(30),
    action_date timestamp,
    action_msg varchar2(1000),
    action_old_value varchar2(1000),
    action_new_value varchar2(1000)
);
*/
create or replace trigger isSalarySuitableTrigger
    before insert or update on employees
    for each row
declare
    mgs VARCHAR2(100);
begin
    dbms_output.put_line(:new.job_id);
    IF INSERTING THEN
        IF isBtwMinMaxEmpSalary(:new.salary, :new.job_id) THEN
            persistToAdvancedLog('Inserted a Row with id = '||:new.employee_id, :old.salary, :new.salary);
        ELSE
            RAISE_APPLICATION_ERROR(-20013, 'Salary value doesn''t meet the requirements');
        END IF;
    END IF;
    
    IF UPDATING THEN
        IF isBtwMinMaxEmpSalary(:new.salary, :new.job_id) THEN
            IF :old.salary < :new.salary THEN
                mgs := 'Salary Raise';
            END IF;
            persistToAdvancedLog('Updated a Row with id = '||:new.employee_id||' - '||mgs, :old.salary, :new.salary);
        ELSE
            RAISE_APPLICATION_ERROR(-20013, 'Salary value doesn''t meet the requirements');
        END IF;
    END IF;
end isSalarySuitableTrigger;
/