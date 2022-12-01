-- marge moyenne productline
-- marge produit ==> prix de vente(priceEach) - prix d'achat(BuyPrice)
-- utilisation de la vue_finance
SELECT productCode,priceEach,buyPrice, priceEach-buyPrice as profit
FROM vue_finance
WHERE productCode ='S18_1749'
;

-- il y a plusieurs prix par produit donc on fait un average
select productCode, avg(priceEach)
from vue_finance
group by productCode
;


-- ressort tous les products code avec la marge
WITH tableau_marge_par_produit AS (
SELECT productCode,productLine,prix_moyen_vente_produit-buyPrice as profit_sur_produit 
FROM (
SELECT productCode,productLine,buyPrice, avg(priceEach) AS prix_moyen_vente_produit
from vue_finance
group by productCode)
as fffff
)
SELECT productLine,avg(profit_sur_produit) as marge_moyenne
from tableau_marge_par_produit 
GROUP BY productLine 
ORDER BY marge_moyenne DESC
;

/* interpretation : Marge par catégorie de produit. La catégorie Classique Cars est la 
catégorie ou la marge est la plus importante.*/
