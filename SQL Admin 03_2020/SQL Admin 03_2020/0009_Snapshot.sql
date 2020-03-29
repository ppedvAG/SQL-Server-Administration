-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO

--korrekte PFade: C:\_SQLDBS\STDINSTANZ\


-- Create the database snapshot
CREATE DATABASE Nwind_1200 ON
( NAME =Northwind,								   --logischer Name der Original Datei
FILENAME = 'C:\_SQLDBS\STDINSTANZ\nwind1200.mdf' ) --Dateiname des Snapshot
AS SNAPSHOT OF northwind;
GO



--Falls mehrere Dateien
CREATE DATABASE Nwind_1200 ON
( NAME = <Database_Name, sysname, Database_Name>,
FILENAME = 'C:\_SQLDBS\STDINSTANZ\nwind1200.mdf' ) ,
( NAME = <Database_Name, sysname, Database_Name>,
FILENAME = 'C:\_SQLDBS\STDINSTANZ\nwind1200.mdf' )
--Dateiname des Snapshot
AS SNAPSHOT OF northwind;
GO


--Restore einer DB mit Snapshot

--alle User müssen runter von Snapshot
--alle User müssen runter von OrigDB

use master;
GO
restore database northwind
from database_Snapshot = 'Nwind_1200'

select * from sysprocesses where dbid = db_id('Northwind')
select * from sysprocesses where dbid = db_id('Nwind_1200')
kill 56


--Auftrag 
--Sicherungen

--DB: 5 GB


--Mo bis FR
--6:30 - 19 Uhr

--Wie lange darf diese DB ausfallen? 30min
--Wie groß darf der Datenverlust max sein? 30 min

--ich schaff das nie in der Zeit==> Hochverfügbarkeit


--V: täglich.. 1min.. Mo bis Fr... 1 bis 2 mal  (mittag und abends): 20 Uhr
--D: alle 3 bi 4 T   Mo bis Fr Start 8:15 alle 90min
--T: alle 30min Mo bis FR .. Start 7:00  bis 19:30


--Zeil: nie eine einzige BAK Datei









--Finish


