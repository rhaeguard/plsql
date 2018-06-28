-- here we change the assigned value of a variable inside of the sub-blocks, but it affects only inside of the block, 
-- not after that...after the sub-block, the value will be the same as it was before
DECLARE
    -- the variables in outer block(s) are visible to their sub-blocks (inner blocks)
    a number(2);
BEGIN
    a:=45;
    DBMS_OUTPUT.PUT_LINE('inside of the outer block before a = '||a);
    DECLARE
        a number(2);
    BEGIN
        a:=15;
        DBMS_OUTPUT.PUT_LINE('inside of the inner block a = '||a);
    EXCEPTION
        WHEN OTHERS THEN
            null;
    END;
    DBMS_OUTPUT.PUT_LINE('inside of the outer block after a = '||a);
END;