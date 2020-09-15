describe member;
describe book;
describe trans;

select *from member;
select *from book;
select *from trans;

alter table book add newcol varchar(12);
alter table book modify newcol varchar(20);
alter table book rename column newcol to newcol1;
alter table book drop column newcol1;
 select *from book where book_name like '%l';
 select *from book where book_name like '%m';
  select *from member where mem_name like 'Ta%';
   select *from member where mem_name like '%Ta%';
   
   select book_id,price,book_name from book order by price;
     select book_id,price,book_name from book order by price asc;
       select book_id,price,book_name from book order by price desc;
       
       select count(*)from trans;
       select count(price) as book_price from book;
       
       
       select count(distinct book_name ) as name_of_book from book;

select mem_name,mem_type as member_type from member;







select sum(price) as total_price from book;
select max(price) from book;
select min(price) from book;



select mem_id,mem_name from member where mem_id in(select mem_id from trans where issue_date ='2-June-18');
select mem_id,mem_name from member where mem_id in(select mem_id from trans where book_id =500);
select mem_id,return_date from trans where mem_id in(select mem_id from member where mem_id in (select mem_id from trans where due_date = '2-July-18'));


select *from member natural join trans;


select *from book inner join trans on book.book_id = trans.book_id;
select *from book left join trans on book.book_id = trans.book_id;
select *from book full join trans on book.book_id = trans.book_id;

       