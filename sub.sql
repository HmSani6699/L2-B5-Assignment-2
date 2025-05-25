CREATE DATABASE conservation_db;

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id),
    species_id INTEGER REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes VARCHAR(50)
)