select salary from Employee where ename LIKE 'Mar%';

select distinct(E.age) from Employee E, Works W where W.pct_time>=30 and W.eid = E.eid ;

select E.salary from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and D.budget > $500000 ;

select E.ename from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and D.managerid = E.eid;

select avg(E.salary) from Employee E 