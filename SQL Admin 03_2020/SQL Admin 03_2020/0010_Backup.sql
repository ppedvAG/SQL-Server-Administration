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


USE [master]
ALTER DATABASE [testdb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [testdb] TO  DISK = N'C:\_SQLBACKUPS\testdb_LogBackup_2020-03-24_13-56-50.bak' WITH NOFORMAT, NOINIT,  NAME = N'testdb_LogBackup_2020-03-24_13-56-50', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE DATABASE [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  FILE = 10,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  FILE = 11,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  FILE = 12,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb.bak' WITH  FILE = 13,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [testdb] FROM  DISK = N'C:\_SQLBACKUPS\testdb_LogBackup_2020-03-24_13-56-50.bak' WITH  NOUNLOAD,  STATS = 5,  STOPAT = N'2020-03-24T12:06:00'
ALTER DATABASE [testdb] SET MULTI_USER

GO


--V----D  -T 12:50       BACKUP: ab 12:50 TX TX TX TX 


--V 10 GB --> 1 min
--V 50GB  -- 5min
--T (15min) --> bis zu 30min

TTT D


ALTER  DATABASE DB SET ACCELERATED_DATABASE_RECOVERY = ON;
GO



