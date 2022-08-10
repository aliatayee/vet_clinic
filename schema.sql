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