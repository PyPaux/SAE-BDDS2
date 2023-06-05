DROP TABLE import;
CREATE TABLE import(ID int, Name text, Sex char(1), Age int, Height int, Weight float, Team text, NOC text, Games text, Year int, Season text, City text, Sport text, Event text, Medal text);
\copy import from athlete_events.csv delimiter ',' CSV HEADER NULL 'NA'
DELETE FROM import WHERE Year<1920 OR Sport='Art Competitions';
DROP TABLE regions;
CREATE TABLE regions(NOC char(3), region text, notes text);

\copy regions from noc_regions.csv delimiter ',' CSV HEADER

UPDATE import SET noc='SIN' WHERE noc='SGP';

\echo jeux
DROP TABLE jeux CASCADE;
CREATE TABLE jeux (
    ID_jeux SERIAL,
    year INT,
    city TEXT,
    season VARCHAR(6),
    CONSTRAINT pk_id_jeux PRIMARY KEY(ID_jeux)
);

\echo epreuves
DROP TABLE epreuves CASCADE;
CREATE TABLE epreuves(
    id_epreuves SERIAL,
    nom TEXT,
    sport TEXT,
    CONSTRAINT pk_epreuves PRIMARY KEY (id_epreuves)
);

\echo team
DROP TABLE team CASCADE;
CREATE TABLE team (
 NOC CHAR(3),
 nom TEXT,
 CONSTRAINT pk_team PRIMARY KEY(NOC)
);

\echo athlete
DROP TABLE athlete CASCADE;
CREATE TABLE athlete(
    ID_athlete INT UNIQUE, 
    name TEXT, 
    sex CHAR(1), 
    height INT, 
    weight INT, 
    CONSTRAINT pk_id_ath PRIMARY KEY(ID_athlete));

\echo participe
DROP TABLE participe CASCADE;
CREATE TABLE participe (
 NOC CHAR(3),
 ID_athlete INT,
 id_jeux INT,
 id_epreuves INT,
 age INT,
 medal TEXT,
 CONSTRAINT fk_team FOREIGN KEY (NOC) REFERENCES team(NOC),
 CONSTRAINT fk_epreuves FOREIGN KEY (id_epreuves) REFERENCES epreuves(id_epreuves),
 CONSTRAINT fk_ath FOREIGN KEY(ID_athlete) REFERENCES athlete(ID_athlete)
);

INSERT INTO jeux (year, city, season) (SELECT DISTINCT year, city, season FROM import ORDER BY year);

INSERT INTO epreuves (nom, sport) (SELECT DISTINCT event, Sport FROM import);

INSERT INTO team (SELECT DISTINCT NOC, region FROM import INNER JOIN regions USING(noc));

INSERT INTO athlete (SELECT DISTINCT ID, name, sex, height, weight FROM import);

INSERT INTO participe(
    SELECT DISTINCT import.NOC, athlete.ID_athlete, ID_jeux, id_epreuves, import.age, import.medal 
    FROM jeux INNER JOIN import USING(year, season) 
    INNER JOIN epreuves ON import.sport = epreuves.sport AND import.event=epreuves.nom 
    INNER JOIN athlete USING(name, height, weight));