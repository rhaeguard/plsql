DECLARE
    TYPE hero IS RECORD (
        fname VARCHAR2(15),
        lname VARCHAR2(20),
        birth PLS_INTEGER DEFAULT 1900,
        gender CHAR(1) DEFAULT 'U',
        superpower VARCHAR2(100)
    );
    
    Superman hero;
    Flash hero;
BEGIN
    Superman.fname := 'Clark';
    Superman.lname := 'Kent';
    Superman.birth := 1936;
    Superman.gender := 'M';
    Superman.superpower := 'Heat vision';
    
    Flash.fname := 'Barry';
    Flash.lname := 'Allen';
    Flash.birth := 1940;
    Flash.gender := 'M';
    Flash.superpower := 'Superspeed';
    
    DBMS_OUTPUT.PUT_LINE('Superman''s name : '||Superman.fname||' '||Superman.lname);
END;