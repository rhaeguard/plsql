-- row level trigger
create or replace trigger salary_check
    after update or insert on employees
    for each row
    when(new.salary>9000)
declare
begin
    IF INSERTING THEN
        PERSISTTOLOG('Inserted Row with Salary More Than 9000');
    END IF;
    
    IF UPDATING THEN
        PERSISTTOLOG('Updated Row with Salary More Than 9000 - '||:new.employee_id);
    END IF;
    
end;
/