/*
MAXDOP
Paralellit�t: Abfragen mehr CPUs verwenden k�nnen
Default: ab 5 SQL Dollar , alle CPUs verwendet
--Plan
--25 / 50

--HDD entlasten
--> IO senken --> RAM senken --> CPU senken

Massnahmen zur Entlastung des Datentr�gers
Partitionierung (physikalisch)

Part. Sicht (logische Ebene) --> Anw �nderung

Tabelle von Primary auf DGruppe oder Partitionierung (eigtl immer L�schen , ausser..)

IX bestehen aus Seiten und Bl�cke.. daher kann man Tabellen auch auf anderen HDDs schieben,
wemn man einen cl IX auf andere DGruppen oder PartSchemas legt..

Kompression: senkt IO und senkt den RAM
Seiten kommen 1:1 in RAM --> kostet CPUs

Indizes!!!--> SEEK Herauspicken
		  --> SCAN A bis Z 


HEAP: Tabel SCAN
CL IX: CL IX SCAN

CL IX SCAN vs TABLE SCAN.. egal gleich viel 
CLIX SCAN  vs  NCL IX SEEK ...SEEK
NCL IX SCAN  VS CL IX SCAN ... 

NCL IX SEEK --> CL IX  
vs
NCL IX --> HEAP


select * from orders

---------   1Std   100User
--Perfmon     10MB
--Profiler    1000MB

--Profiler gilt als depricated
--Xevents..














*/