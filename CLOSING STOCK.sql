SELECT 
    Date, 
    [Item Name], 
    [Material Center], 
    SUM([Closing Stock]) AS 'Closing Stock' ,
	sum([Closing Stock]) over(partition by [Item Name] order by Date) as [Closing Stock Running Balance]
FROM (
 
    SELECT 
        '01-04-1999' AS Date,
        m1.name AS 'Item Name',
        m2.name AS 'Material Center',
        tran4.D1 AS 'Closing Stock'
    FROM Tran4 
    LEFT JOIN master1 m1 ON m1.code = Tran4.MasterCode1 
    LEFT JOIN master1 m2 ON m2.code = tran4.MasterCode2
    
    UNION ALL
    
    
    SELECT 
        d.Date,
        m1.name AS 'Item Name', 
        m2.name AS 'Material Center',
        SUM(COALESCE(d.Cr1, 0) - COALESCE(d.Dr1, 0)) AS 'Closing Stock'
    FROM DailySum d
    LEFT JOIN master1 m1 ON m1.code = d.MasterCode1 
    LEFT JOIN master1 m2 ON m2.code = d.MasterCode2
    WHERE d.MasterType = 6 
      AND d.MasterCode2 > 0 
    GROUP BY d.Date, m1.name, m2.name
) AS temp
GROUP BY Date, [Item Name], [Material Center],[Closing Stock]