--database creating stage
CREATE DATABASE football_league;

USE football_league;

CREATE TABLE fixture (
    fixture_id SMALLINT PRIMARY KEY,
    year TINYINT,
    sequence_num TINYINT
);

CREATE TABLE city (
    city_id VARCHAR(10) PRIMARY KEY,
    city_name VARCHAR(30),
    country VARCHAR(50),
    continent VARCHAR(20)
);

CREATE TABLE stadium (
    stadium_id SMALLINT PRIMARY KEY,
    city_id VARCHAR(10),
    stadium_name VARCHAR(50),
    seating_capacity SMALLINT,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE round (
    round_id SMALLINT PRIMARY KEY,
    round_stage VARCHAR(30),
    round_num TINYINT,
    fixture_id SMALLINT,
    FOREIGN KEY (fixture_id) REFERENCES fixture(fixture_id)
);

CREATE TABLE match (
    match_id TINYINT PRIMARY KEY,
    match_date DATE,
    referee_id SMALLINT,
    round_id SMALLINT,
    FOREIGN KEY (referee_id) REFERENCES referee(referee_id),
    FOREIGN KEY (round_id) REFERENCES round(round_id)
);

CREATE TABLE referee (
    referee_id SMALLINT PRIMARY KEY,
    referee_firstname VARCHAR(50),
    referee_lastname VARCHAR(50),
    nationality VARCHAR(50)
);

CREATE TABLE team (
    team_id SMALLINT PRIMARY KEY,
    team_name VARCHAR(50),
    country VARCHAR(50),
    member_num TINYINT
);

CREATE TABLE sponsor (
    sponsor_id SMALLINT PRIMARY KEY,
    company_name VARCHAR(50),
    fund BIGINT,
    sponsor_type VARCHAR(30)
);

-- Create the schedule table
CREATE TABLE schedule (
    match_id TINYINT,
    team_id SMALLINT,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES match(match_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE sponsor_team (
    sponsor_id SMALLINT,
    team_id SMALLINT,
    PRIMARY KEY (sponsor_id, team_id),
    FOREIGN KEY (sponsor_id) REFERENCES sponsor(sponsor_id),
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);

CREATE TABLE fixture_city (
    fixture_id SMALLINT,
    city_id VARCHAR(10),
    PRIMARY KEY (fixture_id, city_id),
    FOREIGN KEY (fixture_id) REFERENCES fixture(fixture_id),
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);
