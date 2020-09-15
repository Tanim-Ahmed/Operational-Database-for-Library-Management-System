--cursor---
--findint the due date with respect to particular mem_id--
create or replace function findDueD(m_id in varchar)return 
date
is
 d date;
 cursor c1
 is
 select due_date from 
 trans where mem_id = m_id;
 begin
 open c1;
fetch c1 into d;
if c1%notfound then
 dbms_output.put_line('No record found');
 end if;
 close c1;
 return d;
 end;
 /
 select findDueD(5) from trans;
