select t.Date,t.VchNo,m1.name
as 'Party Name',m4.name as State , m2.name as 'Item Name',
m3.name as 'Material Center',(t.Value1 * -1) as 'Sales Qty' , 
(t.Value3 * -1) as 'Taxable Amount',(coalesce(TaxRate,0) + coalesce(TaxRate1,0)) as 'Tax Rate', 
(coalesce(TaxAmt,0) + coalesce(TaxAmt1,0)) as 'Tax Amount',
((coalesce(TaxAmt,0) + coalesce(TaxAmt1,0)) + (t.Value3 * -1)) as Amount
from tran2 as t
left join master1 m1 on m1.code = t.cm1                     --------Party Name
left join Master1 m2 on m2.code = t.MasterCode1             --------Item Name     
left join master1 m3 on m3.code = t.MasterCode2             --------Material Center
left join VchGSTSumItemWise vgsi on vgsi.VchCode = t.VchCode and t.MasterCode1 = vgsi.ItemCode 
and t.VchType = vgsi.VchType and t.SrNo = vgsi.ItemSrNo
left join Master1 m4 on m4.code = vgsi.PartyStateCode       --------State
where t.VchType = 9 and t.RecType in (2,7)
order by t.VchNo