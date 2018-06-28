DECLARE
  CURSOR dep_curs IS SELECT dept_id, dept_name FROM DEPARTMENT;
  dep_rec DEPARTMENT%ROWTYPE;
BEGIN
  OPEN dep_curs;
  LOOP
    EXIT WHEN dep_curs%NOTFOUND;
    FETCH dep_curs INTO dep_rec;
    DBMS_OUTPUT.PUT_LINE('depid = '||dep_rec.dept_id||'; dept_name = '||dep_rec.dept_name);
  END LOOP;
  IF (dep_curs%ISOPEN) THEN
    CLOSE dep_curs;
  END IF;
END;
/