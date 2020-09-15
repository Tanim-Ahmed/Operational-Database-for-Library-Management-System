--procedure to return the book--
create or replace procedure retrn(book_i varchar,mem_i number)
is
fine number(32);
memid number(20);
retrn_date date not null:='10-July-18';
dat varchar(10);
dd date;
begin
--only existence member can return the book--
select mem_id into memid from trans where mem_id = mem_id and book_id=book_i;
--update return_date with the current_date and calculate the find amount by finding differencing bet return and issue--
update trans set return_date='10-June-18' where book_id = book_i and mem_id = memid;
select due_date into dd from trans where book_id = book_i and mem_id = memid;
fine:=(retrn_date-dd);
dbms_output.put_line('Fine is ='||fine);
--update total_fine of that member by add this fine amount with the existing fine--
update member set total_fine=fine where mem_id  = memid;
--on saturday of friday no return of book--

select to_char(SYSDATE,'DY')into dat from dual;
if dat='SAT'
then
dbms_output.put_line('It is'||to_char(SYSDATE,'DAY')||'so you cannot return book.');
end if;
if dat='SUN'
then
dbms_output.put_line('It is'||to_char(SYSDATE,'DAY')||'so you cannot return book.');
end if;



--delete returning book information from the transition and move to history--
--used using trigger--
--create transaction_his as that of transaction table to record old date--
EXCEPTION
when NO_DATA_FOUND THEN
dbms_output.put_line('There is no book issued to this member');

end;
/
exec retrn(300,1);