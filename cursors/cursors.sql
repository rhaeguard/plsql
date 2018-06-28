/*CREATE TABLE department(
  dept_id NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
  dept_name VARCHAR2(25)
);

CREATE TABLE employee(
  emp_id NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
  emp_name VARCHAR2(15) NOT NULL,
  emp_salary NUMBER(5),
  dept_id NUMBER(10),
  CONSTRAINT dept_id_fk FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO department(dept_name) VALUES ('Accounting');
INSERT INTO department(dept_name) VALUES ('IT');

INSERT INTO employee(emp_name, emp_salary, dept_id) VALUES('John', 1000, 1);
INSERT INTO employee(emp_name, emp_salary, dept_id) VALUES('Jane', 3123, 2);
INSERT INTO employee(emp_name, emp_salary, dept_id) VALUES('Jake', 8732, 2);
INSERT INTO employee(emp_name, emp_salary, dept_id) VALUES('Ann', 23221, 2);

COMMIT;*/

DECLARE
  l_dept_name department.dept_name%TYPE;
BEGIN
  /*
    if the result of the select clause is more than 1 record and if we're trying to set them into a variable
    it will raise an error of 'exact fetch returns more than requested number of rows'
    if there's not any record retrieved, 'no data' error will be thrown
  */
  SELECT dept_name INTO l_dept_name FROM department WHERE dept_id > 1;
  -- %FOUND is an implicit cursor that returns true if any results have been returned
  -- %NOTFOUND is an implicit cursor that returns true if no result has been returned
  IF(SQL%FOUND) THEN
  -- %ROWCOUNT is an implicit cursor that returns, well, rowcount :)
    DBMS_OUTPUT.PUT_LINE('found = '||SQL%ROWCOUNT);
  END IF;
END;
/