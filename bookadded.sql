--addition of book in library--

declare
 book_name varchar(40);
author varchar(30);
price number(30);
no_of_books number(4);
book_id varchar(30);
begin
book_id:='&BKID';
book_name:='&bkname';
author:='&auth';
price:='&pe';
no_of_books:=&number_bk;
insert into book values(book_id,book_name,author,price,no_of_books);
end;
/