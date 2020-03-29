exec SuchID 2


dbcc freeproccache

set statistics io , time on
select * from ku1 where id < 2 --IX Seek mit Lookup -- 4 Seiten


exec SuchID 2 --IX Seek mit Lookup --4 Seiten

 
--1,1 MIO Zeilen .. ca 1%
select * from ku1 where id < 11100 --- 111150

select * from ku1 where id < 1000000 --wird def Scan: Seiten..43061


--Was war besser: Proc F() adhoc SQL oder Sicht



--Proc   select|Sicht  -- F()

--Wieso ist eigtl die Proc besser?
--weil der Plan einmnal kompiliert wird wird und auch nach Neustart immer noch vorliegt
--es dann immer wieder derselbe Plan verwendet
--beim ersten Aufruf


--Ziel : Plan muss wiederverwendbar sein

select * from orders where orderid = 10251



exec suchID 1000000 ---Tabelle hat ca 44000 Seiten---> Huch!!! 1.006.414.. Hä???

--Proz benutzerfreundlich


exec suchID 2


--Kompromiss:
exec suchID 1000000  --imer SCAN.. immer 44000











