create table Movies ( movie_id number(9) primary key, title varchar(20), year number(5), studio varchar(20));

create table Actors ( actor_id number(9) primary key, name varchar(20), nationality varchar(20));

create table StarsIn ( actor_id number(9), movie_id number(9), character varchar(20), primary key (actor_id, movie_id), foreign key (movie_id) references Movies, foreign key (actor_id) references Actors);

select M.title, M.studio from Movies M, Actors A, StarsIn S where M.movie_id = S.movie_id and A.actor_id = S.actor_id and A.name = 'Tom Hanks';

select name from Actors where nationality = 'US';

--find the nationalities of actors that worked for all studios
SELECT DISTINCT (a1.nationality) FROM Actors a1, ( SELECT a.actor_id, count(DISTINCT (m.studio)) studio_count, x.total_studio_count FROM Actors a, StarsIn s, Movies m, ( SELECT count(DISTINCT (studio)) total_studio_count FROM movies ) x WHERE a.actor_id = s.actor_id AND s.movie_id = m.movie_id GROUP BY a.actor_id, x.total_studio_count) Y WHERE a1.actor_id = Y.actor_id AND Y.studio_count = Y.total_studio_count;

--e Find for each year the number of distinct actors that played a character that starts with letter “G” and has at least three letters in the character name
SELECT m.year, count(DISTINCT  a.actor_id) FROM Actors a, Movies m, StarsIn s WHERE a.actor_id = s.actor_id and s.movie_id = m.movie_id and 
s.character LIKE 'G%' and length(s.character) > = 3 GROUP BY m.year ORDER BY m.year ASC;


--f Find the movie titles that are produced by “Universal” studio and in which there are at least ten
--actors starring


SELECT m.title, count(DISTINCT (a.actor_id)) FROM Actors a, movies m, StarsIn s WHERE a.actor_id = s.actor_id and s.movie_id = m.movie_id and m.studio = 'Universal' GROUP BY m.title HAVING count(DISTINCT (a.actor_id)) >= 10;

--g

select count(a.actor_id), a.nationality FROM Actors a, Movies m, StarsIn s WHERE a.actor_id = s.actor_id AND s.movie_id = m.movie_id and m.year = 2015 group by a.nationality;