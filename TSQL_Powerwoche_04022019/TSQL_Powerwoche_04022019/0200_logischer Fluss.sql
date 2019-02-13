select	  country as Land
		, city as Stadt 
		, count(*) as Anzahl 
from customers	C
group by   country, city
 -----
select	  country as Land
		, city as Stadt 
		, count(*) as Anzahl 
from customers	C
group by   country, city
order by Land, Stadt

 --neeeee
select	  country as Land
		, city as Stadt 
		, count(*) as Anzahl 
from customers	C
group by   Land, Stadt
order by Land, Stadt

---	 neeee
select	  country as Land
		, city as Stadt 
		, count(*) as Anzahl 
from customers	C
where c.Country = 'USA'
group by   country, city
order by Land, Stadt


select	  country as Land
		, city as Stadt 
		, count(*) as Anzahl 
from customers	C
--where count(*) > 1000---Anzahl > 1000
group by   country, city having count(*) > 1000
order by Land, Stadt


--verantwortlich ist logischer Fluss
/*
 FROM  (Alias der Tabellen) --> der Reihe nach JOIN -->
 --> where --> group by -->  having	 (nur Aggregate , kein Alias
 --> SELECT (nicht Ausgabe, sondern Berchnungen, Aliase, F()
 --> order by  - TOP  - Distinct
 --> Ausgabe


*/
