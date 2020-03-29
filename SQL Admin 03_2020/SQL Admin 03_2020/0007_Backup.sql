--Backup

/*

Stromausfall eigtl kein Problem.. Logfile

Fall 1: update, nach update ist DB defekt


Fall 2: update, update ändert versehentlich falsche Daten
	Daten versaut, DB geht

Fall 3: DB gelöscht 

Fall 4: DB korrupt
	--mdf defekt 
	oder ldf defekt


Fall 5: 
	SQL Server tot
		DB auf HDD noch da



--Letzte Sicherung (Dienstag, 24. März 2020 11:23:20)-- T
--DB läuft... logischen Fehler..
--mit geringstmöglichen Datenverlust..
--Fehler:  13:20!
--das nächste T kommt um 13:45
--D um 15 Uhr
--V 20 Uhr


/*
--Garantie, dass nur wir mit der DB arbeiten..(single User )
jetzt Sicherung: T (dauert 5 min)
11:23 - 13:41(...13:46) online


--die aktuelle DB muss restored werden!
--muss auf 13:19 restored werden


Verlust : 
alles weg ab 13:41
--wir haben aber alles von 13:19 bis 13:41 in der Sicherung

1. Alle User runterwerfen
2. Tlog sichern
3. Restore auf Sekunde genau
4. DB in MULTI USER

Wie werfe ich die Leute runter?

select * from sysprocesses where spid > 50 and dbid = db_id('testdb')
kill 62


USE [master]
GO
ALTER DATABASE [testdb] SET  SINGLE_USER WITH NO_WAIT
GO

BACKUP







*/







--Wiederherstellungsmodel
--Backupvarianten

Vollständiges V
	sichert alle Dateien inkl Infos bzgl Pfad und Größe und Name der DAteien
	alle DAten zu diesem Zeitpunkt gesichert
	Checkpoint wird ausgeführt


Diff Sicherung D
alle Blöcke sichern, die seit dem letzten V geändert wurden


Transaktionsprotkollsicherung T (inkrementell)
werden alle Anweisung gesichert , die im Laufe der Zeit stattgefunden haben
 (Änderungen)


V TTT  D TTT D TTT D TTT
V				   D TTT


schnellste Restore: 
 nur das V.. so wie möglich eine V Sicherung?

wie lange dauert der restore eines T?
kann so lange dauern, wie dier Zeitraum des Ts ist
Restore Log führt alle Anweisungen wieder aus
wichtig: nicht viele Logfiles restoren müssen

V TxTTTTTTTTTTTTT D TTTTTTTTTTTT D TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT  

100MB DB -- 100MB

D immer wiede reintreuen um die Sicherung zu verkürzen und sicherer zu machen


Ausfallzeit der DB /Serves
Datenverlust in Zeit

nur das Tlogbackup schafft es eine Restore auf die Sekunden genau zu arrangieren






Einfach
automatisch TX aus Log gelöscht. Log leert sich automatisch
T Sicherung ist nicht möglich
Es wird INS UP DEL protokolliert  auch BULK Befehle, aber rudimentär
Wenn man es nicht braucht
schnellste Variante


Massenprotkolliert (Bulk)
wie einfach, aber es wird nichts gelöscht
daher--> Backup Log
auch hier wird bulk nur rudimentär protokolliert


Voll (Full)

protokoliiert ausführlich
auf Sek restore möglich

ausführlich, umfassender, langsam, aber sicherer
Logshipping , Spiegelung muss ind Bulk oder Full

Vollständig



V TTT D TTT D TTT


*/

--Medium: Datei, Band, URL
--Nie in eine BAK Datei mehrere Sicherung
--zum Ende 3 TTTs davor beliebig D und Ts..
-- V TTT D TTT D TTT D TTT


--VOLL
BACKUP DATABASE [testdb] TO  DISK = N'C:\_SQLBACKUPS\testdb.bak'
WITH NOFORMAT, NOINIT,  NAME = N'testdb-VOLL',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--DIFF
BACKUP DATABASE [testdb] TO  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  DIFFERENTIAL ,
NOFORMAT, NOINIT,  NAME = N'testdb-DIFF', SKIP, NOREWIND,
NOUNLOAD,  STATS = 10
GO

--LOG
BACKUP LOG [testdb] TO  DISK = N'C:\_SQLBACKUPS\testdb.bak'
WITH NOFORMAT, NOINIT,  NAME = N'testdb-LOG',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--11:28......


--Fall 1: 
----logischer Fehler , DB funktioniert.. versehentlich Adressen verändert
--  11:26

--Idee nur falsche DAten korrigieren
--DB unter anderen NAmen restoren (älteren Zeitpunkt)

--Dev -- soll update ausführen























*/