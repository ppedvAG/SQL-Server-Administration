select * from syslogins

--von Microsoft downloaden
sp_help_rev_login
--> generiert im Ausgabefenster die TSQL Statements zum Anlegen der SQL Logins
--inkl Kennwort und SID

--bei Windows KOnten nicht notwendig, weil in diesem Fall die Windows SID verwendet wird
--die immer dieselebe sein wird.. ;-)


sp_change_users_login 'Report'

--bei bestehenden Login--SID des Login wird dem User zugeordnet
sp_change_users_login 'Update_one' , 'JamesBond', 'JamesBond'

--gibts das Login nicht, dann wird ein Login angelegt mit gleicher SID
sp_change_users_login 'Auto_fix', 'JamesBond', NULL, '123@gleichdabei'


dbatools.io


--Was ist eogtl wenn: 
--model ist kaputt.. und keine Sicherug
--master kaputt
--msdb kaputt
--master ist das Herz des SQL Servers....
--Vorlagen: C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn

master restoren .. SQL Server im Einzelbenutzermodus starten
--Startparameter -m
--SQLCMD und Script

alter database msdb set Single_user

msdb .. DB einzelbenutzermodus

