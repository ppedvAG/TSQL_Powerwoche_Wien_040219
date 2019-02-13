				   
with cte (Famname, angID, VorgID, level)	   as
(select lastname as Famname, employeeid as AngID, reportsto as Vorgid, 1 as Level
	from employees where reportsto is null
 UNION	 all
 select lastname, employeeid, reportsto, level +1 from employees e
		inner join cte on  e.reportsto  = cte.AngID	)
select * from cte
