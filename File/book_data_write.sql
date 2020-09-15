set serveroutput on
declare
    f utl_file.file_type;
    cursor c is select * from book;
     
begin
    f :=utl_file.fopen('MYDIRECTORY', 'book_data_write.csv', 'w');
    utl_file.put(f, 'Book_ID' || ',' ||  'Book_Name' || ',' || 'Author'|| 'Price'|| 'No_OF_BOOKS');
    utl_file.new_line(f);
    for c_record in c
    
        loop
             utl_file.put(f, 'c_record.book_id' || ',' ||  'c_record.book_name' || ',' || 'c_record.author'|| 'c_record.price'|| 'c_record.no_of_books');
             utl_file.new_line(f);
             end loop;
    
    utl_file.fclose(f);
   end;
    /