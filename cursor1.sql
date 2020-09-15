set serveroutput on;
declare
cursor c1 is select *from trans
for update of due_date;
begin
for c_rec in c1
loop
update trans
set due_date='20-July-2018'
where current of c1;
end loop;
end;
/