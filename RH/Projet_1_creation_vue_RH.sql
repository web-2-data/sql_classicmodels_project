/* -- Script de création de la vue RH 
-------------------------------------------------
------------------------------------------------*/

-- Création de la vue RH
CREATE VIEW view_rh as 
/* -- Requête qui permet de créer la vue RH 
-------------------------------------------------
------------------------------------------------*/

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
la utilisé utilisées : offices, employees, customers, orders, orderdetails
il requête est partie de la table offices  pour finir sur la table orderdetails (sens de la jointure)
*/

select 
	e.lastName,
	e.firstName,
	e.jobTitle,
	offices.officeCode,
	e.reportsTo,
	offices.city,
	offices.country,
	od.quantityOrdered * od.priceEach as CA_employe,
	e.employeeNumber,
	o.orderDate,
    o.requiredDate,
	o.shippedDate
from offices
-- la jointure left join est utilisée pour récupérer les services qui n'ont pas d'employé affectés / jointure entre offices et employees
left join employees as e
on offices.officeCode= e.officeCode
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et customers
left join customers as c
on e.employeeNumber=c.salesRepEmployeeNumber
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join orders as o
on c.customerNumber = o.customerNumber
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join orderdetails as od
on o.orderNumber = od.orderNumber
where o.status in ("shipped","resolved") ;