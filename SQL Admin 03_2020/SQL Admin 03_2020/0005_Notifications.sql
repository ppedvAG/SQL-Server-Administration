/*

SQL Server soll mir etwas mitteilen

Operatoren (Mailadressen, Pager)
--wie Kontaktliste
xyn@sql.local


USer klagt: hab nen Meldung error 3206 Ebene 16
--16?... (DAU).. 
--15?.. (SuperDAU)
--9? .. (wo wohnst du?

--bis 10 Infos
--ab 11 Fehler (14=Security)

--17.. Arbeit
--20.. noch mehr Arbeit
--24 .. muss schnell weg.. Kollegen  holen
--25 .. möglichst ganz wweit weg sein

--SQL soll Mails versenden..
SMTP Client
sqlservice@sql.local

guest auf SQLLOCAL 


--Mailprofil einrichten:

Datenbank Email:

Profil : 

--Untersuche den HV SQL 1 .. ist der in Ordnung?
--Server. Max 2,1 PB
--DB Standardsettings: MAX....Gesamt - OS (2GB-4GB/10%)
--CPU

--Tipp.. auf allen identische Systemumgebung
--HADR: High Availab. Desaster Recover




*/

select  from sysxyz


select * from sysmessages where msglangid=1031 and severity=16