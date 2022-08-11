/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
CREATE TABLE animals (
    id integer NOT NULL AUTO_INCREMENT,
	name varchar(100),
	date_of_birth date,
	escape_attempts integer,
	neutered boolean,
	weight_kg decimal(10,2),
    PRIMARY KEY (id)
);
ALTER TABLE animals
ADD COLUMN species VARCHAR(15);

CREATE TABLE owners (
    id integer NOT NULL AUTO_INCREMENT ,
	full_name varchar(100),
	age int,
    PRIMARY KEY (id)
);
CREATE TABLE species (
    id integer NOT NULL AUTO_INCREMENT ,
	name varchar(100),
    PRIMARY KEY (id)
);

ALTER TABLE animals
DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id int,
ADD FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id int,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);
