--Aufgabe
--lege eine Tabelle (northwind)
--watlos (id hochzähler ganze Zahl, sp1 char (2000), sp2 char(2100))

--befülle Tabelle mit 20000 Datensätze

create table watlos
	(id int identity, sp1 char(2000), sp2 char(2100))
GO

insert into watlos (sp1,  sp2)
values			   ('XX', 'YY')
GO 20000

--Alternativ

insert into watlos
select 'XX', 'YY'
GO 20000

--20 / 16 Sekunden





--Aufgabe 2 

--eine Tabelle an: watlos2
--in dem du alle Daten aus der Sicht vKundeUmsatz einfügst
-- anschliessend: die Tabelle watlos2 mit den DAten aus watlos2 
--wiederbefüllen
--das ganze so oft bis 1,1 Mio Daten vorhanden sind


 select * into watlos2 from vkundeumsatz

 insert into watlos2
 select * from watlos2
 GO 9

 --Kopie von watlos2 in watlos3
 select * into watlos3 from watlos2



create table watlos
	(id int identity, sp1 char(2000), sp2 char(2100))
GO

 --füge eine spalte mit char(6000) dazu?

 alter table watlos add sp3 char(6000)	   --geht nicht

 --wie gross darf die Angabe im varchar(xxx) oder char(xxx) sein: 8000
 --wieso gibts dann einen varchar(max).. der kann 2 GB haben??
 --wiederspricht doch den 1DS/Seite

 alter table watlos add sp3 varchar(6000)	 --det geht??
 --joa: braucht ja nix

 update watlos set sp3 = replicate('X',6000)  --puuhh das geht tats..!!



 --watlos2 und watlos3 identisch
 --wie voll sind die Seiten in watlos2

 dbcc showcontig('watlos2')
 --- Gescannte Seiten.............................: 30613
 --- Mittlere Seitendichte (voll).....................: 98.62%

 alter table watlos3 add id int identity

 select top 10 * from watlos3

 --wieviele Seiten hat die Tabelle watlos3
 dbcc showcontig ('watlos3')
 -- Gescannte Seiten.............................: 31211
 -- Mittlere Seitendichte (voll).....................: 98.65%

 set statistics io, time on
 select * from watlos3 where id = 1000 --einer - scan
 --logische Lesevorgänge 50891  ???????

 --dbcc ist veraltet. was neues muss her

 select * from 
 sys.dm_db_index_physical_stats(db_id(),object_id('watlos3'),NULL,NULL,'detailed')

 --forward record count: 19680..das muss weg
 --Lösung: IX


  --watlos
   select * from 
 sys.dm_db_index_physical_stats(db_id(),object_id('watlos'),NULL,NULL,'detailed')
 --row_overflow_data.. is ok..


