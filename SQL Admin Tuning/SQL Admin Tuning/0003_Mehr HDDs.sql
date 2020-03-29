--Meh HDDs pro DB

--wir können Tabellen explizit auf andere HDDs legen
--Tabellen : Lesen vs Schreiben

create table Kunden (id int) ON STAMM
--was ist Stamm

--Dateigruppen
--Alias für eine Datendatei
--Default Dateigruppe PRIMARY (.mdf)


--Was ist schneller?
--TABX   10000
--TABY  100000

--Abfrage die eine Zeile als Ergebnis liefert
--Vermutlich X

--Massnahme

--Partitionierte Sicht


--statt einer großen Tabellen, viele kleine
--Anwendung braucht "UMSATZ"

create table u2020 (id int identity, jahr int, spx int)

create table u2019 (id int identity, jahr int, spx int)

create table u2018 (id int identity, jahr int, spx int)



create view Umsatz
as
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018


select * from umsatz --Plan zeigt: alle Tabellen werden abgefragt

select * from umsatz where jahr = 2019 --immer noch alle Tabellen im Plan

--nach dem Setzen einer Einschränkung auf kahr = 2018 auf der u2018 fehlt die Tabelle u2018 im Plan
ALTER TABLE dbo.u2019 ADD CONSTRAINT CK_u2019 CHECK (jahr=2019)

--wann scheitert das Konzept?
--wenn Abfragen nicht nach Jahr fragen
select * from umsatz where id = 110 -- and jahr = 2019

--extrem umständlich
--und der INS, UP, DEL wird vermutlich nicht gehen
--Bedingung: PK muss auf ID und Jahr sein und Identity Wert darf nicht enthalten sein

---ist ok bei Archivdaten

--aber es gibt bessers: Partitionierung!


use northwind

--Partitionierungsfun
create partition function fZahl(int)
as
range left for values (100,200)
GO
--------------100]-----------------200]-------------
--    1                2                    3


select $partition.fzahl(1117)

--wir brauchen Dateigruppen:
--4 Dateigruppen (bis100, bis200, bis5000, rest)

create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                  1       2       3
--Reihenfolge entscheidet...

--Tabelle auf Schema legen.. 
create table ptab(id int identity, nummer int, spx char(4100))
	ON schZahl(nummer)



declare @i as int=0

while @i< 20000
	begin
		insert into ptab (nummer, spx) values (@i, 'XY')
		set @i=@i+1
	end


--messen: ist das wirklich jetzt besser geworden
--Plan: SCAN (A bis Z).. SEEK
set statistics io, time on
select * from ptab --

select * from ptab where nummer = 117 --100 Seiten

select * from ptab where id = 117 --20000


select * from ptab where nummer = 1170--20000-100-100

--neue Grenze an 5000

----------100----------200--------------5000--------------------


--kurzer Auslastungstest
select $partition.fzahl(nummer), min(nummer), max(nummer), count(*)
from ptab
group by $partition.fzahl(nummer)


--Tabelle, F(), scheme
--scheme--welche DGruppe soll die 4te sein
--f() um Bereich 4 zu definieren
--Tabelle: nöööö nieee!!!

alter partition scheme schZahl next used bis5000
--noch hat sich nicht an der Verteilung der Daten geändert

alter partition function fzahl() split range(5000)
--cool--- jetzt sind die Daten dort wo sie sein müssen
-------------100-------------------200-----------------5000------------


select * from ptab where nummer = 1170


-------------100!-----------200------------------5000------------
--100 muss weg

--Tabelle, f(), scheme
--f() auf jeden Fall
--schema: nix!
--Tabelle nööööö... nie

alter partition function fzahl() merge range(100)

--jetzt könnte die eine oder andere Frage auftauchen??
--wie ist der aktuelle Stand


CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [rest])
GO

CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO

set statistics io on

select * from ptab where nummer = 16101


--Archvieren: Werte  bis 200 ab ins Archiv
--die Archivtabelle muss auf der Partition liegen, auf der die DAten auch sind
create table archiv(id int not null,nummer int, spx char(4100)) on bis200

alter table ptab switch partition 1 to archiv

select * from archiv


--100MB/sec
--10000000 MB ins Archiv... Dauer in sek? ca 0 
--es werden keine Daten verschoben, sondern die Partition wird in eine Tabelle umgewandelt

select * from ptab





--Partitionierungsfunktion
--Jahresweise
create partition function fZahl(datetime)
as
range left for values ('31.12.2019 23:59:59.999','',...)
GO
--datetime ..int wert ... mist

--AbisM  NbisR  SbisZ
create partition function fZahl(varchar(50))
as
range left for values ('N','S')
GO

select $partition.fzahl(1117)

--wir brauchen Dateigruppen:
--4 Dateigruppen (bis100, bis200, bis5000, rest)

create partition scheme schZahl
as
partition fzahl to ([Primary],[Primary],[Primary])




