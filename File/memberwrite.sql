set serveroutput on
declare
    f utl_file.file_type;
    cursor c is select * from member;
     
begin
    f :=utl_file.fopen('MYDIRECTORY', 'member_write.csv', 'w');
    utl_file.put(f, 'MEM_ID' || ',' ||  'MEM_Name' || ',' || 'MEM_TYPE'|| 'NO_OF_BOOKS_TAKEN'|| 'TOTAL_FINE');
    utl_file.new_line(f);
    for c_record in c
    
        loop
             utl_file.put(f, 'c_record.mem_id' || ',' ||  'c_record.mem_name' || ',' || 'c_record.mem_type'|| 'c_record.no_of_books_taken'|| 'c_record.total_fine');
             utl_file.new_line(f);
             end loop;
    
    utl_file.fclose(f);
   end;
    /