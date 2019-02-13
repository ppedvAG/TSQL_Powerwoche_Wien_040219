 --Wo kann ich was finden, wenns klemmt?

 --ZB Indizes

 /*
 Wieviele IX kann eine Tabelle haben:
 TAB mit Spalten A B C 
 --  nicht nur 14 sondern > 1000
 --aber wieviele sind eigtl notwendig
 --es gibt auch überflüssige IX--> trotzdem ein update

 A
 ABC
 ACB
 BAC
 BCA
 CAB
 CBA

 wo findet man denn überflüssige IX?

 */


 select * from 
		  sys.dm_db_index_usage_stats
		  where database_id = db_id()

select * from sys.indexes


--und die überlappenden:

AB
ABC

--Freeware Scripte
--Brent Ozar: sp_blitzIndex

sp_blitzindex

Ola Hallengren --IX defrag


EXEC dbo.sp_BlitzIndex @DatabaseName='Northwind', @SchemaName='dbo', @TableName='w2';


--Grundsätzlich ein Problem zu finden
--TaskManager
--Aktivitätsmonitor Taskmanager des sql server

select * from sysprocesses

kill Spid

kill 67

--Locks, aktuelle Probleme


begin tran
update customers set city = 'BGH'
select * from customers
rollback



--Wennes deutlich mehr zu wissen geben soll und wir auf Dauer mitprotokollieren wollen
--dann Xevents Exented Events
 select * from o


 --2 Pfeilchen: mehr CPUs

set statistics io , time on
--mehr CPUs ist doch gut, weil schneller
--4 CPUs
--wieviel nimmer er denn?
select sum(unitprice) , city from watlos3  
where left(lastname,1) = 'B'
group by city 
option (maxdop 6)

--alle  CPU-Zeit = 312 ms, verstrichene Zeit = 44 ms.
--mit 1 CPU 170ms 170ms
--mit 50% CPUS : bei fast gleicher Zeit CPU Aufand um gut 100ms weniger
--und vor allem 50% der CPUs sind frei


--ab wann nimmt er eine und ab wann alle?
--Kosten: ab 5 SQL Dollar alle CPUs


--, CPU-Zeit = 296 ms, verstrichene Zeit = 43 ms.

