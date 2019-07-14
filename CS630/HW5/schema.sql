Drop Table Orders;
Drop Table Parts;
Drop Table Suppliers;

CREATE TABLE Parts (pid NUMBER primary key, pname varchar(20), year NUMBER, price NUMBER);
CREATE TABLE Suppliers ( sid integer primary key, sname varchar(20), state varchar(20), zipcode varchar(20));

CREATE TABLE Orders ( pid integer, sid integer, PRIMARY KEY(pid, sid), foreign key (pid) references Parts, foreign key (sid) references Suppliers );

INSERT INTO Parts(pid, pname, year, price) VALUES (1, 'buck', 1986, 10);
INSERT INTO Parts(pid, pname, year, price) VALUES (2, 'stove', 1987, 12);
INSERT INTO Parts(pid, pname, year, price) VALUES (3, 'Dam', 1989, 14);
INSERT INTO Parts(pid, pname, year, price) VALUES (4, 'Engine', 1991, 16);
INSERT INTO Parts(pid, pname, year, price) VALUES (5, 'Belt', 1998, 17);
INSERT INTO Parts(pid, pname, year, price) VALUES (6, 'Screw', 1999, 20);


INSERT INTO Suppliers(sid, sname, state, zipcode) values (1, 'chaitanya', 'm', '02452');
INSERT INTO Suppliers(sid, sname, state, zipcode) values (4, 'Sam', 'nh', '30');


INSERT INTO Orders(pid, sid) values (1, 4);
INSERT INTO Orders(pid, sid) values (2, 4);
INSERT INTO Orders(pid, sid) values (1, 1);
INSERT INTO Orders(pid, sid) values (2, 1);