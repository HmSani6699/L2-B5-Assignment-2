--1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

--2️⃣ Count unique species ever sighted.
SELECT COUNT(DISTINCT common_name) FROM species;

--3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--4️⃣ List each ranger's name and their total number of sightings.
SELECT name AS ranger_name, count(*) AS total_sight
FROM sightings AS s
    JOIN rangers AS r ON s.ranger_id = r.ranger_id
GROUP BY
    name;

--5️⃣ List species that have never been sighted.
SELECT common_name
FROM species
WHERE
    species_id NOT IN (
        SELECT species_id
        FROM sightings
    );

-- 6️⃣ Show the most recent 2 sightings.
SELECT common_name, sighting_time, name
FROM
    sightings AS s
    INNER JOIN rangers AS r ON s.ranger_id = r.ranger_id
    INNER JOIN species AS sp ON sp.species_id = s.species_id
ORDER BY s.sighting_time DESC
LIMIT 2;