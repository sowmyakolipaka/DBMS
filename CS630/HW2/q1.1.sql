-- a)
--DROP TABLE Works;
--DROP TABLE Department;
--DROP TABLE Employee;

CREATE TABLE Employee (eid integer PRIMARY KEY,
                    		ename varchar(20),
                    		age integer,
                    		salary number(8,2));

CREATE TABLE Department (did integer PRIMARY KEY,
                    		dname varchar(20),
					budget number(8,2),
                    		managerid integer,
					FOREIGN KEY (managerid) REFERENCES Employee(eid));

CREATE TABLE Works (eid integer,
                     	did integer,
                      	pct_time integer,
                      	PRIMARY KEY(eid, did),
                      	FOREIGN KEY (eid) REFERENCES Employee,
                      	FOREIGN KEY (did) REFERENCES Department);

-- b) Find the salaries of employees that work in a department whose name starts with ‘Mar’.
SELECT E.salary
FROM Employee E, Works W, Department D
WHERE D.did = W.did AND W.eid = E.eid AND D.dname LIKE 'Mar%';

-- c) ) Find the ages of employees who work at least 30% of their time in a single department. List each
--age only once.

SELECT DISTINCT E.age
FROM Employee E, Works W
WHERE E.eid = W.eid AND W.pct_time >= 30;

-- d) Find the salaries of employees who work only in departments that have budget more than
--$500,000. List each salary value only once.

SELECT DISTINCT E.salary
FROM Employee E, Works W
WHERE E.eid = W.eid AND E.eid NOT IN (
			  SELECT W1.eid
                   	  FROM Works W1, Department D1
			  WHERE W1.did=D1.did AND D1.budget <= 500000
		          );

-- e) ) Find the names of employees who are managers
SELECT E.ename
FROM Employee E, Department D
WHERE E.eid = D.managerid;

-- f) Find the average salary over all employees.
SELECT AVG(E.salary)
FROM Employee E;

-- g) --g Find the ages of employees who work at least 10% of their time in a department called ‘Catering’
--but who do not work in any department with budget higher than $500,000

SELECT E.age
FROM Employee E, Works W, Department D
WHERE E.eid = W.eid AND W.did = D.did
      AND D.dname = 'Catering' 	AND W.pct_time >= 10 
      AND E.eid NOT IN (
                  SELECT W1.eid
                  FROM Works W1, Department D1
		  WHERE W1.did=D1.did AND D1.budget > 500000
		  );

-- h) Find the names of employees who work in all departments with budget higher than $500,000.

SELECT E.ename
FROM Employee E
WHERE NOT EXISTS (
	SELECT D.did FROM Department D WHERE D.budget > 500000
	MINUS
	SELECT W.did FROM Works W WHERE W.eid = E.eid);	


-- i) Find the average salary over all employees.
SELECT D.dname
FROM Department D
WHERE D.budget = (SELECT MAX(D1.budget) FROM Department D1);

-- j)  Find the maximum salary among employees 30 years old or younger for each department with at
--least 10 employees of any age. 

SELECT D.did, MAX(E.salary)
FROM Employee E, Works W, Department D
WHERE E.eid = W.eid AND W.did = D.did AND E.age <= 30
GROUP BY D.did
HAVING 10 <= (SELECT COUNT(*) FROM Works W1 WHERE W1.did=D.did);

-- k) Find for each manager (listed in the output by eid) the average salary of employees working for
--that manager.

SELECT D.managerid, AVG(E.salary)
FROM Employee E, Works W, Department D
WHERE E.eid = W.eid AND W.did = D.did
GROUP BY D.managerid;

-- l) Find the average age of employees for each department where every employee is 30 years old or
--younger.
SELECT D.did, AVG(E.age)
FROM Employee E, Works W, Department D
WHERE E.eid = W.eid AND W.did = D.did
GROUP BY D.did
HAVING 0 = (
	SELECT COUNT(*) 
	FROM Employee E1, Works W1
	WHERE E1.eid=W1.eid AND W1.did = D.did AND E1.age > 30
	);

-- m) Find the name(s) of department(s) who have the highest average employee age.

SELECT TMP.dname
FROM (
	SELECT D.did, D.dname, AVG(E.age) AS avgage
	FROM Employee E, Works W, Department D
	WHERE E.eid = W.eid AND W.did = D.did
	GROUP BY D.did, D.dname
	) TMP
WHERE TMP.avgage = (
	SELECT MAX(TMP2.avgage) FROM
		(
		SELECT D.did, D.dname, AVG(E.age) AS avgage
		FROM Employee E, Works W, Department D
		WHERE E.eid = W.eid AND W.did = D.did
       		GROUP BY D.did, D.dname
		) TMP2
	);


-- n)  Find the age(s) that most employees have, i.e., best represented age(s) among
--employees that work in departments with budget larger than $300,000. If an employee works in
--multiple such departments, his/her age is only counted once.


SELECT temp.age
FROM (SELECT E.age, COUNT(DISTINCT E.eid) AS count
      FROM Employee E, Works W, Department D
      WHERE E.eid = W.eid AND W.did = D.did AND D.budget > 300000
      GROUP BY E.age) temp
WHERE temp.count = (SELECT MAX(temp2.count)
      FROM (SELECT E.age, COUNT(DISTINCT E.eid) AS count
      	 FROM Employee E, Works W, Department D
      	 WHERE E.eid = W.eid AND W.did = D.did AND D.budget > 300000
      	 GROUP BY E.age) temp2
      );




-- o) [630 students only] Find the average salary among employees that work in all departments whose
--names starts with ‘Ca’.
SELECT AVG(E.salary)
FROM Employee E
WHERE E.eid IN
	(
	SELECT E1.eid FROM Employee E1
	WHERE NOT EXISTS(
		SELECT D.did FROM Department D
			WHERE D.dname LIKE 'Ca%'
		MINUS
		SELECT W.did FROM Works W
			WHERE W.eid = E1.eid
	)
	);
