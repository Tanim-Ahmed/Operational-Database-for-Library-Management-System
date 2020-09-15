--A trigger to automatically increment and decrement the no_of_books from the member table upon issue and return--
create or replace trigger incr_trigger
after insert or update on trans
for each row
begin
if inserting then
update book
set no_of_books=no_of_books-1
where book_id =:NEW.book_id;
update member
set no_of_books_taken=no_of_books_taken+1
where mem_id=:NEW.mem_id;
elsif updating then
update book
set no_of_books=no_of_books+1
where book_id=:old.book_id;
update member
set no_of_books_taken=no_of_books_taken-1
where mem_id=:NEW.mem_id;
end if;
end;
/