-- ============================================================
-- SEED: DBFLMENUREPORT - Grant Access untuk 11 Reports
-- Purpose: Allow all admin users to access the 11 complex reports
-- ============================================================
USE dbbcagroup;
GO

-- Get all active users from DBFLPASS
DECLARE @UserList TABLE (UserID VARCHAR(50));
INSERT INTO @UserList (UserID)
SELECT DISTINCT UserID FROM DBFLPASS WHERE TF = 1 AND STATUS = 0;

-- Grant access for all active users to the 11 report menus
INSERT INTO DBFLMENUREPORT (UserID, L1, Access, IsDesign, Isexport, Tf)
SELECT 
    ul.UserID,
    CASE m.KODEMENU
        WHEN '0303301' THEN '0303301'
        WHEN '0303302' THEN '0303302'
        WHEN '025801' THEN '025801'
        WHEN '020507' THEN '020507'
        WHEN '0303303' THEN '0303303'
        WHEN '0303304' THEN '0303304'
        WHEN '025902' THEN '025902'
        WHEN '020406' THEN '020406'
        WHEN '025802' THEN '025802'
        WHEN '050102' THEN '050102'
        WHEN '050103' THEN '050103'
    END AS L1,
    1 AS Access,
    0 AS IsDesign,
    1 AS Isexport,
    1 AS Tf
FROM @UserList ul
CROSS JOIN (
    SELECT '0303301' AS KODEMENU UNION ALL
    SELECT '0303302' UNION ALL
    SELECT '025801' UNION ALL
    SELECT '020507' UNION ALL
    SELECT '0303303' UNION ALL
    SELECT '0303304' UNION ALL
    SELECT '025902' UNION ALL
    SELECT '020406' UNION ALL
    SELECT '025802' UNION ALL
    SELECT '050102' UNION ALL
    SELECT '050103'
) m
WHERE NOT EXISTS (
    SELECT 1 FROM DBFLMENUREPORT d 
    WHERE d.UserID = ul.UserID AND d.L1 = m.KODEMENU
);

PRINT 'Access granted for 11 reports to all active users';
GO

-- Verify
SELECT L1, COUNT(DISTINCT UserID) as user_count FROM DBFLMENUREPORT
WHERE L1 IN ('0303301','0303302','025801','020507','0303303','0303304','025902','020406','025802','050102','050103')
GROUP BY L1 ORDER BY L1;
GO