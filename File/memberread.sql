set serveroutput on;
declare 
   f utl_file.file_type; 
   line varchar(1000);
   m_id member.mem_id%type;
   name member.mem_type%type;
   m_typ member.mem_type%type;
   bkt member.no_of_books_taken%type;
   tof member.total_fine%type;
   
   
   begin 
   f:=utl_file.fopen('MYDIRECTORY','member.csv','R');
   if utl_file.is_open(f) then
   utl_file.get_line(f,line,1000); 
   loop begin
   utl_file.get_line(f,line,1000);
   
   if line is null then exit;
   end if;
  m_id:=regexp_substr(line,'[^,]+',1,1);
   name:=regexp_substr(line,'[^,]+',1,2);
 m_typ:=regexp_substr(line,'[^,]+',1,3);
  bkt:=regexp_substr(line,'[^,]+',1,4);
 tof:=regexp_substr(line,'[^,]+',1,5);

   insert into member values(m_id,name,m_typ,bkt,tof);
   commit;
   exception 
   when no_data_found then exit;
  end;
  end loop ;
  end if;
  utl_file.fclose(f); 
  end;
  /
