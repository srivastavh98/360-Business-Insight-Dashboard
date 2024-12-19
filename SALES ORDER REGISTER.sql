select t.no as 'Sale Order No',t.Date,m2.name as 'Party Name' , 
m1.name as 'Item Name', t.value1 as 'Order Qty',
coalesce(t1.Value1,0) * -1 as 'Sales Qty' ,coalesce(t2.Value1,0) * -1 as 'Cleared Qty' , 
(coalesce(t.Value1,0) + coalesce(t1.Value1,0) + + coalesce(t2.Value1,0)) as 'Pending Qty' 
from Tran3 as t 
left join master1 m1 on m1.code = t.MasterCode1
left join master1 m2 on m2.code = t.MasterCode2
left join tran3 t1 on t1.RefCode = t.RefCode and t.MasterCode1 = t1.MasterCode1 
and t.MasterCode2 = t1.MasterCode2 
and t1.VchType in (9) and t1.RecType = t.RecType and t1.Method = 2
left join tran3 t2 on t2.RefCode = t.RefCode and t.MasterCode1 = t2.MasterCode1 
and t.MasterCode2 = t2.MasterCode2 
and t2.VchType in (51) and t2.RecType = t.RecType and t2.Method = 2
where t.RecType = 4 and t.VchType = 12 and t.Method = 1