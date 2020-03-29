use northwind

select * into ku1 from ku

set statistics io, time on

--wieviele Seiten hat die Tabelle..

dbcc showcontig('ku1') --43561 Seiten .. 98.09% .. depricated

alter table ku1 add id int identity

select * from ku1 where id = 101

--jetzt  44197..98.01%

--wieso braucht die Abfrage mehr Seiten als die Tabell besitzt?

--die IDs sind einfach woanders gelandet-..

select * from ku1 where id = 101  --59385


select * from sys.dm_db_index_physical_stats	
	(db_id(), object_id('ku1'), NULL, NULL, 'detailed')

--forward Record counts 15188--der musss 0 werden.. und bleiben
--Idee Datensätze neu ablegen...


--CLIX auf Companyname--> pyhsikalische Neuablage
--CL IX : 44836 ..es gibt und wirds auch nie wieder geben: forward record counts

--Tabelle erscheint nun auch sortiert nach Firmenname

--Wo könnte das noch vorkommen...?


-- variable Felder varchar werden größer durch Daten
--row_overflow data

---Sperren: 

--in einer Tabelle A mit 1 MIO Zeilen wird ein! DS geändert...
--währenddessen kann aber niemand mit der Tabelle etwas tun


--in einer Tabelle B mit 1 MIO Zeilen wird ein! DS geändert...
--währenddessen kann man aber sehr wohl mit den andern Daten arbeiten

---> Indizes

-- Abfrage an Tabelle (groß) dauert nur wenige Sekunden
--Abfrage auf etwas kleinere Tavbelle dauert etwas länger
--falscher Index oder Statistiken


--INDIZES: Welche gibts, wie ist die Wartung!!



/*
 ! nicht gruppierter IX  zus. Menge in sortierter Form mit Sprungadressen
! gruppierten IX = Tabell in physik. sortierter Form 
--------------------
! eindeutigen IX
! zusammengesetzten IX
! IX mit eingeschl Spalten
! gefilterten IX
! abdeckenden IX: der ideale IX ..kein Lokkup oder Scan im Plan
! ind. Sicht
! part. IX ist dem ähnlich IX ähnlich
! realer hypoth IX  _dta_index_98094kjsdfh
---------------------
! Columnstore IX
*/

select city from ku1 where freight< 5 and city = 'Berlin'



select * from ku1 where id = 100 --59385

--reserviere CL IX für: Orderdate
set statistics io, time on
select id from ku1 where id = 100

--Lookup .. der kostet!!..also Lookup vermeiden
select id, city from ku1 where id < 100


--wg City Lookup
select id, city from ku1 where id < 100

--wir tun also die City mit in den IX

--jetzt wieder wg Country Lookup
select id, city, country from ku1 where id = 100

--
--zusammengesetzte IX dürfen nicht mehr als 16 Spalten haben oder max 900bytes pro Schlüssel

--besser für SELECT Spalten einen sog IX mit eingeschl Spalten erstellen
--denn diese SELECT Spalten belasten dann den IX Baum nicht



select country, sum(unitprice*quantity) from ku1
where productid = 61 and customerid = 'ALFKI'
group by country






select country, count(*) from ku1
group by country


create view vdemoxy
as
select country, count(*) as Anzahl from ku1
group by country

select * from vdemoxy --gleich schnell


alter view vdemoxy with schemabinding
as
select country, count_big(*) as Anzahl from dbo.ku1
group by country


--Test mit Prozedur
--Proz kompilieren den Plan bei der ersten Ausführung 
--mit dem ersten Parameter. Der Plan iwrd immer verwendet
--und es muss kene weiter Plananalyse/erstellung erledig werden
---..was aber , wenn der Plan für andere Parameter nicht ok ist...
--

USE NORTHWIND;
GO

create proc SuchID @id int
as
select * from ku1 where id <@id
GO


waitfor delay  '00:00:02'
exec SuchID 2
GO 10

--Das hier in einer 2ten Session laufen lassen
use northwind;
GO

waitfor delay  '00:00:45'
exec SuchID 1000000
GO 5

---Ende: wird die Proc zuerst mit IX Seek kompiliert , so wurden beim Scan
--gleich > 1 MIO Seiten gelesen....!!!! (tabelle hat nur ca 44000)


--COLUMNSTORE IX


--ku2 hat keine Indizes
select * into ku2 from ku1

--auch kein IX
select * into ku3 from ku1

select top 3 * from ku2

--Was könnte typische Abfrage sein.. where  + Berechhnung Summe pro zb ..Durchschnitt

--Umsatz pro Kunden , die wo Germany

set statistics io, time on
select month(orderdate),companyname, sum(unitprice*quantity) from ku2
where country = 'Germany'
group by month(orderdate),companyname
order by 1,2

--IX: NIX_
-- 1747--CPU-Zeit = 141 ms, verstrichene Zeit = 143 ms.



select month(orderdate),companyname, sum(unitprice*quantity) from ku3
where freight < 2---country = 'Germany'
group by month(orderdate),companyname
order by 1,2
--ku3 hat statt 430MB inkl IX nur 3,4 MB..real!!
--wenn das nur 3,4 sind, dann müssen die komprimiert

--, CPU-Zeit = 15 ms, verstrichene Zeit = 17 ms...scheinbar kein Lesen

--wir haben mit Columnstore was gewonnen:
--wesentlich geringere CPU Zeit
--deutlich weniger IO
--deutlich weniger im RAM
--bei jeder doofen Abfragen

--wieso ist das so





--WARTUNG!!


/*
Fragemntierung der Indizes
unter 10% muss nichts unternommen werden
über 30% Rebuild
dazwischen Reorg

--Wartungsplan
*/



select * into ku4 from ku1

select * from ku4 where id = 100 --1

select * from ku4 where orderid = 10248 -- 300-- scan


select * from ku4 where freight < 2

--woher diese geschätzten Zeilen und warum?? --- 1%
--zur Findung von IX (vor allem für den NCL IX)

--Statistiken
--werden nur bei IX zu 100% genau erfasst
--bei Spalten ohne IX nur Stichproben

--aber es gibt auch noch INS UP DEL


--100.000
--Wert 100 20x
-- 100

--Schwellwert: um Stat zu aktualisieren.. 5 oder 10%...FAKT!: 20%+500+ ABFRAGE auf die SPALTE


--Wartung muss also Stat aktualisieren
-- IX können fragmentieren

---0 bis 10% Nix tun
--10 bis 30% Reorg
--30% und höher Rebuild

--Füllfaktor:  L:S --> Füllfaktor

--ab SQL 2016 guter Wartungsplan
--Express: Ola Hallengren


select * from sys.dm_db_index_usage_Stats


--IX Rebuild   Offline oder Online
--				mit Tempdb oder ohne tempdb
--teuerste Kombi: Online + mit tdb
--billigste:     Offline + ohne tdb


--HEAP 200MB
--1 CL IX + 2 NCL IX--> 363 MB
--billignummer: 860MB
--Luxusvariante: 1100MB




--Überflüssige IX entfernen
--Fehlende IX rein

--

