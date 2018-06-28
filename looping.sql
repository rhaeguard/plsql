-- simple loop examples
declare
  loop_cntr PLS_INTEGER := 0;
  loop_cntr_2 PLS_INTEGER := 10;
  loop_cntr_3 PLS_INTEGER := 10;
  
  guess PLS_INTEGER; -- guess value
begin
  dbms_output.put_line('List the numbers from 0 to 10');
  LOOP
    dbms_output.put_line('Counter = '||loop_cntr);
    loop_cntr := loop_cntr+1;
    IF loop_cntr > 10 THEN
      EXIT;
      -- or RETURN;
    END IF;
  END LOOP;
  dbms_output.put_line('-------------------------');
  
  dbms_output.put_line('List the even numbers from 10 to 0');
  LOOP
    IF (MOD(loop_cntr_2, 2)=0) THEN
      dbms_output.put_line(loop_cntr_2||' is even');
    END IF;
    loop_cntr_2 := loop_cntr_2-1;
    EXIT WHEN loop_cntr_2<0;
  END LOOP;
  
  dbms_output.put_line('-------------------------');
  
  dbms_output.put_line('Guess Game :: You win if guess > 95');
  LOOP
    dbms_output.put_line('You have '|| loop_cntr_3||' chances left');
    guess := dbms_random.value(1, 100);
    IF (guess > 95 ) THEN
      dbms_output.put_line('You have won! Guess was '||guess);
      EXIT;
    ELSE
      dbms_output.put_line('Ooops, You failed! Guess was '||guess);
    END IF;
    loop_cntr_3 := loop_cntr_3-1;
    EXIT WHEN loop_cntr_3=0;
  END LOOP;
  
  dbms_output.put_line('-------------------------');
  
end;
/