delete reportcolumnmappingmetadata 
from reportcolumnmappingmetadata 
inner join reportcolumnmapping on reportcolumnmapping.id = reportcolumnmappingmetadata.reportcolumnmappingid 
where reportcolumnmapping.datasourcetypeid = 1

delete from reportcolumnmapping where datasourcetypeid = 1