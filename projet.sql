-- Suppression des tables (si déjà créées.)
DROP TABLE Location CASCADE CONSTRAINTS;
DROP TABLE Tarifs CASCADE CONSTRAINTS;
DROP TABLE FormulesLocation CASCADE CONSTRAINTS;
DROP TABLE VehiculeVendu CASCADE CONSTRAINTS;
DROP TABLE Vehicule CASCADE CONSTRAINTS;
DROP TABLE Categories CASCADE CONSTRAINTS;

-- Création des tables.
CREATE TABLE Categories (	NoCat NUMBER(2) PRIMARY KEY,
			Categorie VARCHAR2(15) NOT NULL
			);

CREATE TABLE Vehicule(	NoVehicule NUMBER(5) PRIMARY KEY, 
			NoCat NUMBER(2) REFERENCES Categories(NoCat),
			Marque VARCHAR2(20) NOT NULL,
			Modele VARCHAR2(20) NOT NULL,
			Matricule CHAR(7) NOT NULL,
			DateMatricule DATE NOT NULL,
			Kilometrage NUMBER(6) NOT NULL,
			Situation VARCHAR2(10) DEFAULT 'disponible' CHECK(Situation IN ('disponible','loué','vendu'))
			);

CREATE TABLE VehiculeVendu (	
			NoVehicule NUMBER(5) PRIMARY KEY, 
			DateVente DATE NOT NULL
			);

CREATE TABLE FormulesLocation (	
			Formule VARCHAR2(30) PRIMARY KEY, 
			Duree NUMBER(2) NOT NULL,
			ForfaitKm NUMBER(4) NOT NULL
			);

CREATE TABLE Tarifs (	NoCat NUMBER(2) REFERENCES Categories(NoCat), 
			Formule VARCHAR2(30) REFERENCES FormulesLocation(Formule),
			PrixForfait NUMBER(7,2),
			PrixKmSupp NUMBER(4,2),
			PRIMARY KEY (NoCat, Formule)
			);

CREATE TABLE Location (	NoLocation NUMBER(5) PRIMARY KEY,
			NoVehicule NUMBER(5) REFERENCES Vehicule(NoVehicule),
			Formule VARCHAR2(30) REFERENCES FormulesLocation(Formule),
			DateDepart DATE NOT NULL,
			DateRetour DATE,
			NbKm NUMBER(5),
			Montant NUMBER(7,2)
			);

-- Insertion des données dans les tables
-- Insertion dans la table Catégories :
INSERT INTO Categories(NoCat, Categorie) VALUES (1, 'Citadine');
INSERT INTO Categories(NoCat, Categorie) VALUES (2, 'Berline');
INSERT INTO Categories(NoCat, Categorie) VALUES (3, 'Monospace');
INSERT INTO Categories(NoCat, Categorie) VALUES (4, 'Utilitaire-3m3');
INSERT INTO Categories(NoCat, Categorie) VALUES (5, 'Utilitaire-9m3');
INSERT INTO Categories(NoCat, Categorie) VALUES (6, 'Utilitaire-14m3');

-- Insertion dans la table FormulesLocation
INSERT INTO FormulesLocation VALUES('heure', 0, 30);
INSERT INTO FormulesLocation VALUES('jour', 1, 100);
INSERT INTO FormulesLocation VALUES('fin-semaine', 2, 200);
INSERT INTO FormulesLocation VALUES('semaine', 7, 1000);
INSERT INTO FormulesLocation VALUES('mois', 30, 3000);

-- Insertion dans la table Tarifs
INSERT INTO Tarifs VALUES(1, 'jour', 39, 0.3);
INSERT INTO Tarifs VALUES(1, 'fin-semaine', 69, 0.3);
INSERT INTO Tarifs VALUES(1, 'semaine', 199, 0.3);
INSERT INTO Tarifs VALUES(1, 'mois', 499, 0.3);
INSERT INTO Tarifs VALUES(2, 'jour', 59, 0.4);
INSERT INTO Tarifs VALUES(2, 'fin-semaine', 99, 0.4);
INSERT INTO Tarifs VALUES(2, 'semaine', 299, 0.4);
INSERT INTO Tarifs VALUES(2, 'mois', 799, 0.4);
INSERT INTO Tarifs VALUES(3, 'jour', 69, 0.4);
INSERT INTO Tarifs VALUES(3, 'fin-semaine', 129, 0.4);
INSERT INTO Tarifs VALUES(3, 'semaine', 499, 0.4);
INSERT INTO Tarifs VALUES(3, 'mois', 1099, 0.4);
INSERT INTO Tarifs VALUES(4, 'heure', 12, 0.3);
INSERT INTO Tarifs VALUES(4, 'jour', 39, 0.3);
INSERT INTO Tarifs VALUES(4, 'fin-semaine', 79, 0.3);
INSERT INTO Tarifs VALUES(4, 'semaine', 199, 0.3);
INSERT INTO Tarifs VALUES(4, 'mois', 599, 0.3);
INSERT INTO Tarifs VALUES(5, 'jour', 49, 0.4);
INSERT INTO Tarifs VALUES(5, 'fin-semaine', 99, 0.4);
INSERT INTO Tarifs VALUES(5, 'semaine', 259, 0.4);
INSERT INTO Tarifs VALUES(5, 'mois', 899, 0.4);
INSERT INTO Tarifs VALUES(6, 'jour', 79, 0.45);
INSERT INTO Tarifs VALUES(6, 'fin-semaine', 159, 0.45);
INSERT INTO Tarifs VALUES(6, 'semaine', 359, 0.45);
INSERT INTO Tarifs VALUES(6, 'mois', 1199, 0.45);
-- Validation
COMMIT;
-- Remarque :
-- Insertion dans les autres tables par les procédures demandées ou par les scripts de tests.