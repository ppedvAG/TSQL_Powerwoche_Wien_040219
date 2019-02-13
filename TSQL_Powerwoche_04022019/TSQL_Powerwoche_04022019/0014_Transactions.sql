--Transactions

--mit Hilfe von TX können wir Dinge rückgängig machen

--alles oder nix Lösung


--TX müssen "erklärt werden"

begin transaction

delete from custmitS	  --versehenltich where vergessen
where customerid = 'SAVEA'
--tabelle leer

select * from custmits

rollback	--rückgängig
--oder
commit --fix drin

