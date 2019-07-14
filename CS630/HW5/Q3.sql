SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION Zipcodeorders(givenzipcode IN VARCHAR) IS
O  orders%rowtype;
S Suppliers%rowtype;
ordervalue integer;
totalcount integer;
meanvalue integer;

cursor  ocursor is
select * from Orders O, Suppliers S, Parts P where S.sid = O.sid and P.pid = O.pid and S.zipcode = givenzipcode;

begin
partcost := 0;
ordervalue := 0;
sum := 0;
i := 0;

ordervalue := P.price*O.quantity;

open  ocursor;
totalcount := 0;
loop
     fetch  ocursor  into  O; 
     if S.zipcode = givenzipcode then
      totalcount := totalcount + 1;
	   sum := sum + ordervalue; 
     end if;
     if totalcount != 0 then
     meanvalue :=(sum/totalcount);
     end if;
     exit  when ocursor %notfound;
end  loop;
close ocursor;