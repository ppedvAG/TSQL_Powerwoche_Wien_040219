--Trigger

--DML DDL

--DML INS UP DEL
--DDL CREATE ALTER DROP

--DML

--sobald ein Trigger auf INS reagiert
--wird eine tabelle inserted generiert
--in der alle eingefügten Datensätze enthalten
--Ist der Trigger vorbei ist die inserted auch wieder weg


--sobald ein Trigger auf delete reagiert
--wird eine Tabelle deleted generiert
--in der alle eingefügten Datensätze enthalten
--Ist der Trigger vorbei ist die deleted auch wieder weg
--Anwendungsfall

 --sobald ein Trigger auf update reagiert
--wird eine Tabelle deleted und eine tabelle inserted generiert
--in der alle Datensätze vorher /nachher Datensätze enthalten
--Ist der Trigger vorbei ist die deleted und inserted  auch wieder weg
--Anwendungsfall


create trigger trgaufo on o
for insert, delete, update
as
select * from inserted
select * from deleted


update o set freight = 100 where orderid = 10248



create trigger trgauforders on orders
instead of insert, delete, update
as
select * from inserted
select * from deleted

update orders set freight = 100 where orderid = 10248

--nicht geändert
select * from orders where orderid = 10248

disable trigger trgaufo on o


create trigger trgvarsche1 on o
for  insert, delete, update
as
rollback

delete from o where orderid = 10248

select * from o where orderid = 10248


-->RngSumme mit F()
--mit Trigger: jede Änderung an Order details abfange
--und in die fixe Spalte RNGSUMME (MONEY) den aktuellen RngSumme wert reinschrieben


--Trigger ist per se langsam









--Ergänze die Tabelle orders um Spalte
--Rsumme money

--Erstelle einen Trigger
--der bei Änderung in Order details
--die Rsumme updatet


create trigger trgname1 on o Tabelle
for  insert, delete, update
as
CODE
inserted 
deleted


alter trigger trgWatching 	 on o
for insert, update, delete
as
select * from o
rollback

select top 1 * from o

update o set employeeid = 1 where orderid = 10248













alter table orders add Rsumme money


CREATE trigger trgRsumme on [Order details]
for 
INSERT, UPDATE
as
--Variablen für RSumme und Bestnummer
declare @BestNr as int , @Rsumme as money

--RSumme und Bestnummer rausfinden
select @bestnr = orderid from inserted 


select @rsumme =sum(unitprice*quantity) from [order details]
where orderid = @bestnr

--Update auf Rsumme in Orders
update Orders set rsumme = @Rsumme 
	where orderid = @Bestnr
GO



 select * from [order details]

begin tran
 update [order details] set quantity = 1 
 where	orderid = 10248 and Productid = 11
 rollback

 select * from orders


 --DDL	reagieren auf CREATE DROP UND ALTER


 create trigger trgDDL on Database
 for DDL_DATABASE_LEVEL_EVENTS
 as
 select eventdata()

 create table t123 (id int)


 --Loggingtabelle in der alle Ereginisse protkolliert werden
 --die Objekte ändern , löschen oder anlegen

 create table logging (
	id int identity
	, message xml
	, Wann datetime
	, wer varchar(50)
	, Vonwo varchar(50)
	, Software varchar(50)
	)


 create trigger trgLogging on Database
	for DDL_DATABASE_LEVEL_EVENTS
AS
	insert into logging
	select eventdata(), 
			getdate(), SUSER_NAME(), 
			HOST_NAME(), APP_NAME()


drop table t123

select * from logging


sp_Send_dbMail



	











