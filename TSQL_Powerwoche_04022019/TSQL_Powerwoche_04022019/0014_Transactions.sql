--Transactions

--mit Hilfe von TX k�nnen wir Dinge r�ckg�ngig machen

--alles oder nix L�sung


--TX m�ssen "erkl�rt werden"

begin transaction

delete from custmitS	  --versehenltich where vergessen
where customerid = 'SAVEA'
--tabelle leer

select * from custmits

rollback	--r�ckg�ngig
--oder
commit --fix drin

