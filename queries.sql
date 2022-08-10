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