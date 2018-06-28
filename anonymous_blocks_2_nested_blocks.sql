DECLARE
-- declarations as well as initializations go here
    -- the variables in outer block(s) are visible to their sub-blocks (inner blocks)
    a number(2);
    b number(2);
BEGIN
    a:=45;
    b:=32;
    DECLARE
        -- however, variables in inner block is only visible inside of the block
        -- if variable with the same name is declared in both outer and inner block,
        -- then value in the inner block will change the value of that variable 
        res number(5);
    BEGIN
        res:=a+b;
        dbms_output.put_line(a||' + '||b||' = '||res);
        res:=a-b;
        dbms_output.put_line(a||' - '||b||' = '||res);
        res:=a*b;
        dbms_output.put_line(a||' * '||b||' = '||res);
        res:=a/b;
        dbms_output.put_line(a||' / '||b||' = '||res);
    EXCEPTION
        WHEN OTHERS THEN
            null;
    END;
END;