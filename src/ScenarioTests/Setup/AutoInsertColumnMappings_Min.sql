-- select * from reportcolumnmapping  where uniquename like '%_Min'
-- delete from reportcolumnmapping where uniquename like '%_Min'

  
INSERT INTO [dbo].[ReportColumnMapping]
           ([DataSourceTypeId]
           ,[UniqueName]
           ,[DisplayName]
           ,[MainCategory]
           ,[KnownTable]
           ,[FieldName]
           ,[IsCalculated]
           ,[FieldAggregationMethod]
           ,[DbType]
		   ,[Selectable]
           ) 
SELECT 
1 as [DataSourceTypeId]
, CONCAT(c.table_name, '_', c.column_name, '_Min') as [UniqueName]
, CONCAT(c.table_name, ' ', c.column_name, ' Min') as [DisplayName]
, c.table_name as [MainCategory]
, c.table_name as [KnownTable]
, c.column_name as [FieldName]
, 0 as [IsCalculated]
, 'Min' as [FieldAggregationMethod]
, CASE
WHEN   data_type = 'int' then 'Int32'
WHEN   data_type = 'bigint' then 'Int64'
WHEN   data_type = 'decimal' then 'Decimal'
WHEN   data_type = 'datetime' then 'DateTime'
ELSE 'String' END 
as [DbType]
, 1 as [Selectable]
FROM [MagiQL].[INFORMATION_SCHEMA].[COLUMNS] c
 
 where not exists (select 1 from reportcolumnmapping where knowntable = c.table_name and fieldname = c.column_name and uniquename like '%_Min')
 and  table_name in ('room','roomsensor')

 and data_type in (  'int'  ,'bigint'  ,'decimal' ,'datetime')
 
 order by table_name, ordinal_position
