---where: > < = >= <= 
--like 
--between in != <> not like not in not between

--Suche mit =  ist exakt. Keine Wildcards!!!
select * from orders 
where
		orderid = 10248

--auch Vergleichsoperatoren wie > < <= usw haben keine Widlcards
select * from orders 
where
		orderid < 10250


--Suche: alle Bestellungen aus dem Jahr 1997
--mit function 

select * from orders where year(orderdate) = 1997


--oder auch so.. mehrere Bedingen in where

--where sp = wert and sp2 > wert
--where sp = wert or Sp2 <= wert

--wieder Suche nach Bestellungen 1997

select * from orders 
	where
			orderdate > '31.12.1996'   --31.12.1996 00:00:00.000
			AND
			orderdate < '1.1.1998'

select * from orders 
	where
			orderdate >= '1.1.1997 00:00:00.000'   --das könnte man sich nun sparen
			AND
			orderdate < '1.1.1998'			  --paast auch
	
select * from orders 
	where
			orderdate >= '1.1.1997 00:00:00.000'   --das könnte man sich nun sparen
			AND
			orderdate <= '31.12.1997 23:59:59.999'  --jetzt 411	 ???
			

select * from orders
	where 
		orderdate between '1.1.1997 00:00:00.000'
					AND
					  '31.12.1997 23:59:59.999' 	  --411


--ein datetime wird intern als int gemerkt, daher rel ungenau

--problem bei between (<= und >=)
--ud datetime der auf ms genau ist

---Frachtkosten
--alle Bestellungen, deren frachtkosten bei unter 100 Euro brutto liegen

--Mwst 20%		  . Frachtkosten sind in netto

 select freight as netto , freight *1.2 as brutto
			,* 
from orders where freight * 1.2 < 100
order by brutto desc


select * from orders where freight != 6.27
select * from orders where freight <> 6.27

select * from orders where freight = 6.27

--ShipRegion: NULL
--NULL: weder '' noch 0, sondern ist NULL  (undefiniert)
--
select ''+'A'
select NULL + 'A'
--jede mathematische mit NULL ergibt NULL

--alle Datensätze, die in Shipregion NULL haben
--und alle suchen, die nicht NULL haben

select * from orders where shipregion = NULL	^--mathe!! da kommt nix!!
select * from orders where shipregion is NULL	

select * from orders where shipregion !=  NULL	 --falsch, dakommt nix
select * from orders where shipregion is not NULL	^--mathe!! da kommt nix!!



--Wildcards!

-- % .. für beliebig viele Zeichen 0 bis ...

--alle Bestellungen, der Shipcity bit C beginnt

select * from orders where shipcity like  'C%'


--wieviele Bestellunge gibt es denn , die am Ende der Shipcity ein s haben


 Select * from orders where shipcity like '%s'



 --hmmm: der vorletzte Buchstabe ist ein a

 select * from orders where shipcity like '%a_'


 --Wildcard: _ steht für genau ein Zeichen

 --der erste ZEichen sollte ein S dann unbekannt, dann der drittletzte ein e und der letzte ein s

 select * from orders where shipcity like 's%e_S'


 --aber wie geht folgende Suche: %   _   '

 --Suche nach % Zeichen
 select * from customers where companyname like '%%%' --bringt nix

 select [Rng-Summe],* from [order details]

 --jetzt klappts...
 select * from customers where companyname like '%[%]%' --bringt nix

 --Wir brauchen alle Kunden (customerid)  die soll mit A oder B oder C order D beginnen


 select * from customers
	where customerid like 'A%' or 	 customerid like 'B%'
		or customerid like 'C%' or customerid like 'D%'

 select * from customers where customerid < 'E'

 -- keine Wildcardsmöglich
select * from customers where customerid between 'A' and 'E'

--[   ] steht für genau ein Zeichen
select * from customers where customerid like '[A-D]%'


 --alle Kunden:  mit A B C oder mit P R oder S beginnen 
 --und mit  a bis F enden
 --und dazwischen sollte ein o sein


 select * from customers 
		where
				customerid like '[A-C]%o%[a-f]'
				or customerid like '[P-S]%o%[a-f]'

select * from customers
		where customerid like '[A-C|P-S]%o%[a-f]'

--innerhlab eines Wertebereichs eine Oder Verknüpfug duch  | ,


  select * from customers
		where customerid like '[A|B|C]%'		--oder [ABC]% oder [A,B,C]%


--Annahme: Spalte (varchar(4)) mit PIN--drüfen nur aus Zahlen bestehen...

--where PIN not like '[0-9][0-9][0-9][0-9]'	   --ungültige PINs


--bleibt noch Suche nach  '

select * from customers where companyname like '%'''

select * from customers where companyname like 'Alf!'%' ESCAPE '!' '

--Suche nach _ geht mit [_]


--Suche nach allen Bestellungen
--frachtkosten müßen unter 10 sein 
--oder die Bestellungen müssen aus dem Land UK verschifft worden sein
--und vom Angestellten Nr 3 bearbeitet worden sein

--orders

select * from orders where
	freight < 10
	or
	shipcountry = 'UK'
	AND			 --das wird immer stärker gebunden
	employeeid = 3


--Alle Bestellungen aus UK und USA

select * from orders where 
		shipcountry = 'UK' OR shipcountry  = 'USA'

		--shipcountry in ('UK', 'USA')

 --Immer wenn and und or im where gemischt wird: Klammern!!!

 select * from orders where
	freight < 10
	or
	(shipcountry = 'UK'
	AND			 --das wird immer stärker gebunden
	employeeid = 3)

 select * from orders where
	(freight < 10
	or
	shipcountry = 'UK'	) --jetzt wird das or gebunden
	AND			 
	employeeid = 3

 select * from orders where
	freight < 10
	or
	shipcountry = 'UK'	
	AND			 --das wird immer stärker gebunden
	employeeid = 3


--Alle Kunden aus UK, USA , Italy
--customers (country)

select * from customers 
	where 
	country   in ('UK', 'USA', 'Italy')


--IN : Abkz für viele Vergleiche einer Spalte mit = 
--sp = or sp = or sp =  ...

--BETWEEN : Abkz für SP >= and SP <=



	select 
		companyname
		, c.customerid
		--, o.customerid, o.orderid
from 
		customers c left join orders o 
		ON
		c.customerid = o.customerid
where
		o.orderid is null








 






 														 s






