--TOP 

--welche TOP eigtl...??

--kommt immer darauf an, ob ein order by dabei steht
--ohne order by ist das ab und zu nicht mehr legitim

--ohne order by kommen die DAten so, wie sie auf der Platte gespeicher wurden

--genau genommen sollte man den TOP immer mit order by beschreiben


select top 10 spalten from etc..
select top 10 percent  spalten	   from etc..


--Anwendnugnsgebiet für TOP...
--billigste/teuerste Frachtkosten

select top 1 freight from orders order by freight desc

select top 20 freight from orders order by freight asc

--liste die top 13 Frachtkosten auf
--aufsteigend
--bestenr, freight

  --mit Krawatte
select top 13 with ties orderid, freight , customerid
from		orders 
order by	freight   asc

--Liste aller Länder, in denen 
--wir Bestellungen ausliefern


select shipcountry from orders  --830

select distinct shipcountry from orders --21 

--Distinct filtert doppelte Ergebniszeilen

--wieder 830.. und sau doof geschrieben
--nie nach doppelten suchen lassen, wenn es die nicht geben kann
--zb wg PK im Select
select distinct shipcountry, orderid from orders








