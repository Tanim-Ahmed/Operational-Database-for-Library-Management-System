--member count

CREATE OR REPLACE FUNCTION totalmember  
RETURN number IS  
   total number(2) := 0;  
BEGIN  
   SELECT count(*) into total  
   FROM member;  
    RETURN total;  
END;  
/  

DECLARE  
   c number(2);  
BEGIN  
   c := totalmember();  
   dbms_output.put_line('Total no. of Member: ' || c);  
END;  
/  
--book issue
CREATE OR REPLACE FUNCTION totalbi 
RETURN number IS  
   total number(2) := 0;  
BEGIN  
   SELECT count(*) into total  
   FROM trans;  
    RETURN total;  
END;  
/  

DECLARE  
   c number(2);  
BEGIN  
   c := totalbi();  
   dbms_output.put_line('Today Total issueing book: ' || c);  
END;  
/  
