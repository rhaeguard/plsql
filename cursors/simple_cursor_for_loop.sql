DECLARE    
    city locations.city%TYPE;
    street locations.street_address%TYPE;
    
    name EMPLOYEES.FIRST_NAME%TYPE;
    
    CURSOR cur_streets IS 
    (SELECT l.city city, TRIM(regexp_replace(l.street_address, '[0-9\-]', '')) street FROM regions r
    JOIN countries c ON c.region_id = r.region_id
    JOIN locations l ON l.country_id = c.country_id);
    
    CURSOR cur_rand_name IS SELECT FIRST_NAME, dbms_random.value rand FROM EMPLOYEES ORDER BY rand;
    
    -- function
    FUNCTION getARandomName
    RETURN VARCHAR2
    IS
        rand_name EMPLOYEES.FIRST_NAME%TYPE;
        dummy PLS_INTEGER;
    BEGIN
        OPEN cur_rand_name;
        FETCH cur_rand_name INTO rand_name, dummy;
        CLOSE cur_rand_name;
        RETURN rand_name;
    END;
BEGIN
    FOR rec_street IN cur_streets LOOP
        name := getARandomName();
        DBMS_OUTPUT.PUT_LINE(name || ' lives in ' || rec_street.street);
    END LOOP;
END;
/