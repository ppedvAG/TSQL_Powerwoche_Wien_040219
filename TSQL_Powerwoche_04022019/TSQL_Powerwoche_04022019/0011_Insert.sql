---

/*
 Daten bestehen bereits:
	in eine andere Tabelle rein
	in einer nocht nicht best Tabelle

 Noch keine best Daten
	in bestehende oder nicht best Tabellen



*/


-----Best Daten in noch nicht bestehde Tabelle


--select .... into Tabelle ...


--Select into übernimmt Spaltennamen, Datentypen, NOT NULL od NULL, sowie Identity
select * into CustmitS from customers where customerid like 'S%'

select * from custmitS



--nicht existente Daten in nicht bestehende Tabelle

 --Spalten brauchen Namen
select 'A'as SPTXT, 100 SPZAHL	into TabOhne

select * from TabOhne

--welcher Datentyp liegt nun vor


sp_help	'Tabohne'

--was wenn wir den Datentyp vorher definieren wollen
select convert(varchar(50),'A') as SPTXT, convert(smallint,100) SPZAHL	into TabOhne2

sp_help 'TabOhne2'	    --jetzt passts


--bestehende Daten in best Tabelle


select * from custmits


--alle mit S am Ende sollen in CustmitS rein....
select * from customers	 where companyname like '%S'


--wir bekommen alle Spalten in der exakten Reihenfolge wie OrgTabelle

insert into CustmitS
select * from customers	 where companyname like '%S'   --23 


--bei best Spalten immer auf exakte gleiche Reihenfolge der Spalten achten
insert into CustmitS (Customerid, companyname, country, city)	--mind Pflichtspalten
 select				 Customerid, companyname, 'A-'+country, city 
	from customers 
	where companyname like '_%s%_'		 --58


insert into custmits (customerid, companyname, city, country)
values
					('ppedv', 'ppedv AG', 'Wien', 'Austria'),
					('pped2', 'ppedv GmbH', 'Burghausen', 'Germany')

--alternativ
insert into tabelle ()
select wert, wert wert , wert
UNION ALL
select wert , wert wert, wert


--Geschichte mit TempTab und bester und schlechtester Kunde
--jetzt nur noch mit einer..

select top 1 'mieser Kunde ' as Typ, companyname , freight 
into #tabelle
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight desc 



 insert into #tabelle
select top 1 'cooler Kunde ', companyname , freight 
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight asc 

select * from #tabelle














