 --mehere Ergebnisse zu einem Ergebnis

 --SPielwiese
 --2 Datens�tze an versch. Stellen ge�ndert
 --sowie in Customers einen ge�ndert
 --und ein neuer DS dazu
select * into KundenUKUSAIT 
from customers 
where 
	country in ('USA', 'UK', 'italy')


--liste aller Kunden (alle Tabellen zu einer)

select ...
UNION
select 

select ...
UNION
select 
UNION
select 
UNION
select

--Regeln: 
--Ergbnismengebn m�ssen gl3eich ANzahl an
--spalten haben

select 'A' , NULL	 --muss mit NULL erg�nzt
UNION
select 'A', 'B'

--Datentypen m�ssen komptibel 
select 1 --muss konvertiert werden convert(varchar(1), 1)
union
select 'A'


--die erste Spalte legt die Spaltennamen fest
select 'A' as sp1, 1 
UNION
select 'B' as sp2, 0  as spX

--filtert doppelte Ergebniszeilen raus
select 'A'	  --nur A
UNION				  --macht distinct
select 'A'

--wenn man das nicht will...

select 'A'	  --doppelte
UNION ALL				 
select 'A'

select * from customers
union
select * from kundenUKUSAIT

--Welche sind in Customers, die nicht in 
--KundenUKUSAIT sind
--und welche haben Sie gemeinsam  ---!

---gemeinsame: inner join

select * from customers c inner join kundenukusait	k
ON
	c.customerid = k.customerid
	and ..f�r jede SPalte dazu

--Suche  nach geminesamen DS per intersect
--Reihenfolge spielt keine rolle
select * from customers
intersect
select * from kundenukusait

--unterschiedliche

select * from customers
except
select * from kundenukusait

--Vergleich passiert auf Ergebnismenge: 2
select * from kundenukusait
except
select * from Customers

select customerid from kundenukusait
except
select customerid from Customers









