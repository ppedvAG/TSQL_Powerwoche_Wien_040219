--temporäre Tabellen
-- #tab  oder ##tab

/*
#  lokale temp Tabelle
   existiert bis sie gelöscht wird 
     oder die Verbindung , in der sie erstellt
	wurde beendet ist

   Zugreifen kann nur der Ersteller



## globale temp Tabelle
	existiert bis die ##tab gelöscht wird
	oder die Verbindung untgerbrochen wird

	allerdings werden bestehende laufende Abfragen nicht unterbrochen


	ZUgreifen kann jeder andere auch



	--Sinn und Zweck
	--Zwischenergebnisse (Daten werden nicht akualisiert)

	--Join zu kürzen

*/

--lok temp Tab


create table #t1 (id int)

select * from #t1	   --in Fenster2 nicht existent

kill 101 --in anderen Fenster: tab ist weg


create table ##t1 (id int)
select * from ##t1


select * into tabelle|#tabelle from tabelle

select * into kunden from customers

select * from kunden	   --fixe tabelle

select * into #kunden from customers	--temp Tabelle



 
select top 1 companyname , freight
into #tA
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight desc 
 go
select top 1 companyname , freight
into #tB
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight asc
 go
select * from #tA
UNION ALL
select * from #tB

drop table #tA
drop table #tb