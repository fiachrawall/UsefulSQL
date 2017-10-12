-- Handy Queries to get info about Tables, Colums etc


-- standard beginning of query
use [zazzle]
SET ANSI_NULLS ON;
SET ANSI_WARNINGS OFF;
SET QUOTED_IDENTIFIER ON;
SET ARITHABORT OFF;


-- Find Tables with "ColumnName"
select * from INFORMATION_SCHEMA.COLUMNS 
where COLUMN_NAME like '%ColumnName%' 
order by TABLE_NAME

	-- Another method for above

SELECT      COLUMN_NAME AS 'ColumnName'
            ,TABLE_NAME AS  'TableName'
FROM        INFORMATION_SCHEMA.COLUMNS
WHERE       COLUMN_NAME LIKE '%MyName%'
ORDER BY    TableName
            ,ColumnName;

-- Find tables with columns containing "string"

SELECT 'select *  from ' + TABLE_NAME + '  where ColumnName = ''text'''
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ColumnName'


-- Find all poss column values

SELECT DISTINCT 'ColumnName'
	FROM dbo.tb_table

-- Get Table columns
SELECT column_name, data_type, CHARACTER_MAXIMUM_LENGTH
  FROM INFORMATION_SCHEMA.columns a
  WHERE table_name = 'DataBase.dbo.tb_table'


-- Group by MonthYear Function
SELECT
dbo.fn_FloorDateMonth (tb_name.dtmCreated) [MonthYear]

	-- Dirty Version

group by  datename(m,tb_name.dtmCreated)+' '+cast(datepart(yyyy,tb_name.dtmCreated) as varchar)


-- Currnecy Convert function
dbo.fn_CurrencyConvert(tb_name.intAmount, chvCurrencyCode, N'USD', tb_name.dtmCreated)

	-- in practise 
dbo.fn_FormatCurrency(SUM(CASE WHEN tb_name.chvCurrencyCode = N'USD' THEN tb_name.intAmount ELSE dbo.fn_CurrencyConvert(tb_name.intAmount, chvCurrencyCode, N'USD', tb_name.dtmCreated) END), N'USD')

