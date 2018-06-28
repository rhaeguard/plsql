DECLARE
    jobtitle JOBS.JOB_TITLE%TYPE;
    -- setting a default value for a cursor
    CURSOR cur_jobs(salary POSITIVE := 2500) IS 
    SELECT job_title from jobs
    WHERE salary BETWEEN min_salary AND max_salary;
BEGIN
    OPEN cur_jobs();
    LOOP
        FETCH cur_jobs INTO jobtitle;
        
        EXIT WHEN cur_jobs%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Job : '||jobtitle);
    END LOOP;
    CLOSE cur_jobs;
END;
/