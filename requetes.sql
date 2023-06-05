-- EXERCICE 3

\echo Question 1
-- QUESTION 1
SELECT COUNT(*) AS Colonnes FROM information_schema.columns WHERE table_name = 'import';

\echo Question 2
-- QUESTION 2
SELECT COUNT(*) AS Lignes FROM import;

\echo Question 3
-- QUESTION 3
SELECT COUNT(*) AS Nb_Codes_NOC FROM regions;

\echo Question 4
-- QUESTION 4
SELECT COUNT(*) AS athletes_differents FROM (SELECT DISTINCT name FROM import) AS noms;

\echo Question 5
-- QUESTION 5
SELECT COUNT(*) AS Medailles_OR FROM import WHERE medal='Gold';

\echo Question 6
-- QUESTION 6
SELECT COUNT(*) AS Carl_Lewis FROM import WHERE name LIKE 'Carl Lewis%';

\echo Exercice 5
-- EXERCICE 5

-- QUESTION 1
\echo Question 1
SELECT NOC, COUNT(NOC) AS participations FROM participe GROUP BY NOC ORDER BY participations DESC;

-- QUESTION 2
\echo Question 2
SELECT NOC, COUNT(NOC) AS MédaillesOr FROM participe WHERE medal='Gold' GROUP BY NOC ORDER BY MédaillesOr DESC;

-- QUESTION 3
\echo Question 3
SELECT NOC, COUNT(NOC) AS Médailles FROM participe WHERE medal IS NOT NULL GROUP BY NOC ORDER BY Médailles DESC;

-- QUESTION 4
\echo Question 4
SELECT ID_athlete, athlete.name, COUNT(*) AS MédaillesOR FROM participe INNER JOIN athlete USING(ID_athlete) WHERE medal='Gold' GROUP BY ID_athlete, name ORDER BY MédaillesOR DESC;

-- QUESTION 5
\echo Question 5
SELECT NOC, COUNT(NOC) AS MédaillesOr FROM participe WHERE medal IS NOT NULL AND ID_jeux=(SELECT ID_jeux FROM jeux WHERE city='Albertville') GROUP BY NOC ORDER BY MédaillesOr DESC;

-- QUESTION 6
\echo Question 6
SELECT COUNT(DISTINCT p1.ID_athlete) FROM participe AS p1 INNER JOIN participe AS p2 USING(ID_athlete) WHERE p1.id_jeux<p2.id_jeux AND p1.NOC<>p2.NOC AND p2.NOC='FRA';

-- QUESTION 7
\echo Question 7
SELECT COUNT(DISTINCT p1.ID_athlete) FROM participe AS p1 INNER JOIN participe AS p2 USING(ID_athlete) WHERE p1.id_jeux<p2.id_jeux AND p1.NOC<>p2.NOC AND p1.NOC='FRA';

-- QUESTION 8
\echo Question 8
SELECT age, COUNT(age) FROM participe WHERE medal='Gold' GROUP BY age;

-- QUESTION 9
\echo Question 9
SELECT nom, COUNT(*) AS Médailles FROM epreuves INNER JOIN participe USING(id_epreuves) WHERE participe.age>50 AND medal IS NOT NULL GROUP BY nom ORDER BY Médailles DESC;

-- QUESTION 10
\echo Question 10
SELECT year, season, COUNT(DISTINCT participe.id_epreuves) AS NBépreuves FROM participe INNER JOIN jeux USING(id_jeux) GROUP BY year, season;

-- QUESTION 11
\echo Question 11
SELECT year, season, COUNT(DISTINCT participe.id_epreuves) AS NBépreuves FROM participe INNER JOIN jeux USING(id_jeux) INNER JOIN epreuves USING (id_epreuves) WHERE epreuves.nom LIKE '%Women%' GROUP BY year, season;

-- PAYS : VENEZUELA
-- SPORT : TENNIS DE TABLE

\echo Toutes les épreuves où le Venezuela a participé aux épreuves de tennis de tables
SELECT * FROM participe INNER JOIN team USING(NOC) INNER JOIN epreuves USING(id_epreuves) WHERE team.nom='Venezuela' AND epreuves.Sport='Table Tennis';

\echo Les noms des athlètes qui ont participé :
SELECT DISTINCT athlete.name FROM participe INNER JOIN team USING(NOC) INNER JOIN epreuves USING(id_epreuves) INNER JOIN athlete USING(ID_athlete) WHERE team.nom='Venezuela' AND epreuves.Sport='Table Tennis';

\echo Les années des participations pour chaque épreuve :
SELECT DISTINCT athlete.name, jeux.year, jeux.city FROM participe INNER JOIN jeux USING(id_jeux) INNER JOIN team USING(NOC) INNER JOIN epreuves USING(id_epreuves) INNER JOIN athlete USING(ID_athlete) WHERE team.nom='Venezuela' AND epreuves.Sport='Table Tennis';

\echo Médailles pour chaque participations :
SELECT DISTINCT athlete.name, jeux.year, jeux.city, participe.medal FROM participe INNER JOIN jeux USING(id_jeux) INNER JOIN team USING(NOC) INNER JOIN epreuves USING(id_epreuves) INNER JOIN athlete USING(ID_athlete) WHERE team.nom='Venezuela' AND epreuves.Sport='Table Tennis';
