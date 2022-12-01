/* interpretation : top 3 produits ou l'on peut faire le plus de marge 
donc en gros il faut pousser ces produits-ci pour profiter du faible prix d'achat vs le haut cout de vente*/

-- marge produit ==> prix de vente(priceEach) - prix d'achat(BuyPrice)
-- ressort tous les products code avec la marge

-- utilisation de la vue_finance
CREATE VIEW kpi_vue_fin_top3_marge_produit AS
WITH tableau_marge_par_produit AS (
SELECT productCode, productName,productLine,prix_moyen_vente_produit-buyPrice as profit_sur_produit 
FROM (
SELECT productCode,productName,productLine,buyPrice, avg(priceEach) AS prix_moyen_vente_produit
from vue_finance
group by productCode)
as fffff
)
SELECT productCode AS 'Code Produit',productName As 'Nom du produit',avg(profit_sur_produit) as marge_moyenne
from tableau_marge_par_produit 
GROUP BY productCode 
ORDER BY marge_moyenne DESC
LIMIT 3
;


