--Setup
/*
Pfade
	sqlservr.exe --Binär... sch**egal

	DB (Datendatei .mdf und .ldf Transaktionsprotokoll)
	Regel: Trenne Log von Daten  pyhsikalisch (HDDs)
		pro DB entscheiden
		SAN ?! man messen

tempdb
	Datendatei pro Prozessor (max 8)

Express: 0 Euro, 10GB RAM, evtl fehlende Features, kein Agent, keine Jobs , kein Wartungsplan
			Max 1 GB RAM --> HDD Konflikt


Maxdop (4 max 8)
	Abfragen können eine CPU oder auch mehrere verwenden
	Regel: max 8 Cpus pro Abfrage
	alle machen aber keinen Sinn


min Ram: (Max Wert im Taskmanager als MIN RAM )

max Ram: Gesamt - OS (2 bis 4GB oder 10%)

Filestream
 Freigaben von SQL verwaltet --> Filetable (Rechtevergabe in SQL Server, Abfragen der DAteien in TSQL)

 Auth:

 NT Login (NT Admins sind per default keine SQL Admins mehr)
 SQL Login + NT : gemischte Modus

 sa... komplexes Kennwort  14 Stellen

 Dienstkonten: schulung\sqlagent ppedv2019! ... schulung\svcsql ppedv2019!
	Agent
	SQL Server
	DOM Userkonten: Anforderungen...keine
	NT Service\sql..      : verwaltete Dienstkonto (lokales Konto: Computerkonto)
	--für Clusterbetrieb nicht möglich.. verwaltete Gruppenkonten eher...



-----------------------------------------------------
	auf HV-SQL2 .. installieren eine weitere Instanz
	mit beste practice Gedanken

	First Serversettings


	Pfade?
		neue Ordner







*/