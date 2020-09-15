--Procedure to issue the book to the member--

--procName::issue--
--parameter:book_no,mem_id---
set serveroutput on;
create or replace procedure issue(book_i varchar,mem_i number)
is
a boolean default false;
b boolean default false;
c boolean default false;
d boolean default false;
mep number(4);
tep number(4);
sep number(5);
bep number(4);
mb number(5);
dat varchar(10);
typ varchar(10);
expiry_date date;
ddate date;
begin
--book No must be a valid book_id from the book_table or this wiil create error--
select count(*) into tep from book where book_id = book_i;
if tep = 1
then
dbms_output.put_line('The book(book id)'||' '||book_i||' '||'exists in the library');
else
dbms_output.put_line('The book(book id)'||''||book_i||' '||'does not exists in the library');
end if;

--member id checking through a mem_id from member table--

select count(*)into mep from member where mem_id = mem_i;
if mep = 1
then
dbms_output.put_line('Welcome member id'||' '||mem_i||' '|| 'you are a member of the library');
else
dbms_output.put_line('Sorry the member id '||' '||mem_i||' '||'does not found in the database please register');

end if;

--the same member cann't borrow the same book without returning it--
select count(*) into sep from trans where book_id  = book_i and mem_id = mem_i and return_date is null;
if sep = 1
then 
dbms_output.put_line('You already have taken this book from library');
end if;

--if the due date is crossing the expiry date of the member,doesn't issue the book--
select mem_type into typ from member where mem_id = mem_i;
expiry_date:=add_months(ROUND(SYSDATE,'MONTH'),1);
ddate:=ROUND(SYSDATE,'YEAR');
if typ='M'
then
if expiry_date<SYSDATE+7
then 
if expiry_date<SYSDATE+7

then
a:=true;
dbms_output.put_line('Your membership expiry date'||' '||expiry_date||'is before the due date '||SYSDATE+7);
end if;

elsif typ='Y'
then
 if ddate<SYSDATE+7
 then
 a:=true;
 dbms_output.put_line('Your membership expiry date'||expiry_date||'is before due date'||SYSDATE+7);
 end if;
 elsif typ='L'
 then
 dbms_output.put_line('You have lifetime membership');
 end if;
 end if;
 --if the number_of_books_taken exceeds--
 select no_of_books_taken into mb from member where mem_id = mem_i;
 if typ ='M'
 then
 if mb>=3
 then
 b:=true;
 dbms_output.put_line('You have reached the limit of 4 books');
 end if;
 elsif typ='Y'
 then
 if mb>=2
 then 
 b:=true;
 dbms_output.put_line('You have reached the limit of taken books');
 end if;
 elsif typ='L'
 then
 if 
 mb>=6
 then
 b:=true;
 dbms_output.put_line('You have reached the limit');
 end if;
 end if; 
 --if the book is not available in the library store--
 select no_of_books into bep from book where book_id = book_i;
 if bep>=1
 then
 d:=true;
 dbms_output.put_line('The book is available in the library');
 else
 dbms_output.put_line('The book is not available at this moment');
 end if;
   --if all vallidation if fullfilled,then enter into transaction table book_id mem_id..issue wii be sysdate and due_date is 7 return date is null and fine is null--
if(tep is not null and mep is not null and b is not null and a is not null and d is not null and c is not null)
then
insert into trans values(book_i,mem_i,SYSDATE,SYSDATE+7,NULL);
dbms_output.put_line('its working');
end if;

 


--on friday and saturday no issue of books--
select to_char(SYSDATE,'DY')into dat from dual;
if dat='FRI'
then
dbms_output.put_line('It is'||to_char(SYSDATE,'DAY')||'so cannot issue book');
elsif dat='SAT'
then
dbms_output.put_line('It is'||to_char(SYSDATE,'DAY')||'so cannot issue book');
else
c:=true;
dbms_output.put_line('It is'||to_char(SYSDATE,'DAY')||'so can issue book.');
end if;





 
end;
/
exec issue(300,1);