-- declaration part
DECLARE
    -- variable initialization;
    country_name CHAR(2);
    country_count PLS_INTEGER;
    -- cursor initialization syntax
    /*
    CURSOR cursor_name IS (SELECT STATEMENT)
    */
    CURSOR cur_loc_count IS 
    SELECT country_id, count(*) count FROM LOCATIONS GROUP BY COUNTRY_ID ORDER BY count DESC;
BEGIN
    -- we have to open the cursor to utilize it
    OPEN cur_loc_count;
    -- loop through the result set
    LOOP
        -- fetch each record/row one by one and process it
        FETCH cur_loc_count INTO country_name, country_count;
        DBMS_OUTPUT.PUT_LINE('country : '||country_name||'; count : '||country_count);
        -- exit condition
        EXIT WHEN cur_loc_count%NOTFOUND;
    END LOOP;
    -- close the cursor to wipe out the remains from memory
    CLOSE cur_loc_count;
END;
/