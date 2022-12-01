
-- Les 5 produits le plus commandés
-- utilisation de la vue logistque

create view top_5_products as 
SELECT productName, sum(quantityOrdered)
FROM view_loqistique
GROUP BY productCode
ORDER BY SUM(quantityOrdered) DESC LIMIT 5;



