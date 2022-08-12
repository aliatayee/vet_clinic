/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
(null,'Agumon', '2020-02-03', 0, true, '10.23'),
(null,'Gabumon', '2018-11-15', 2, true, '8'),
(null,'Pikachu', '2021-01-07', 1, false, '15.04'),
(null,'Devimon', '2017-05-12', 5, true, '11'),
(null,'Charmander', '2020-02-08', 0, false, '-11'),
(null,'Plantmon', '2021-11-15', 2, true, '-5.7'),
(null,'Squirtle', '1993-04-02', 3, false, '-12.13'),
(null,'Angemon', '2005-06-12', 1, true, '-45'),
(null,'Boarmon', '2005-06-07', 7, true, '20.4'),
(null,'Blossom', '1998-10-13', 3, true, '17'),
(null,'Ditto', '2022-05-14', 4, true, '22');

INSERT INTO owners (id, full_name,age)
VALUES 
(null,'Sam Smith', '34'),
(null,'Jennifer Orwell', '19'),
(null,'Bob', '45'),
(null,'Melody Pond ', '77'),
(null,'Dean Winchester ', '14'),
(null,'Jodie Whittaker', '38');
INSERT INTO species (id, name)
VALUES 
(null,'Pokemon'),
(null,'Digimon');

UPDATE animals SET species_id = '2' WHERE name LIKE '%mon%';
UPDATE animals SET species_id = '1' WHERE species_id is null;
UPDATE animals SET owner_id = '1' WHERE name LIKE 'Agumon';
UPDATE animals SET owner_id = '2' WHERE name LIKE 'Gabumon' OR name LIKE 'Pikachu';
UPDATE animals SET owner_id = '3' WHERE name LIKE 'Devimon' OR name LIKE 'Plantmon';
UPDATE animals SET owner_id = '4' WHERE name LIKE 'Charmander' OR name LIKE 'Squirtle' OR name LIKE 'Blossom';
UPDATE animals SET owner_id = '5' WHERE name LIKE 'Angemon' OR name LIKE 'Boarmon';

INSERT INTO vets (id, name,age,date_of_graduation)
VALUES 
(null,'Vet William Tatcher',  45,  '2000-04-23'),
(null,'Vet Maisy Smith',  26, '2019-01-17'),
(null,'Vet Stephanie Mendez',  64, '1981-05-04'),
(null,'Vet Jack Harkness',  38,  '2008-06-08');
INSERT INTO specializations (vets_id, species_id)
VALUES 
(1,1),
(3,1),
(3,2),
(4,2);
INSERT INTO visits (vets_id, animal_id,visit_date)
VALUES 
(1,1,'2020-05-24'),
(3,1,'2020-07-22'),
(4,2,'2021-02-02'),
(2,3,'2020-01-05'),
(2,3,'2020-03-08'),
(2,3,'2020-05-14'),
(3,4,'2021-05-04'),
(4,5,'2021-02-24'),
(2,6,'2019-12-21'),
(1,6,'2020-08-10'),
(2,6,'2021-04-07'),
(3,7,'2019-09-29'),
(1,4,'2020-10-03'),
(1,4,'2019-11-04'),
(2,9,'2019-01-24'),
(2,9,'2019-05-15'),
(2,9,'2020-02-27'),
(2,9,'2020-08-03'),
(3,10,'2020-05-24'),
(1,10,'2021-01-11');
