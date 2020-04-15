CREATE PROCEDURE [dbo].[loadUsageDataToFinalTbl] @startDate varchar(1000),  @endDate varchar(1000), @stagetblname varchar(1000) 
as

--delete from UsageDetails where Date >= @startDate and Date <= @endDate;

WHILE @@rowcount > 0
BEGIN
  SET ROWCOUNT 100000
  DELETE FROM UsageDetailsFinal WITH(ROWLOCK) WHERE date between @startDate  and @endDate  
END

SET ROWCOUNT 0
declare @query nvarchar(max);
set @query = 'insert into UsageDetailsFinal '+
'SELECT  '+
'AccountId	 as AccountId	, '+
'AccountName	 as AccountName	, '+
'AccountOwnerEmail	 as AccountOwnerEmail	, '+
'AdditionalInfo	 as AdditionalInfo	, '+
'ConsumedQuantity	 as ConsumedQuantity	, '+
'ConsumedService	 as ConsumedService	, '+
'ConsumedServiceId	 as ConsumedServiceId	, '+
'Cast(Cost as numeric(30,15))	 as Cost	, '+
'CostCenter	 as CostCenter	, '+
'Cast(Date as Date)	 as Date	, '+
'DepartmentId	 as DepartmentId	, '+
'DepartmentName	 as DepartmentName	, '+
'InstanceId	 as InstanceId	, '+
'MeterCategory	 as MeterCategory	, '+
'MeterId	 as MeterId	, '+
'MeterName	 as MeterName	, '+
'MeterRegion	 as MeterRegion	, '+
'MeterSubCategory	 as MeterSubCategory, '+
'Product	 as Product	, '+
'ProductId	 as ProductId	, '+
'ResourceGroup	 as ResourceGroup	, '+
'ResourceLocation	 as ResourceLocation	, '+
'ResourceLocationId	 as ResourceLocationId	, '+
'Cast(ResourceRate  as numeric(20,10))	 as ResourceRate	, '+
'ServiceAdministratorId	 as ServiceAdministratorId	, '+
'ServiceInfo1	 as ServiceInfo1	, '+
'ServiceInfo2	 as ServiceInfo2	, '+
'StoreServiceIdentifier	 as StoreServiceIdentifier	, '+
'SubscriptionGuid	 as SubscriptionGuid	, '+
'SubscriptionId	 as SubscriptionId	, '+
'SubscriptionName	 as SubscriptionName	, '+
'Tags	 as Tags	, '+
'UnitOfMeasure	 as UnitOfMeasure	, '+
'PartNumber	 as PartNumber	, '+
'ResourceGuid	 as ResourceGuid	, '+
'OfferId	 as OfferId	, '+
'ChargesBilledSeparately	 as ChargesBilledSeparately	, '+
'Location	 as Location	, '+
'ServiceName	 as ServiceName	, '+
'ServiceTier	 as ServiceTier	, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.DeptName'') else '''' end as TagsDeptName , '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.LOB'') else '''' end as TagsLOB , '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.CostCode'') else '''' end as TagsCostCode , '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.EnvType'') else '''' end as TagsEnvType, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.Sensitivity'') else '''' end as TagsSensitivity, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.SenType'') else '''' end as TagsSenType, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.Deployer'') else '''' end as TagsDeployer, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.DeployDate'') else '''' end as TagsDeployDate, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.LegalSubEntity'') else '''' end as TagsLegalSubEntity, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.SubDivision'') else '''' end as TagsSubDivision, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.Department'') else '''' end as TagsDepartment, '+
'CASE WHEN len(tags) > 0 THEN JSON_VALUE(tags, ''$.CostCenter'') else '''' end as TagsCostCenter '+
' FROM [' + @stagetblname +
'] ;' 


Execute(@query);


declare @droptablequery nvarchar(1000);
set @droptablequery = 'drop table  [' + @stagetblname + '];' 

Execute(@droptablequery);
