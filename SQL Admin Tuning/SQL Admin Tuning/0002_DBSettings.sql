/*
create database testdb2

--Mindestgr��e: evtl so gro� wie sie in 3 Jahre sein wird
--Wachstumsraten: ertr�glich.. ..kein % Angaben...eher MB..  1000MB 

--Ein Sache der Kontrolle

--wie sollte man das Logile einstellen...?
--DB DAtenvolumen von 50 GB
--Log: 25%
--Log sollte nie wachsen.. schafft man durch BACKUP LOG
--bei ca 60% F�llgrad ein Logsicherung
--es ist aber irgendwann gewachsen

--Logfile enth�lt VLFs (virtuelle Logfile)
--Die Anzahl der VLF sollte ein geissen Ma� nicht �bersteigen... (1000)
--Wie schafft man viele VLFs aus dem Weg
--wie kann ich ein LOG verkleinern..

--DB Daten 20 GB
--DB Log: 200 GB

CHECKPOINT
--RecoveryModel auf Einfach
CHECKPOINT ..normalerweise 60sekunden.. unregelm��ig
--nun hast du noch die letzte Sicherung
--nun ist Log leerer
--Verkleinern
--Ordentliche Gr��e evtl Wachstumsrate anpassen (max 1000MB)
--RecModel wieder auf FULL
--Vollsicherung












*/