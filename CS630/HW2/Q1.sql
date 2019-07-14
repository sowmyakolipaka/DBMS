
create table Employee ( eid number(9) primary key, ename varchar(20),age number(4,2), salary number(5));

create table Department ( did number(9) primary key, dname varchar(20), budget number(8), managerid number(9));

create table Works ( eid number(9), did number(9), primary key(eid,did), pct_time number(4,2), foreign key (eid) references Employee, foreign key (did) references Department);

--1b
select E.salary from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and dname LIKE 'Mar%';

--c
select distinct(E.age) from Employee E, Works W where E.eid = W.eid and W.pct_time>=30 ;

--d
select distinct(E.salary) from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and D.budget > 500000 ;

--e
select distinct(E.ename) from Employee E, Department D where D.managerid = E.eid;

--f
select avg(salary) from Employee;

--g Find the ages of employees who work at least 10% of their time in a department called ‘Catering’
--but who do not work in any department with budget higher than $500,000

select E.age from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and W.pct_time >= 10 and D.dname = 'Catering' and NOT EXISTS (select E1.eid FROM Department D1, Employee E1, Works W1 where E1.eid = W1.eid and W1.did = D1.did and E1.eid = E.eid and D1.Budget >= 500000);

--h Find the names of employees who work in all departments with budget higher than $500,000.

select E.ename from Employee E where NOT EXISTS ((select D.did FROM Department D where D.Budget > 500000) MINUS (select W.did from Works W where W.eid = E.eid));

--i
select D.dname from Department D where D.budget >= ALL(select budget from Department);


--j Find the maximum salary among employees 30 years old or younger for each department with at
--least 10 employees of any age. 


select max(E.salary), D.did from Employee E, Department D, Works W where E.eid = W.eid and W.did = D.did and E.age <= 30 group by W.did having 10 <= (select count(*) from Works W1 where W.did = W1.did);

--k Find for each manager (listed in the output by eid) the average salary of employees working for
--that manager.
select  E1.eid, avg(E.salary)  from  Employee E, Works W, Department D where W.eid = E.eid, D.did = W.did join employee e1 on e1.eid = d.managerid group by e1.eid;

--l

SELECT d2.dname, avg(e2.age) FROM employee e2, works w2, department d2, ( SELECT count(e.eid) AS emp_count, d.dname FROM employee e,works w, department d where w.eid = e.eid and d.did = w.did GROUP BY d.dname) x, (SELECT count(e1.eid) AS emp1_count, d1.dname FROM employee e1, works w1, department d1 where w1.eid = e1.eid and d1.did = w1.did and e1.age <= 30 GROUP BY d1.dname) y where w2.eid = e2.eid and  d2.did = w2.did and d2.dname = x.dname and y.dname = x.dname and  x.emp_count = y.emp1_count GROUP BY d2.dname;

 --m Find the name(s) of department(s) who have the highest average employee age.
 
select Temp.dname, Temp.avgage from (select D.dname, Avg(E.age) As avgage from Employee E, Works W, Department D 
where E.eid = W.eid and W.did = D.did group by D.dname)Temp where Temp.avgage = (select MAX(Temp.avgage) from Temp);
 
 
 --n ] Find the age(s) that most employees have, i.e., best represented age(s) among
--employees that work in departments with budget larger than $300,000. If an employee works in
--multiple such departments, his/her age is only counted once.

--o
SELECT e1.eid, avg(e1.salary) FROM employee e1, works w1, department d1, ( SELECT e.eid, count(DISTINCT (d.dname)) no_of_dep_emp_works, x.no_of_departments FROM employee e, works w, department d, ( SELECT count(did) no_of_departments FROM department ) x WHERE e.eid = w.eid AND w.did = d.did and e.ename LIKE 'Ca%' GROUP BY e.eid, x.no_of_departments ) y WHERE e1.eid = y.eid and y.no_of_dep_emp_works = y.no_of_departments GROUP BY e1.eid;

