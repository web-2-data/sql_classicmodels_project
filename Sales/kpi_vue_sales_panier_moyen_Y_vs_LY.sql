/* Panier moyen totale cette année Vs last year */


create OR replace VIEW view_sales_paniermoyen_annee AS

SELECT * FROM (
select round(sum(quantityOrdered* priceEach)/count(orderNumber)) as 'Annnée N'
from  vue_finance
WHERE YEAR(shippedDate) = YEAR(CURDATE()) AND 
status in ('Shipped','Resolved')
GROUP BY YEAR(shippedDate)) as P_M_2022
JOIN(
select round(sum(quantityOrdered* priceEach)/count(orderNumber)) as 'Annnée N-1'
FROM vue_finance
WHERE YEAR(shippedDate) = YEAR(CURDATE())-1
AND 
status in ('Shipped','Resolved')
GROUP BY YEAR(shippedDate)  ) as P_M_2021
JOIN(
select round(sum(quantityOrdered* priceEach)/count(orderNumber)) as 'Annnée N-2'
FROM vue_finance
WHERE YEAR(shippedDate) = YEAR(CURDATE())-2
AND 
status in ('Shipped','Resolved')
GROUP BY YEAR(shippedDate)  ) as P_M_2020
;
