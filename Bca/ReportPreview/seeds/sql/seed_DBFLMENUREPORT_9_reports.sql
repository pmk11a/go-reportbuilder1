-- ============================================================
-- SEED: DBFLMENUREPORT - Grant Access untuk 9 Laporan Baru
-- ============================================================
USE dbbcagroup;
GO

-- Get all active users from DBFLPASS
DECLARE @UserList TABLE (UserID VARCHAR(50));
INSERT INTO @UserList (UserID)
SELECT DISTINCT UserID FROM DBFLPASS WHERE TF = 1 AND STATUS = 0;

-- Grant access for all active users to the 9 report menus
INSERT INTO DBFLMENUREPORT (UserID, L1, Access, IsDesign, Isexport, Tf)
SELECT 
    ul.UserID,
    m.KODEMENU AS L1,
    1 AS Access,
    0 AS IsDesign,
    1 AS Isexport,
    1 AS Tf
FROM @UserList ul
CROSS JOIN (
    SELECT '020507' AS KODEMENU UNION ALL
    SELECT '020406' UNION ALL
    SELECT '0303301' UNION ALL
    SELECT '0303302' UNION ALL
    SELECT '025801' UNION ALL
    SELECT '0303303' UNION ALL
    SELECT '0303304' UNION ALL
    SELECT '025902' UNION ALL
    SELECT '025802' UNION ALL
    SELECT '050102' UNION ALL
    SELECT '050103'
) m
WHERE NOT EXISTS (
    SELECT 1 FROM DBFLMENUREPORT d 
    WHERE d.UserID = ul.UserID AND d.L1 = m.KODEMENU
);

PRINT 'Access granted for 9 reports to all active users';
GO

-- Verify
SELECT L1, COUNT(DISTINCT UserID) as user_count FROM DBFLMENUREPORT
WHERE L1 IN ('020507','020406','0303301','0303302','025801','0303303','0303304','025902','025802','050102','050103')
GROUP BY L1 ORDER BY L1;
GO
