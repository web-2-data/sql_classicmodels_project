/* -- Requête qui permet de créer la vue FINANCE 
-------------------------------------------------
------------------------------------------------*/

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
la utilisé utilisées : customerNumber, customerName, amount, quantityordered, priceEach,productLine,buyPrice
il requête est partie de la table payments  pour finir sur la table products (sens de la jointure)
*/
 ALTER VIEW vue_finance AS
-- CREATE VIEW vue_finance AS
select 
	payments.amount,
    payments.paymentDate,
    customers.customerName,
    customers.customerNumber,
    customers.creditLimit,
    orders.orderNumber,
    orders.orderDate,
    orders.shippedDate,
    orders.status,
    orderdetails.priceEach,
    orderdetails.quantityOrdered,
    products.productLine,
    products.buyPrice,
    products.MSRP,
    products.productCode,
    products.productName,
    products.productVendor
from payments
-- la jointure left join est utilisée pour récupérer tous les payments
left join customers
USING (customerNumber)
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et customers
left join orders
on customers.customerNumber=orders.customerNumber
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join orderdetails 
on orderdetails.orderNumber = orders.orderNumber
-- utilisation de la jointure left join  idem que l'expliction précédente / jointure entre le resultatde la requête précedente et orders
left join products
on products.productCode = orderdetails.productCode
 ;