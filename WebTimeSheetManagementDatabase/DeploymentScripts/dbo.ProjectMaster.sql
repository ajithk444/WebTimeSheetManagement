CREATE PROCEDURE [dbo].[Populate_dbo_ProjectMaster]
AS
BEGIN
/*
	Table's data:    [dbo].[ProjectMaster]
	Data Source:     [DESKTOP-S4VLAOQ].[TimesheetDB]
	Created on:      4/29/2021 2:21:57 PM
	Scripted by:     DESKTOP-S4VLAOQ\Alacer02
	Generated by:    Data Script Writer - ver. 2.3.0.0
	GitHub repo URL: https://github.com/SQLPlayer/DataScriptWriter/
*/
PRINT 'Populating data into [dbo].[ProjectMaster]';

IF OBJECT_ID('tempdb.dbo.#dbo_ProjectMaster') IS NOT NULL DROP TABLE #dbo_ProjectMaster;
SELECT [ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode] INTO #dbo_ProjectMaster FROM [dbo].[ProjectMaster] WHERE 0=1;

SET IDENTITY_INSERT #dbo_ProjectMaster ON;

INSERT INTO #dbo_ProjectMaster 
 ([ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode])
SELECT CAST([ProjectID] AS int) AS [ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode] FROM 
(VALUES
	  (1,	'ABC Bearings Ltd',	'Bearings',	'A001')
	, (2,	'Alok Industries Ltd',	'Textile',	'A002')
	, (3,	'Ambuja Cement Ltd',	'Cement',	'A003')
	, (4,	'Anil Bioplus Ltd (Anil Group Ahmedabad)',	'Chemicals',	'A004')
	, (5,	'Ansa Pack    (Simplex Group)',	'Packaging',	'A005')
	, (6,	'Aries Agro Ltd',	'Fertilizer',	'A006')
	, (7,	'Arkema India Pvt Ltd',	'Chemicals',	'A007')
	, (8,	'ATC Tires Pvt Ltd  (Yokohama Group)',	'Industrial Tyres',	'A008')
	, (9,	'Atul Bioscience Ltd. (Lalbhai Group)',	'Chemicals',	'A009')
	, (10,	'Atul Ltd.   (Lalbhai Group)',	'Chemicals',	'A010')
) as v ([ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode]);


SET IDENTITY_INSERT #dbo_ProjectMaster OFF;

SET IDENTITY_INSERT [dbo].[ProjectMaster] ON;


WITH cte_data as (SELECT CAST([ProjectID] AS int) AS [ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode] FROM [#dbo_ProjectMaster])
MERGE [dbo].[ProjectMaster] as t
USING cte_data as s
	ON t.[ProjectID] = s.[ProjectID]
WHEN NOT MATCHED BY target THEN
	INSERT ([ProjectID], [ProjectName], [NatureofIndustry], [ProjectCode])
	VALUES (s.[ProjectID], s.[ProjectName], s.[NatureofIndustry], s.[ProjectCode])
WHEN MATCHED THEN 
	UPDATE SET 
	[ProjectName] = s.[ProjectName], [NatureofIndustry] = s.[NatureofIndustry], [ProjectCode] = s.[ProjectCode]
WHEN NOT MATCHED BY source THEN
	DELETE
;

SET IDENTITY_INSERT [dbo].[ProjectMaster] OFF;

DROP TABLE #dbo_ProjectMaster;

-- End data of table: [dbo].[ProjectMaster] --
END
GO
