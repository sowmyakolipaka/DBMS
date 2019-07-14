SET SERVEROUTPUT ON

create or replace procedure (givenpid in integer, givensid in integer, givenquantity in integer) is
O  orders%rowtype;
P  parts%rowtype;
sum integer;
i integer;
previousvalue integer;
totalcount integer;
partcost integer;
pyear integer;
pname char;
ordervalue integer;
pidnew integer;
newprice integer;

cursor  ocursor  is   select  *  from orders;
cursor  pcursor  is   select  *  from  parts;
begin
partcost := 0;
ordervalue := 0;
sum := 0;
product := 0;
--pidnew := givenpid;

open pcursor;
loop
    fetch pcursor into P;
    if P.pid = givenpid then
	  pname  := P.pname;
      partcost := P.price;
      pyear  := P.year;
      
    end if;
    exit when pcursor %notfound;
end loop;

close pcursor;

ordervalue := partcost*givenquantity;

open  ocursor;
totalcount := 0;
loop
     fetch  ocursor  into  O; 
     if O.pid = givenpid then
       i := partcost*O.quantity;
      totalcount := totalcount + 1;
      sum := sum + i; 
     end if;
     if totalcount != 0 then
     previousvalue :=(sum/totalcount);
     end if;
     exit  when ordercursor %notfound;
end  loop;
close ordercursor;

if ordervalue <= (.75)*previousvalue then
  insert into orders(pid, sid, quantity) values(givenpid, givensid, givenquantity);
end if;
if givenquantity != 0 then
newprice := (.75)*previousvalue/givenquantity;
end if;
if ordervalue > (.75)*previousvalue then
  insert into parts(pid, pname, year, price) values(pidnew, pname, pyear, newprice);
  insert into orders(pid, sid, quantity) values(pidnew, givensid, givenquantity);
end if;

end; 