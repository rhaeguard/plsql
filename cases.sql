DECLARE
  TYPE person IS RECORD (
    nname VARCHAR2(15),
    height INTEGER(3),
    weight INTEGER(3),
    bmi NUMBER(4,2)
  );
  TYPE people IS TABLE OF person;
  person1 person;person2 person;person3 person;
  ppeople people;
  intmdtTemp NUMBER(4,2);
BEGIN
  person1.nname:='Faora';person1.height:=162;person1.weight:=43;
  person2.nname:='Doe';person2.height:=189;person2.weight:=76;
  person3.nname:='Blur';person3.height:=200;person3.weight:=89;
  ppeople := people(person1, person2, person3);
  
  FOR ii IN ppeople.first..ppeople.last LOOP
    ppeople(ii).bmi := ppeople(ii).weight/(ppeople(ii).height*ppeople(ii).height*0.0001);
  END LOOP;
  
  FOR ii IN ppeople.first..ppeople.last LOOP
    intmdtTemp := ppeople(ii).bmi;
    CASE
      WHEN intmdtTemp<=18.5 THEN
        DBMS_OUTPUT.PUT_LINE(ppeople(ii).nname ||' is underweight!');
      WHEN (intmdtTemp>18.5) AND (intmdtTemp<=24.9) THEN
        DBMS_OUTPUT.PUT_LINE(ppeople(ii).nname ||' is normal!');
      WHEN (intmdtTemp>=25) AND (intmdtTemp<=29.9) THEN
        DBMS_OUTPUT.PUT_LINE(ppeople(ii).nname ||' is overweight!');
      ELSE
        DBMS_OUTPUT.PUT_LINE(ppeople(ii).nname ||' is obese!');
    END CASE;
  END LOOP;
END;
/