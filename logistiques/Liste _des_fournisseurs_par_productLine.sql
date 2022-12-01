-- Liste des fournisseurs par productLine
-- on utlise la vue logistique
-- creation de vue productLine par ProductVendor 

-- create view productline_productvendor as 
select  distinct productVendor,productLine from view_loqistique

order by productVendor,productLine  ;

select count(*) from (select distinct productVendor from view_loqistique) as distinct_prodvendor;

