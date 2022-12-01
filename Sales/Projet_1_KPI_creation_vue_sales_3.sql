drop view view_sales;
/* -- Script de création de la vue SALES 
-------------------------------------------------
------------------------------------------------*/
-- Création de la vue SALES
CREATE VIEW view_sales as 
/* -- Requête qui permet de créer la vue sales
-------------------------------------------------
------------------------------------------------*/

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
les tabales utilisées : productlines,products,orderdetails,orders,customers, offices
la requête est partie de la table productlines  pour finir sur la table customers (sens de la jointure)
*/
select 
	pl.productLine,
    p.productCode,
    p.productName,
    p.productVendor,
    p.quantityInStock,
    p.buyPrice,
    od.quantityOrdered,
    od.priceEach,
    od.quantityOrdered*od.priceEach as ca,
    o.orderNumber,
    o.orderDate,
    o.requiredDate,
    o.shippedDate,
    o.status,
    c.customerNumber,
    c.customerName  as compagny_name,
    c.contactLastName,
    c.contactFirstName,
    c.city as city_customer,
    c.country as country_customer, 
    ofi.country as country_office,
    ofi.city as city_office,
    c.creditLimit
from productlines as pl
-- la jointure left join est utilisée pour récupérer les productline qui n'ont pas de produits affectés / jointure entre productlines et products
left join products as p using (productLine)
-- utilisation de la jointure left join  idem que l'explication précédente / jointure entre le resultat de la requête précedente et orderdetails
left join orderdetails as od using (productCode)
-- utilisation de la jointure left join  idem que l'explication précédente / jointure entre le resultat de la requête précedente et orders
left join orders as o using (orderNumber)
-- utilisation de la jointure left join  idem que l'explication précédente / jointure entre le resultat de la requête précedente et customers
left join customers as c using (customerNumber)
-- utilisation de la jointure left join idem que l'explication précédente / jointure entre le resultat de la requête précedente et employees
left join employees as e on c.salesRepEmployeeNumber = e.employeeNumber
-- utilisation de la jointure left join idem que l'explication précédente / jointure entre le resultat de la requête précedente et offices
left join offices as ofi using (officeCode);