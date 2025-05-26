CREATE DATABASE conservation_db;

-- Rangers Table --
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

SELECT * FROM rangers;

-- Species Table--
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        '1775-01-01',
        'Endangered'
    ),
    (
        'Bengal Tiger',
        'Panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda',
        'Ailurus fulgens',
        '1825-01-01',
        'Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

SELECT * FROM species;

-- sightings--
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER REFERENCES rangers (ranger_id),
    species_id INTEGER REFERENCES species (species_id),
    sighting_time TIMESTAMP,
    location VARCHAR(50),
    notes VARCHAR(50)
);

INSERT INTO
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        location,
        notes
    )
VALUES (
        1,
        1,
        '2024-05-10 07:45:00',
        'Peak Ridge ',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        '2024-05-12 16:20:00',
        'Bankwood Area',
        'Juvenile seen   '
    ),
    (
        3,
        3,
        '2024-05-15 09:10:00',
        'Bamboo Grove East',
        'Feeding observed  '
    ),
    (
        1,
        2,
        '2024-05-18 18:30:00',
        'Snowfall Pass ',
        NULL
    );

SELECT * FROM sightings;

-- Problem 1 ---
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem 2 --
SELECT COUNT(DISTINCT common_name) FROM species;

-- Problem 3 --
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- 4️⃣ List each ranger's name and their total number of sightings.
SELECT * FROM rangers;

SELECT * FROM sightings;

SELECT name AS ranger_name, count(*) AS total_sight
FROM sightings AS s
    JOIN rangers AS r ON s.ranger_id = r.ranger_id
GROUP BY
    name;

-- 5️⃣ List species that have never been sighted.
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- 6️⃣ Show the most recent 2 sightings.

SELECT * FROM sightings;
-- sighting time
SELECT * FROM species;
--Comon name
SELECT * FROM rangers;
--name

SELECT common_name, sighting_time, name
FROM
    sightings AS s
    INNER JOIN rangers AS r ON s.ranger_id = r.ranger_id
    INNER JOIN species AS sp ON sp.species_id = s.species_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
SELECT * FROM species;

UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        YEAR
        FROM species.discovery_date
    ) < 1800;