declare
  prime_count INTEGER := 0;
  
  outr_cnt INTEGER;
  intmdtTmp INTEGER;
  intmdtTmp_2 INTEGER;
  intmdtBool BOOLEAN := false;
  str VARCHAR2(10) := '';
  
  summ INTEGER := 0;
begin
  dbms_output.put_line('For loop in range [1, 10]');
  <<optional_loop_label>>
  FOR counter IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE('counter : '||counter);
  END LOOP optional_loop_label;
  DBMS_OUTPUT.PUT_LINE('===================================');
  
  dbms_output.put_line('Prime nums in range [1, 20]');
  <<prime_finder>>
  FOR numm IN 1..20 LOOP
    FOR num_in IN 1..numm LOOP
      IF (MOD(numm, num_in)=0) THEN
        prime_count := prime_count+1;
      END IF;
    END LOOP;
    IF (prime_count=2) THEN
      DBMS_OUTPUT.PUT_LINE(numm||' is prime');
    END IF;
    prime_count := 0;
  END LOOP prime_finder;
  DBMS_OUTPUT.PUT_LINE('===================================');
  
  dbms_output.put_line('Pyramid!');
  outr_cnt := 5;
  <<outer_pyramid>>
  FOR ii IN 1..outr_cnt LOOP
    intmdtTmp_2 := ii*2-1;
    intmdtTmp := ((outr_cnt*2-1)-intmdtTmp_2)/2;
    FOR jj IN 1..intmdtTmp LOOP
      str := str || ' ';
    END LOOP;
    
    FOR kk IN intmdtTmp+1..((outr_cnt*2-1)-intmdtTmp) LOOP
      IF (intmdtBool) THEN
        str := str || ' ';
        intmdtBool := false;
      ELSE
        str := str || ii;
        intmdtBool := true;
      END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(str);
    str := '';
    intmdtBool := false;
  END LOOP outer_pyramid;
  
  DBMS_OUTPUT.PUT_LINE('===================================');
  
  DBMS_OUTPUT.PUT_LINE('Perfect Numbers in range of [1;500]');
  <<outloop>>
  FOR mm IN 1..500 LOOP
    <<inloop>>
    FOR nn IN 1..mm-1 LOOP
      IF (MOD(mm, nn)=0) THEN
        summ := summ + nn;
      END IF;
    END LOOP inloop;
    
    IF (summ=mm) THEN
      dbms_output.put_line(mm||' is a perfect number!');
      summ := 0;
    ELSE
      summ := 0;
      CONTINUE;
    END IF;
  END LOOP outloop;
end;
/