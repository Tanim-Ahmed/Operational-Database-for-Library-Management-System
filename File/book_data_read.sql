set serveroutput on 
declare 
   f utl_file.file_type; 
   line varchar(1000);
   b_id book.book_id%type;
   name book.book_name%type;
   auth book.author%type;
   pri book.price%type;
   no book.no_of_books%type;
   
   
   begin 
   f:=utl_file.fopen('MYDIRECTORY','book.csv','R');
   if utl_file.is_open(f) then
   utl_file.get_line(f,line,1000); 
   loop begin
   utl_file.get_line(f,line,1000);
   
   if line is null then exit;
   end if;
  b_id:=regexp_substr(line,'[^,]+',1,1);
   name:=regexp_substr(line,'[^,]+',1,2);
 auth:=regexp_substr(line,'[^,]+',1,3);
  pri:=regexp_substr(line,'[^,]+',1,4);
 no:=regexp_substr(line,'[^,]+',1,5);

   insert into book values(b_id,name,auth,pri,no);
   commit;
   exception 
   when no_data_found then exit;
  end;
  end loop ;
  end if;
  utl_file.fclose(f); 
  end;
  /
