select '01-04-1999' as Date , 'opening' as Vchno , m1.name as [Account Name], 'op' as [Vch Type],
m2.name as 'Group',case when Folio1.D1 < 0 then (Folio1.D1 * -1) else 0 end as [Dr Amount],
case when Folio1.D1 > 0 then (Folio1.D1 ) else 0 end as [Cr Amount],
case when Folio1.D1 < 0 then (Folio1.D1 * -1) else Folio1.D1 * -1 end as [Temp Balance] 
from Folio1 
left join master1 m1 on m1.code = Folio1.MasterCode
left join master1 m2 on m2.code = m1.ParentGrp
where folio1.MasterType = 2 and Folio1.D1 !=0  
union all
select Date , VchNo , m1.Name as [Account Name],
case when vchtype = 19 then 'Payment' when VchType = 14 then 'Receive' 
when vchtype = 9 then 'sales'when VchType = 2 then 'Purchase' end as [Vch Type],
m2.name as 'Group',case when value1 < 0 then (value1 * -1) else 0 end as [Dr Amount],
case when value1 > 0 then (value1 ) else 0 end as [Cr Amount],
case when value1 < 0 then (value1 * -1) else value1 * -1 end as [Temp Balance]
from tran2
left join master1 m1 on m1.code = tran2.mastercode1
left join master1 m2 on m2.code = m1.ParentGrp
where RecType in (1,7)