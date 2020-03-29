/*
create database testdb2

--Mindestgröße: evtl so groß wie sie in 3 Jahre sein wird
--Wachstumsraten: erträglich.. ..kein % Angaben...eher MB..  1000MB 

--Ein Sache der Kontrolle

--wie sollte man das Logile einstellen...?
--DB DAtenvolumen von 50 GB
--Log: 25%
--Log sollte nie wachsen.. schafft man durch BACKUP LOG
--bei ca 60% Füllgrad ein Logsicherung
--es ist aber irgendwann gewachsen

--Logfile enthält VLFs (virtuelle Logfile)
--Die Anzahl der VLF sollte ein geissen Maß nicht übersteigen... (1000)
--Wie schafft man viele VLFs aus dem Weg
--wie kann ich ein LOG verkleinern..

--DB Daten 20 GB
--DB Log: 200 GB

CHECKPOINT
--RecoveryModel auf Einfach
CHECKPOINT ..normalerweise 60sekunden.. unregelmäßig
--nun hast du noch die letzte Sicherung
--nun ist Log leerer
--Verkleinern
--Ordentliche Größe evtl Wachstumsrate anpassen (max 1000MB)
--RecModel wieder auf FULL
--Vollsicherung












*/