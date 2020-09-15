--trigger to move the date from the transaction to transaction_history table upon deletion---
create or replace trigger move_trigger
after delete or insert or update on trans
for each row
begin
insert into transition_history values(:old.book_id,:old.mem_id,:old.issue_date,:new.return_date);
end;
/