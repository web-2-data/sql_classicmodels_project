/* Panier moyen totale cette année par mois Vs l'année derniere par mois 
utilisation de la vue vue_finance
*/

CREATE VIEW view_sales_produitmoyen_mois AS
SELECT Panier_Moyen2022,Panier_Moyen2021, mois FROM (
SELECT YEAR(shippedDate) AS annee,MONTH(shippedDate) AS mois,round(sum(quantityOrdered* priceEach)/count(orderNumber)) AS Panier_Moyen2022
from vue_finance
WHERE YEAR(shippedDate) = YEAR(CURDATE()) AND 
status in ('Shipped','Resolved')
GROUP BY MONTH(shippedDate)) AS PM_2022
JOIN (
SELECT YEAR(shippedDate) AS annee,MONTH(shippedDate) AS mois,round(sum(quantityOrdered* priceEach)/count(orderNumber)) AS Panier_Moyen2021
from vue_finance
WHERE YEAR(shippedDate) = YEAR(CURDATE())-1 AND 
status in ('Shipped','Resolved')
GROUP BY MONTH(shippedDate)) AS PM_2021
USING (mois);
