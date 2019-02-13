--Variablen

/*
@var: lokale Variable

Lebensdauer: lebt nur während eines Batches
Zugriff:   nur der, dern den Batch betreibt hat Zugriff


@@var: globale Variable

Lebensdauer: lebt nur während eines Batches
Zugriff:   auch in anderen Verbindungen
eigtl unrealistisch in der Verwendung ausser...
Systemvariablen



*/

declare @var1 as int
set @var1=10

--default wert
declare @var2 as int = 0

--Variable einen Wert aus einer Abfrage zuweisen
select @var=sum(sp) from Tab

--ungültig dagagen ist:
--gleichzeitiges Zuweisen von Werten und Ausgabe ist ungültig
select @var=sum(sp), sum(sp) from tab


--Vorsicht vor GO (=Batchdelimiter)

declare @var3 as int = 100
set @var3=1000
GO
select @var3	  --nicht mehr gültig

select 1/0
select @@ERROR
select @@ROWCOUNT



--der Code wird oft deutlich übersichtlicher und flexibler

--Wir brauchen alle Orders, deren Frachtkosten unter dem Schnitt 
 --	 der Frachtkosten

declare @schnitt as money

select @schnitt = avg(freight) from orders

select * from orders where freight < @schnitt


--geht das auch ohne Variable


select * from orders
	where 
			freight < (select avg(freight) from orders)



-- ABC Analyse
 --A <100   
 --C  > 500
 --B Rest
 
 --Ausgabe: Customers, freight, A B oder C

select freight,'A', * from orders

 --Temporäre Tabelle

 select   CustomerID, freight, 'A' as Kundetyp
 into #t
 from orders where freight < 100

 insert into #t
  select   CustomerID, freight, 'C' as Kundetyp
  from orders where freight > 500

 insert into #t
  select   CustomerID, freight, 'B' as Kundetyp
  from orders where freight between 100 and 500

select * from #t


 select   CustomerID, freight, 'B' as Kundetyp
  from orders where freight between 100 and 500
  UNION ALL
 select   CustomerID, freight, 'A' as Kundetyp
  from orders where freight < 100
  UNION
  select   CustomerID, freight, 'C' as Kundetyp
  from orders where freight > 500





--Bester und schlechtester Kunde?

--UNION erlaub keine order by im Select
--Idee TRick17
--
select * from (select * from orders order by )  t

 select * from 
	(
	select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight desc 
	) t1	
 UNION ALL
 select * from 
	(
	select top 1 companyname , freight
	from customers c inner join orders o 
		on o.CustomerID=c.CustomerID
	order by freight asc 
	) t2


	--mit Variablen
	--übersichtlicher

declare @maxfracht as money, @minfracht as money
select @maxfracht= max(freight), @minfracht=min(freight) from orders

select customerid , freight from orders where freight = @minfracht
union all
select customerid , freight from orders where freight = @maxfracht


--SUBSELECT

select 
		'A',
		(select avg(freight) from orders) as Schnittfracht,
		(freight -	 (select avg(freight) from orders))	 as Abweichung	
from 
	(select * from orders) o
	where
			shipcountry = (select top 1 country from customers)



--ABC anders

SELECT 
	CASE
		when  sp = wert then 'A'
		when  sp = wert2 then 'B'
		else  'C'
	end	   as Spaltenname,....
FROM


select 
		orderid, freight,
		case
			when freight < 100 then 'A'
			when freight > 500 then 'C'
			else 'B'
		end as Kundentyp
from orders


--IF

IF (1=1) select 'A'

IF (1=0) select 'A'

IF (select ..) > Wert CODE

IF (select count(*) from customers) > 100 select 'mehr als hundert'

IF (1=1)
	select 'A'
ELSE
	select 'B'
	select 'C'	   --gehört nicht mehr zum IF!!


 --soll aber dazu gehören!

 --begin end  --Blockabfertigung
 --falls mehr Anweisungen verarbeitet werden sollen muss ein Block her
 --eigtl immer korrekt mit BLock (begin end)

 IF (1=0)
	begin
	select 'A'
	select 'D'	  --ohne Block Fehler
	end
ELSE
	begin
	select 'B'
	select 'C'	 
	end

IF 
	IF
			IF


--Jetzt ist debugging nicht schlecht

 IF (1=0)
	begin
	select 'A'
	select 'D'	  --ohne Block Fehler
	end
ELSE
	begin
	select 'B'
	select 'C'	 
	end


select * into o from orders

--Wenn der schnitt der Frachtkosten aus 'Austria' (shipcountry) über 100 liegen sollte,
--dann senken wir die Farchtkosten beim allen Österr. um 10 %
--liegen sie darunter, dann erhöhen wir um 5 %

 begin tran
 select avg(freight) from o where shipcountry = 'AUSTRIA'
If (select avg(freight) from orders where shipcountry = 'AUSTRIA') > 100
	Begin 
		update o set freight = freight * 0.9	where shipcountry = 'AUSTRIA'
		print 'die Frachtkosten wurden in Österreich gesenkt'
		
	end
Else
	begin
		update o set freight = freight *1.05
		print 'die Frachtkosten wurden in Österreich erhöht'
	end
select avg(freight) from o where shipcountry = 'AUSTRIA'
rollback


---mit Variable
declare @land as varchar(50)='USA'

 begin tran
 select avg(freight) from o where shipcountry = @land

If (select avg(freight) from orders where shipcountry = @land) > 100
	Begin 
		update o set freight = freight * 0.9	where shipcountry = @land
		print 'die Frachtkosten wurden in Österreich erhöht'
	end
Else
	begin
		update o set freight = freight *1.05
		print 'die Frachtkosten wurden in ' + @land + ' gesenkt'
	end
select avg(freight) from o where shipcountry = @land
rollback




--WHILE
--kopfgesteuert
WHILE BEDINGUNG
	BEGIN

	END


while (1=1)
	begin
		select 'A'
	end



declare @i as int = 0

while @i < 10
	begin
		select @i
		set @i+=1 --@i= @i+1
	end


while (bedingung)
	begin
		break 	--wird die Schleife sofrt unterbrochen

		continue --wird der nachfolgende Code in der Schleife nicht mehr ausgeführt
				--sondern springt zum Schleifeneintritt und mach den nächsten Zyklus
	end


--Erhöhe die Frachtkosten in o
--um 10%  solange bis
--max:1500  oder Schnitt 100 erreicht
--aber defintiv nicht überschreitet


select max(freight), avg(freight) from o
--1007  78,2242


while (select avg(freight) from o) < 100 
	  OR
	  (Select max(freight) from o) < 1500
BEGIN
	update o set freight = freight *1.1
END


begin tran
select max(freight), avg(freight) from o
 while (select avg(freight) from o) < 100 
	  AND
	  (Select max(freight) from o) < 1500
BEGIN
	update o set freight = freight *1.1
END
select max(freight), avg(freight) from o
 rollback
--MIST!! darüber

---besser
begin tran
select max(freight), avg(freight) from o
 while (select avg(freight) from o) < 100 
	  AND
	  (Select max(freight) from o) < 1500
BEGIN
	IF (Select max(freight) *1.1 from o) > 1500	break
	IF (Select avg(freight) *1.1 from o) > 100 break
	ELSE
		BEGIN
		update o set freight = freight *1.1
		END
END
select max(freight), avg(freight) from o
 rollback




--billiger

begin tran
select max(freight), avg(freight) from o

while (select avg(freight) from o) < 100 /1.1
	  AND
	  (Select max(freight) from o) < 1500  /1.1
BEGIN
	update o set freight = freight *1.1
END


select max(freight), avg(freight) from o
 rollback



  --Schleifen: tu folgendies nie in Schleifen
  --SET Anweisungen ON und OFF schalten
  --kein TRansactions 
  
  --TX: kurz und bündig halten.. keine Zwischenabfragen







