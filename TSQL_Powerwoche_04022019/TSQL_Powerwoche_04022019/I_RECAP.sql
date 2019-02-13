SELECT TOP ZAHL| ZAHL PERCENT with ties DISTINCT
	 F(SP), F(Wert) --Funktionen
	 Spalte
	 Wert (Zahl, TXT)
	 Mathe as ALIAS
	 *
	  --effektiv ein Wert (auch Zeichenkette ist ein Wert)
	  --also auch SELECT mit einem! Eregbnis
FROM
	TAB A INNER|LEFT|RIGHT JOIN TAB B
		  ON A.SP = B.SP AND ...
		  INNER|LEFT|RIGHT JOIN TAB C
		  ON C.SP = B.SP
		  ....
WHERE
		SP > < >= <= IN BETWEEN LIKE , 
		   NOT IN, NOT LIKE , NOT BETWEEN
		   IS NULL, IS NOT NULL
		   !=  <>
		AND
		OR --Klammern setzen
ORDER BY SP asc|desc
UNION | UNION ALL | EXCEPT | INTERSECT
SELECT 
...
UNION....





select * from orders where shipregion < 'A'
--Jeder Vergelich mit NULL führt zu einem undefinierten Zusatnd ==> leere Menge

	 
select (select 'A') , 
(select top 1 freight from orders)	,
* from orders

--Welcher ANgstellte hat welcher Firma welches Produkt verkauft?
--Liste Firma , Nachname des ANgstellten, Produkt


 select 
	 companyname
	,Lastname
	,Productname
from 
	customers c inner join orders o 
					on c.CustomerID=o.CustomerID
				inner join employees e
					on e.EmployeeID=o.EmployeeID
				inner join [order details] od
					on od.OrderID=o.OrderID
				inner join products p
					on p.ProductID=od.ProductID


--nun muss der Angestellte aus USA kommen
--und die Frachtkosten < 500 
--und die Firma sollte einen Namen haben 
--der mit A , B , F beginnt und mit N-Z endet


Select * from orders

--Brauch ne Liste, in der der beste Kunde (nach Frachtkosten)
--und der schlechteste genannt wird

--Firma  FReight



select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	--order by freight desc 
UNION
select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID

order by freight asc


select companyname , freight , row_number() over (order by freight )
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID














where 
		e.country = 'USA'
		and
		freight < 500
		and Companyname like '[ABF]%[N-Z]'





select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	--order by freight desc 
UNION
select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID