--Hier bin ich Admin!!!

USE [testdb0001]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO
CREATE SCHEMA [MA] AUTHORIZATION [dbo]
GO

create table it.personal(itpero int)
create table it.kst(itkst int)


create table ma.personal(mapero int)
create table ma.kst(makst int)

--Admin hat default Schema: dbo
select * from personal --dbo.personal

select * from IT.personal
select * from MA.personal


use [testdb0001]
GO
GRANT SELECT ON SCHEMA::[MA] TO [Susi]
GO
GRANT SELECT ON SCHEMA::[IT] TO [Max]
GO

--Std Schema
USE [testdb0001]
GO
ALTER USER [Susi] WITH DEFAULT_SCHEMA=[MA]
GO
ALTER USER [Max] WITH DEFAULT_SCHEMA=[IT]
GO


use [testdb0001]
GO
GRANT CREATE TABLE TO [Max]
GO


select * from testdb0001.dbo.t1