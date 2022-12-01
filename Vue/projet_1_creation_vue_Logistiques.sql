-- création de vue logistique
create view view_loqistique as 
/*-- vue créée pour les calculs des KPI de la logistique 
-------------------------------------------------
------------------------------------------------*/
-- selection de tous les champs dont on aura besoins pour faire les calculs 
select pn.productCode,
       pl.productLine,
       pn.productName,
       pn.productVendor,
       pn.quantityInStock,
       o.quantityOrdered,
       os.orderDate,
       os.status,
       ofi.city as city_office,
       ofi.country as county_office,
       c.city as city_customers,
       c.country as country_customers
      
/* -- Requête qui permet de créer la vue logisqtique
-------------------------------------------------
------------------------------------------------*/

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
la utilisé utilisées : products, productlines, orderdetails, orders, customers,employees,offices
 (sens de la jointure)
*/


from products as pn
-- la jointure left join est utilisée pour récupérer les service qui n'ont pas d'employé affectés / jointure entre offices et employees
left join productlines as pl
on pl.productLine=pn.productLine

-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et customers
left join orderdetails as o
on pn.productCode=o.productCode
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join orders as os
on o.orderNumber=os.orderNumber
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join customers as c
on c.customerNumber= os.customerNumber

left join employees as e
on e.employeeNumber= c.salesRepEmployeeNumber

left join offices as ofi
on ofi.officeCode = e.officeCode;




