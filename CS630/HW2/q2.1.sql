-- a) Write SQL declarations for creating the schemas. Include necessary key constraints.
--DROP TABLE Movies;
--DROP TABLE Actors;
--DROP TABLE StarsIn;

CREATE TABLE Movies (movie_id integer PRIMARY KEY,
                    		title varchar(20),
                    		year integer,
                    		studio varchar(20));

CREATE TABLE Actors (actor_id integer PRIMARY KEY,
                    		name varchar(20),
					nationality varchar(20));

CREATE TABLE StarsIn (actor_id integer,
                     	movie_id integer,
                      	character varchar(20),
                      	PRIMARY KEY(actor_id, movie_id),
                      	FOREIGN KEY (actor_id) REFERENCES Actors,
                      	FOREIGN KEY (movie_id) REFERENCES Movies);


-- b) Find the title and studio of movies starring actor ‘Tom Hanks’
SELECT M.title, M.studio
FROM Movies M, Actors A, StarsIn S
WHERE M.movie_id = S.movie_id AND A.actor_id = S.actor_id AND A.name='Tom Hanks';

-- c) Find the names of actors of ‘US’ nationality.
SELECT A.name
FROM Actors A
WHERE A.nationality='US';

-- d) ) Find the nationalities of actors that star in some movie for all producing studios (another way to
--phrase this is “find the nationalities of actors that worked for all studios”). Ensure that a
--nationality appears only once in the result.
SELECT DISTINCT A.nationality
FROM Actors A
WHERE NOT EXISTS (SELECT M.studio
		  FROM Movies M
                  MINUS
		  SELECT M1.studio
		  FROM Movies M1,  StarsIn S
                  WHERE M1.movie_id=S.movie_id AND A.actor_id=S.actor_id);

-- e) ) Find for each year the number of distinct actors that played a character that starts with letter “G”
--and has at least three letters in the character name
SELECT M.year, COUNT(DISTINCT (S.actor_id)) 
FROM   Movies M, StarsIn S
WHERE  M.movie_id=S.movie_id AND S.character LIKE 'G__%'
GROUP BY M.year;

-- f) ) Find the movie titles that are produced by “Universal” studio and in which there are at least ten
--actors starring
SELECT	 M.title
FROM	 Movies M, Actors A, StarsIn S
WHERE	 M.movie_id=S.movie_id AND A.actor_id=S.actor_id 
         AND M.studio='Universal'
GROUP BY M.movie_id, M.title
HAVING   COUNT(*)>=10;

-- g) ) [630 students only] Find the nationality (or nationalities) best-represented (i.e., nationality of
--most actors) among actors that starred in movies produced in year 2015

SELECT A1.nationality
FROM Movies M1, Actors A1, StarsIn S1
WHERE M1.movie_id = S1.Movie_id AND A1.actor_id = S1.actor_id
                              AND year = 2015
GROUP BY A1.nationality
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
				FROM Movies M2, Actors A2, StarsIn S2
				WHERE M2.movie_id = S2.movie_id 
						      AND A2.actor_id = S2.actor_id
 						      AND year=2015
				GROUP BY A2.nationality);
