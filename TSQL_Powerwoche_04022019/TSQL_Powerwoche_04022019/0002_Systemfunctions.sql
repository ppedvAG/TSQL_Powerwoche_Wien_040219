--Systemfunctions

--Datumsf()

--aktuelle Datum
select getdate() --ms

--zu einem Datum 4 Tage dazu
select getdate() +4



--aber wie rechen ich mit anderen Zeiteinheiten
 --dateadd()

--Intervalle: dd, hh, mm, ss, qq, ww)


 select dateadd(dd, 4, '4.2.2019')	 --plus 4 Tage

 select dateadd(ww,2,'4.2.2019')		--18.2  

 --Welches Datum war vor 100 Tagen?
--auch negativ...
select dateadd(dd,-100, getdate())

select datediff(dd, '1.1.2019', '4.2.2019')	  --34
select datediff(dd,  '4.2.2019', '1.1.2019')  --   -34


--wieviele Tage sind seit eurer Geburt vergangen
--je nachdem negatives oder postivies Vorzeichen
select datediff(dd,getdate(), '4.7.1969')	    -- -18000

--Name der Zeiteinheit
--welcher Wochentag war der 1.1.2000?
select datename(dd, '20.1.2000')  --falsch

select datename(dw, '1.1.2000')  --korrekt


--Man braucht einen Teil eines Datums

select datepart(qq, getdate())

select datepart(ww, getdate())


select datepart(mm, getdate())

select datepart(yy, getdate())


select year(Getdate())

--welche Datum hat der der letzte Tag dieses Monats?

--Idee: Datum plus 1 Monat und dann datepart Tag +1 abziehen


--EOMONTH ;-) .. Para2 : plus x Monate 
select EOMONTH(Getdate(),2)


-----TEXTFUNKTIONEN
--von links
select left('abcdefg',2) --ab

--von rechts
select right('abcdefg', 2)  --fg


--Aber Vorsicht Datetypen:
--txt: char(50), varchar(50), text(), nchar(50), nvarchar(50)
-- n steht für UNICODE , nvarchar(50), nchar(50), ntext()
--n braucht doppelte

--Otto
 /*
varchar(50)   'otto'     4
char(50)      'Otto                               ' 50
nvarchar(50)  'otto'      8
nchar(50)     'otto                                ' 50*2

--evtl Leerezeichen abschneiden
--rtrim, ltrim
 */


select rtrim('otto        ')

--Längenmessung
--datalength und len
 select len('otto        ')		--4
 select datalength('otto        ')		--12
 --aber hier?:
  select len('       otto        ')	--die leerstellen vorne werden mitgezählt

 select datalength(ltrim('      Otto') )		--4


--Zeichenketten verketten

select 'A' + 'B'  --AB

select 'A' +10 --Error

select 'A'+ '10' --jetzt gehts wieder

--implizit kovertiert oder explizit

select convert(varchar(10),10) + 'A'

--substring


select substring('abcdefgh', 1,2) --left (..,2)
select substring('abcdefgh', 3,2) --  cd


--Zeichenkette durch eine andere ersetzen
select stuff('abcdefgh',3,2,'XXXXXX')


--reverse
select reverse('ein Neger mit Gazelle zagt im Regen nie')


-- 08677-998973	   --08677-998xxx

--egal wie die Telnummer aussieht: die letzte 3 Ziffern 
--müssen ausgeixt werden


select 	stuff('08677-998973123',len('08677-998973123')-2,3,'xxx')



select soundex('Maier')--m600

select soundex('Meyr')--m600

select soundex('Maierings')--m600


--Suchen nach Zeichen
SELECT PATINDEX('%w_ bin ich%', 'Hilfe, wo bin ich?')


SELECT CHARINDEX ( 'Te',  'Das ist ein Test'  )











