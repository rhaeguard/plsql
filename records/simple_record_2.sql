DECLARE
    TYPE country_capital IS RECORD(
        country countries%rowtype,
        capital VARCHAR2(50)
    );
    country country_capital;
BEGIN
    country.country.country_name := 'Netherlands';
    country.capital := 'Amsterdam';
    dbms_output.put_line('Country : '|| country.country.country_name||', capital : '||country.capital);
END;