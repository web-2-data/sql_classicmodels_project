-- FINANCE > CLIENTS QUI DOIVENT DE L'ARGENT (en gros montant commande- le montant payé ), aevec leur limite de crédit
-- CREATE VIEW kpi_client_montant_a_payer AS
CREATE VIEW  kpi_vue_fin_client_montant_a_payer AS
WITH tableau_paid_credit AS (
SELECT customers.customerNumber, creditLimit,customerName,
(SELECT sum(amount)
FROM payments 
WHERE customerNumber = customers.customerNumber )AS paid_amount,
(SELECT sum(quantityOrdered*priceEach)
FROM orderdetails 
LEFT JOIN orders
USING (orderNumber)
WHERE customerNumber = customers.customerNumber AND  orders.status !='Cancelled' ) AS prix_tot_des_commandes
FROM customers
GROUP BY customerNumber
ORDER BY customerNumber ASC)

-- suite pour utiliser le tableau ci-dessus 
SELECT customerName, prix_tot_des_commandes,paid_amount,sum(prix_tot_des_commandes-paid_amount) as Montant_a_payer
FROM tableau_paid_credit
WHERE prix_tot_des_commandes-paid_amount>0 
GROUP BY prix_tot_des_commandes-paid_amount;

-- FINANCE > MONTANT TOTAL IMPAYÉ
WITH tableau_paid_credit AS (
SELECT customers.customerNumber, creditLimit,customerName,
(SELECT sum(amount)
FROM payments 
WHERE customerNumber = customers.customerNumber )AS paid_amount,
(SELECT sum(quantityOrdered*priceEach)
FROM orderdetails 
LEFT JOIN orders
USING (orderNumber)
WHERE customerNumber = customers.customerNumber AND  orders.status !='Cancelled' ) AS prix_tot_des_commandes
FROM customers
GROUP BY customerNumber
ORDER BY customerNumber ASC)

-- suite pour utiliser le tableau ci-dessus 
SELECT  sum(prix_tot_des_commandes-paid_amount) as Montant_a_payer
FROM tableau_paid_credit
WHERE prix_tot_des_commandes-paid_amount>0 
