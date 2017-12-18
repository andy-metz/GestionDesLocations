------------------------------------------------------
-- Test pour l'évaluation du projet IMPAIR --
------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
ca NUMBER;
fa VARCHAR2(150);
BEGIN
DBMS_OUTPUT.PUT_LINE('Début du test IMPAIR');
-- Attention :
----------------
-- Il faut supprimer et recréer la séquence pour la numérotation automatique des locations
-- La séquence doit débuter à 101.
--
DROP SEQUENCE seqLoc;
CREATE SEQUENCE seqLoc START WITH 101 INCREMENT BY 1;


-- Suppression des données
DELETE FROM Location;
DELETE FROM VehiculeVendu;
DELETE FROM Vehicule;
-- Saisie des véhicules
--------------------------
  INSERT INTO Vehicule VALUES(1,1,'RENAULT','CLIO4','EA001EA','01/01/2017',14000,'disponible');
  INSERT INTO Vehicule VALUES(2,1,'PEUGEOT','208','EA002EA','01/02/2017',15000,'disponible');
  INSERT INTO Vehicule VALUES(3,1,'CITROEN','C3','EB003EB','01/03/2017',10000,'disponible');
  INSERT INTO Vehicule VALUES(4,2,'AUDI','A4','EB004EB','01/04/2017',15000,'disponible');
  INSERT INTO Vehicule VALUES(5,2,'VOLKSWAGEN','PASSAT','EC005EC','01/05/2017',12000,'disponible');
  INSERT INTO Vehicule VALUES(6,2,'PEUGEOT','508','EC006EC','01/06/2017',9000,'disponible');
  INSERT INTO Vehicule VALUES(7,3,'CITROEN','PICASSO','EF007EF','01/07/2017',3000,'disponible');
  INSERT INTO Vehicule VALUES(8,3,'RENAULT','SCENIC','EF008EF','01/07/2017',4000,'disponible');
  INSERT INTO Vehicule VALUES(9,3,'PEUGEOT','5008','EG009EG','01/09/2017',1000,'disponible');
  INSERT INTO Vehicule VALUES(10,4,'RENAULT','KANGOO','DA010DA','01/09/2016',20000,'disponible');
  INSERT INTO Vehicule VALUES(11,5,'FORD','TRANSIT','DA011DA','01/10/2016',25000,'disponible');
  INSERT INTO Vehicule VALUES(12,6,'FIAT','DUCATO','DB012DB','01/11/2016',15000,'disponible');
  COMMIT;
--
-- procedure : LouerVehicule
-----------------------------------
  LouerVehicule(1,'jour',SYSDATE,SYSDATE+1);
  LouerVehicule(2,'mois',SYSDATE,SYSDATE+30);
  LouerVehicule(4,'jour',SYSDATE,SYSDATE+1);
  LouerVehicule(7,'semaine',SYSDATE,SYSDATE+7);
  LouerVehicule(10,'fin-semaine',TO_DATE('3/11/2017 18:00','DD/MM/YYYY HH24:MI'),TO_DATE('6/11/2017 8:00','DD/MM/YYYY HH24:MI'));
  LouerVehicule(11,'semaine',SYSDATE,SYSDATE+7);
-- Pour faire une deuxième location sur le même véhicule
  RetournerVehicule(1,SYSDATE+1,110);
  LouerVehicule(1,'jour',SYSDATE+2,SYSDATE+3);
--Erreur : DateRetour < DateDepart
  LouerVehicule(8,'jour',SYSDATE,SYSDATE-1);
--Erreur : Véhicule en location dans la période
  LouerVehicule(2,'semaine',SYSDATE+1,SYSDATE+8);
--
-- procedure : ConsulterLocation
----------------------------------------
  ConsulterLocation(106);
-- Location inexistante
  ConsulterLocation(0);
--
-- procedure : RetournerVehicule
----------------------------------------
  RetournerVehicule(1,SYSDATE+3,120);
  RetournerVehicule(4,SYSDATE+1,100);
  RetournerVehicule(7,SYSDATE+7,900);
--Erreur: Pas de location en cours pour ce véhicule
  RetournerVehicule(4,SYSDATE+1,100);
--Erreur: Pas de véhicule
  RetournerVehicule(0,SYSDATE+1,110);
--
-- Vérifier le cacul du Montant de la location
  ConsulterLocation(101);
  ConsulterLocation(107);
--
-- fonction : ChiffreAffaires
-----------------------------
  SELECT ChiffreAffaires('jour',1) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' jour - 1 : '||TO_CHAR(ca));
  SELECT ChiffreAffaires(null,1) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' null - 1 : '||TO_CHAR(ca));
  SELECT ChiffreAffaires('jour',null) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' jour - null : '||TO_CHAR(ca));
  SELECT ChiffreAffaires(null,null) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' null - null : '||TO_CHAR(ca));
--Erreur : Formule inconnue
  SELECT ChiffreAffaires('week-end',2) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' week-end - 2 : '||TO_CHAR(ca));
--Erreur: Catégorie inconnue
  SELECT ChiffreAffaires(null,0) INTO ca FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' null - 0 : '||TO_CHAR(ca));
--
-- fonction : FormuleAvantageuse
--------------------------------
  SELECT FormuleAvantageuse(2,1,300) INTO fa FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' Formule avantageuse : '||fa);
  SELECT FormuleAvantageuse(14,5,1500) INTO fa FROM Dual;
  DBMS_OUTPUT.PUT_LINE(' Formule avantageuse : '||fa);
--
  DBMS_OUTPUT.PUT_LINE('Fin du test');
END;