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

-- 7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        YEAR
        FROM species.discovery_date
    ) < 1800;

-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) < 12 THEN 'MORNING'
        WHEN EXTRACT(
            HOUR
            FROM sighting_time
        ) >= 12
        AND EXTRACT(
            HOUR
            FROM sighting_time
        ) < 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM sightings;

-- 9 ️⃣ Delete rangers who have never sighted any species
DELETE FROM rangers AS r
WHERE
    r.ranger_id NOT in (
        SELECT ranger_id
        FROM sightings
    );