/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM `animals` WHERE name LIKE '%mon';
SELECT * FROM `animals` WHERE YEAR(date_of_birth) BETWEEN ('2016') AND ('2019');
SELECT * FROM `animals` WHERE (neutered= true AND escape_attempts < 3);
SELECT date_of_birth FROM `animals` WHERE (name= 'Agumon' OR name = 'Pikachu');
SELECT name, escape_attempts FROM `animals` WHERE (weight_kg> 10.5);
SELECT * FROM `animals` WHERE neutered = true;
SELECT * FROM `animals` WHERE NOT name = 'Gabumon';
SELECT * FROM `animals` WHERE weight_kg BETWEEN 10.4  AND 17.3

START TRANSACTION;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

START TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species is null;
COMMIT;

START TRANSACTION;
DELETE FROM animals;
ROLLBACK;

START TRANSACTION
DELETE FROM animals WHERE date_of_birth > "2022-01-01"
SAVEPOINT deleted_animals
UPDATE animals SET weight_kg = weight_kg * -1
ROLLBACK SAVEPOINT deleted_animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

--What animals belong to Melody Pond?
SELECT  * FROM animals
   INNER JOIN owners
   ON owners.id = animals.owner_id
   WHERE full_name LIKE '%Melody Pond%';
   
--List of all animals that are pokemon (their type is Pokemon).
SELECT  * FROM animals
   INNER JOIN species
   ON species.id = animals.species_id
   WHERE species.name LIKE '%Pokemon%';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT  * FROM animals
    LEFT JOIN owners
   ON owners.id = animals.owner_id

--How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals
    INNER JOIN species
   ON species.id = animals.species_id WHERE species.name LIKE '%Pokemon%';
SELECT  species.name, COUNT(*) FROM animals
    INNER JOIN species
   ON species.id = animals.species_id WHERE species.name LIKE '%Digimon%';

--List all Digimon owned by Jennifer Orwell.
   SELECT  * FROM animals
    INNER JOIN owners
   ON owners.id = animals.owner_id
    INNER JOIN species
    ON species.id = animals.species_id
    WHERE owners.full_name LIKE '%Jennifer Orwell%'
    AND species.name LIKE '%Digimon%';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT  * FROM animals
    INNER JOIN owners
   ON owners.id = animals.owner_id
    WHERE owners.full_name LIKE '%Dean Winchester%'
    AND escape_attempts <= 0;

--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) FROM animals 
INNER JOIN owners ON owners.id = animals.owner_id
GROUP BY owners.id
ORDER BY COUNT(animals.name) DESC
LIMIT 1;


--Who was the last animal seen by William Tatcher?
SELECT  vets.name, visits.visit_date FROM animals
    INNER JOIN visits
   ON visits.animal_id = animals.id
    INNER JOIN vets
   ON vets.id = visits.vets_id
   WHERE vets_id = 1
  GROUP BY visit_date
  ORDER BY visits.visit_date DESC
  LIMIT 1;


  -- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id),vets.name FROM animals
INNER JOIN visits ON visits.animal_id = animals.id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 3
GROUP BY vets.name

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name as "Vet Name" , species.name as "Specie Name" FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN species ON species.id = specializations.species_id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.visit_date FROM animals
INNER JOIN visits ON visits.animal_id =animals.id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 3 AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name, COUNT(animals.name) as "Number of Visit" FROM animals 
INNER JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.id
ORDER BY visits.visit_date ASC
LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name, visits.visit_date FROM animals
INNER JOIN visits ON visits.animal_id =animals.id
INNER JOIN vets ON vets.id = visits.vets_id
WHERE vets.id = 2 
ORDER BY visits.visit_date ASC
LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT 
 animals.name AS "Animal Name",
animals.weight_kg AS "Weight",
animals.escape_attempts AS "Escape Attemt",
vets.name AS "Vet Name",
vets.age AS "Vet Age",
vets.date_of_graduation AS "Vet Graduation Date",
species.name AS "Specie Name",
visits.visit_date AS "Visit Date" FROM visits
 INNER JOIN animals ON animals.id = visits.animal_id
 INNER JOIN vets ON vets.id = visits.vets_id
 INNER JOIN specializations ON specializations.vets_id = vets.id
 INNER JOIN species ON species.id = specializations.species_id
 ORDER BY visits.visit_date DESC;


--How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(*) FROM visits
JOIN vets ON visits.vets_id = vets.id
LEFT JOIN specializations ON specializations.vets_id = visits.vets_id
WHERE specializations.vets_id IS null
GROUP BY vets.name;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vets.name AS "Vets Name",
  species.name AS "Species name",
  COUNT(species.name) As "Count"
FROM visits
  INNER JOIN animals ON animals.id = visits.animal_id
  INNER JOIN vets ON vets.id = visits.vets_id
  INNER JOIN species ON species.id = animals.species_id
WHERE vets.id = 2
GROUP BY vets.name,
  species.name
ORDER BY species.name ASC
LIMIT 1;