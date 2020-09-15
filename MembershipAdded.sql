--addition of a member--
set serveroutput on;
declare
member_name varchar(30);
member_type varchar(30);
no varchar(30);
id varchar(40);
begin
member_name:='&name';
member_type:='&type';

select MAX(mem_id)into no from member;
if no is not null then
id:=no+1;
else
id:=1;
end if;
insert into member values(id,member_name,member_type,0,0);
dbms_output.put_line('Mr/Mrs/Miss.'||member_name||' '||',your membership  id is'||' '||id);
end;
/