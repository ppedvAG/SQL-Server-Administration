/*
Tabellen
Views (Sichten)
Prozeduren
Funktionen

n =  Unicode
int: -2,1Mrd bis + 2,1 Mrd

Vorname: 'otto'
char(50):   'otto                       ' 50 
varchar(50) 'otto'                         4
nchar(50): 'otto                     '    50*2 100
nvarchar(50) 'otto'                        4*2 8
text() --nie verwenden! seit 2005 depricated..nicht performant
..(max) kann der bis 2 GB 
nvarchar(max) --1 GB Daten *2 
Zelle kann max 2 GB haben
varchar(max) .. max 2 GB Daten


datetime:
Abfragen sollte gleiche Ergebnis liefern
-aber  408 Zeilen
select * from orders where year(orderdate) = 1997 --richtige Ergebnis aber schlecht 
--411 Zeile auch welche aus 1998
select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.999' --schnell aber falsch

datetime wird intern als int gespeichert.. ist etwas ungenau 3,3 ms

DATETIME: auf 3,3 ms genau int Wert

das was auf der HDD liegt kommt 1:1 in RAM


datetime (ms)
smalldatetime (sek)
datetime2 (ns)
datetimeoffset (ms + Zeitzone)
date Datum

decimal(18,0)
decimal(10,2) 10 Stellen , davon 2 Nachkommastellen
numeric = decimal

float = x Nachkommastellen
money= float mit weniger Nachkommstellen (8)
time Zeit


*/

--Sichten
/*
sind Abfragen, enthalten keine Daten
werden aber wie Tabellen behandelt

in Sichten lassen sich folgende Dinge umsetzten
INS
UP
DEL
aber nur bei sehr simplen Abfragen (eine Tabelle)

Rechte auf Sichten 

komplexe Abfragen zu vereinfachen.. eher der 2te Grund
eher wg Rechten


Sichten können Daten anzeigen, auch dann wenn man auf die Tabelle mit den tats Daten kein
Zugriffsrecht hat.


select angId, nachname, vorname from angestellten
--ohne Religion, Gehalt und GebDat

Recht auf Sichten können abweichend Rechte haben im gegens zu Tabellen


--Prozeduren sin dim Regelfall schneller als der Code der dahinter steckt..
--kann aber auch sein, dass sie dramtsisch schlechter ist

der Plan der Prozedur wird beim ersten Aufrug analysiert und kompiliert und dann immer wieder weiterverwendet




f()... sind in der Regel immer schlecht!


adhoc  Sicht  Proc f()

Proc adhoc|sicht  f()

adhoc|sicht  f() proc



*/

create proc gpdemo @par1
as
select * from orders
ins
up
del


exec gpdemo







*/