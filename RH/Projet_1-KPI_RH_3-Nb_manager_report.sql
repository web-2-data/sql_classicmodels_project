
-- CREATE OR REPLACE VIEW view_pbi_managerreportto AS 
select 
 reportsTo as manager, count( distinct employeeNumber) as 'nb employe'
from view_rh
group by reportsTo;