--gespeicherten Prozeduren
--stored procedures

/*
gespeicherte Abfragen	 wie Sicht?
in sp kann alles mgöoche beliebig oft vorkommen

funktioniert eher so wie ein Batch

sp können auch Parameter haben

Proc enthalten häufig BI Logik


*/

--einfachste Proc
create procedure gpdemo
as
select getdate()

--Prozeduren werden ausgeführt
--insofern auch kein JOIN mit anderen Tabellen
exec gpdemo


alter proc gpdemo @par1 int, @par2 int
as
select @par1 * @par2


exec gpdemo 2, 100

alter proc gpdemo @par1 int, @par2 int
as
select @par1 * @par2
select @par2 + @par1



create proc gpfrachtsuche @fracht money
as
select * from orders where freight <= @fracht


exec gpfrachtsuche 10



---Kunden löschen
--Proc muss von hinten her aufräumen
--hzuerst alle Positionen aus order details
--dann alle orders
--und dann Kunden löschen aus customer

begin tran
select * from customers where customerid = 'ALFKI'
exec gpCustDel 'ALFKI'		  
select * from customers where customerid = 'ALFKI'
rollback

create proc gpCustDel @custid varchar(50)
as
delete from [order details]
	from orders o inner join [order details] od
			on od.orderid = o.orderid
	where o.customerid = @custid
delete from orders where customerid = @Custid

delete from customers where customerid = @Custid




 --Warum proc... aber sind auch schneller;-)
 --Warum?
 --weil der Plan bei weiteren Aufrufen kompiliert vorliegt
 --der erste aufruf legt den Plan fest

 exec gp_KdSuche 'ALFKI'  --1 DS
 exec gp_KdSuche 'A%'  --4 DS --alle mit A beginnend
 exec gp_KDSuche '%'  --alle


alter proc gp_KdSuche @cust varchar(5)
as
select * from customers where customerid = @Cust

 exec gp_kdsuche 'ALFKI' --ok
 exec gp_kdsuche 'A%' --nicht ok


 alter proc gp_KdSuche @cust  varchar(5)
as
select * from customers where customerid like @Cust


 exec gp_kdsuche 'ALFKI' --ok
 exec gp_kdsuche 'A%' -- ok


  alter proc gp_KdSuche @cust  varchar(5)
as
select * from customers where customerid like @Cust +'%'

 exec gp_kdsuche 'ALFKI' --ok
 exec gp_kdsuche 'A%' -- ok


alter proc gp_KdSuche @cust  varchar(5)	='%'
as
select * from customers where customerid like @Cust +'%'


 exec gp_kdsuche 



--watlos3 ..reiner Heap

exec gp_idsuche 10

--alle DS aus watlos3 die eine id <=10 haben

--proc anlegen aber nich nicht ausführen


create proc gp_idsuche @id int
as
select * from watlos3 where id <= @id

set statistics io , time  on

select * from watlos3 where freight = 0.02	  --31170

select * from watlos3 where id <= 10


exec gp_idsuche 10


select * from watlos3 where id <= 1000000


exec gp_idsuche 1000000		    --1002236

--schlechte Prozeduren sind die, die benutzerfreundlich sind
--warum: weil mal viele, mal weniger rauskommen
--das wären versch. Pläne


--anderer ähnlicher Fall: von 2 Wegen wird nur einer genau geplant
--der zweite wird grob geschätzt

create proc demo1 @par1 bit	  , @par2 int
as
IF @par1= 0
select * from orders where orderid < @par2
else
select * from employees where employeeid =@par2

  
--Lösungen:


create proc gp_idsuche @id int
as
IF @id > 1000
gp_idsuchewenige  (immer seek)
ELSE
gp_idsucheviele (immer scan)

select * from watlos3 where id <= @id




-----Ausgabeparameter

alter proc gpdemo2 @par1 int=0,@par2 int
as
select @par1+@par2


exec gpdemo2  @par2=10	, @par1=100

exec gpdemo2 10=@par2	    --unlogisch

 --output Parametger sind aber auch  inputparaeter
 alter proc gpdemo2 @par1 int=0,@par2 int  , @par3 int output
as
select @par1+@par2

exec gpdemo2 1,2 ,3

alter proc gpdemo2 @par1 int=0,@par2 int  , @par3 int output
as
select @par3=@par1+@par2
select @par3



--Lösung ist Variable
--Variablen existieren nur während eines Batches
--lokale Variablen gibts auch nur in dieser einen Verbindung
declare @var1 as int 
set @var1 = 10
select @var1
go
select @var1







 declare @ergebnis as int

exec gpdemo2 10,20,@par3=@ergebnis output
select @par3
select @ergebnis

  select @var=agg(spa) from tabe

--Proc, die soll den Schnitt der Frachtkosten errechnen
--allerdings für ein best Land

gp_frLandavg 'UK'

--> 100

select * from orders where freight > @schnitt


create proc gp_schnittFrLand @land varchar(50), @schnitt as money output
as
select 	 @schnitt = avg(freight) from orders
	where 
			shipcountry = @land

declare @frachtschnitt as money
exec gp_schnittFrLand 'UK', @schnitt= @frachtschnitt output
select * from orders where freight > @frachtschnitt






























select * from sys.all_sql_modules




