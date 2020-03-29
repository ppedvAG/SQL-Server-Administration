/*
Setup + First Settings nach Installation

Tuning im Setup von SQL 2019

MAXDOP
*/
--Experiment

use northwind;
GO

--wir erzeugen 1,1 Mio Zeilen

select * into ku from vku


insert into ku
select * from ku


select top 3 * from ku



--Umsatz pro Kunde
select customerid , sum(unitprice*quantity) from ku
group by customerid

--Messen
--HDD, RAM, CPU
--RAM-> HDD

--HDD entlasten!!

set statistics io, time on
--set statistics io, time off

--Anzahl der Seiten, Gesamte DAuer und CPU Anteil in ms
select customerid , sum(unitprice*quantity) from ku
group by customerid


-- logische Lesevorgänge: 43560
--, CPU-Zeit = 1015 ms, verstrichene Zeit = 260 ms.
--Frage: kann es denn sein, dass mehr CPU als Dauer gibt
-- ja wenn wir Paralellismus..

--im Plan taucht Paralel.. auf

--Gut oder schlecht? eigtl gut
--wenn ja , dann wieviele... ?

--mit 8 CPUs
--, CPU-Zeit = 1577 ms, verstrichene Zeit = 225 ms.

--, CPU-Zeit = 859 ms, verstrichene Zeit = 866 ms.


--Mit einer CPU dauert es länger
--mit mehr CPUs wird es schneller fertig
--aber wenn wir zuviele CPUS verwenden brauchen wir deutlich mehr CPU Leistung
--Fazit: man kommt mit weniger oft gleich schnell weg und braucht weniger CPU Leistung
--und hat sogar CPUs übrig

--Was wäre denn ein guter Ansatz

--OLTP: Kustenschwellwert: 25 
--MAXDOP: 50% der CPUs max 8

--Aufwand für Paralellismus kann man hier gut finden
select * from sys.dm_os_wait_stats
--CXPACKET.. SOS_Scheduler_YIELD





--MAXDOP: nie mehr als 8

/*

tempdb
soviele Dateien wie Kerne max 8 Stück
Uniform Extent
mehr HDDs und die DAteien abwechselnd auf die HDDs ablegt  (4 Dateien--> G: H: G: H:)


Min RAM wird erst garantiert wenn der Wert erreicht wurde
0  (= Taskmanger Max Arbeitssatz)

Max RAM  wird sofort limitiert
2,1 PB  (Gesamt - OS (2 bis 4GB / 10%)


INST1
7 GB


INST2
6 GB

10GB -OS --> 8 GB




*/