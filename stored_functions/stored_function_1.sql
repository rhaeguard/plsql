-- fills the null commision percentages
CREATE OR REPLACE FUNCTION findMissingCPCT
(
salary IN employees.salary%type
)
RETURN EMPLOYEES.COMMISSION_PCT%type
IS
    result_pct employees.commission_pct%type;
    lbound employees.commission_pct%type;
    ubound employees.commission_pct%type;
    mean employees.commission_pct%type;
    
    cursor forLower is (select cp into lbound from 
    (select commission_pct cp from EMPLOYEES where salary < findMissingCPCT.salary and commission_pct is not null order by salary desc) 
    where rownum <=1);
    
    cursor forUpper is (select cp into ubound from 
    (select commission_pct cp from EMPLOYEES where salary > findMissingCPCT.salary and commission_pct is not null order by salary) 
    where rownum <=1);
BEGIN
    OPEN forLower;
    IF (forLower%NOTFOUND) THEN
        lbound := NULL;
    ELSE
        FETCH forLower INTO lbound;
    END IF;
    CLOSE forLower;
    
    OPEN forUpper;
    IF (forUpper%NOTFOUND) THEN
        ubound := NULL;
    ELSE
        FETCH forUpper INTO ubound;
    END IF;
    CLOSE forUpper;
    
    IF (lbound IS NOT NULL AND ubound IS NOT NULL) THEN
        result_pct := (lbound+ubound)/2;
    ELSIF (lbound IS NOT NULL) THEN
        result_pct :=  lbound + lbound*0.01;
    ELSIF (ubound IS NOT NULL) THEN
        result_pct :=  ubound - ubound*0.01;
    ELSE
        select avg(COMMISSION_PCT) into mean from employees where COMMISSION_PCT IS NOT NULL;
        result_pct := mean;
    END IF;
    
    RETURN result_pct;
EXCEPTION
    WHEN others THEN
        return NULL;
END;
