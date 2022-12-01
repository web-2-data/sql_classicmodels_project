/* -- Script de création de la vue Nombre de vente par mois par  produit et par année pour Power bi
 Nombre de produits vendus par produit et par mois avec comparaison 
sur le même mois de l'année précédente  - filtre pour avoir les prod les moins vendu
(taux de varitation sur le mois de l'année précédente) 
-------------------------------------------------
------------------------------------------------*/

-- Création de la vue  
CREATE VIEW view_pbi_venteprod_mois as 
/* -- requête permettant de créer la vue 
-------------------------------------------------
------------------------------------------------*/

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
 une seule vue est utiliée : view_sales
réalisation de 2 requête imbriquées sur la même table car nous avons eu besoin de comaparer 
les tuples/ennregistrement de la même table.
*/

SELECT 
-- recupération du productline, année, mois de l'année Année de la ligne en cours
reqA.productName as Produit,
reqA.productLine as 'Ligne Produit',
year(reqA.shippedDate) as 'Année',
month(reqA.shippedDate) as 'Mois',
-- calcul du la somme de quantité pour l'année de la ligne en cours
sum(reqA.quantityOrdered) as Nb,
/*
 calcul de la variation = 1- ( NbP/Nb )
 NbP = la somme des quantités commandées de la ligne précédente depuis la vue view_sales de l'année 
 de la ligne en cours - 1 et le mois reste inchangé)
*/
(sum(reqA.quantityOrdered)/(SELECT sum(quantityOrdered)
	FROM toys_and_models.view_sales as reqP
	where
    -- indication de la ligne produit à rechercher pour cette somme
    reqA.productName=reqP.productName
    and
	-- indication de la ligne produitline à rechercher pour cette somme
    reqA.productLine=reqP.productLine
    and
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1
	and 
     -- indication de la ligne du mois à rechercher pour cette somme
		month(reqP.shippedDate)=month(reqA.shippedDate)))-1 as 'Evol %/N-1',
        
     -- calcul de la vadiation en montant   
	sum(reqA.quantityOrdered)-(SELECT sum(quantityOrdered)
	FROM toys_and_models.view_sales as reqP
	where
    -- indication de la ligne produit à rechercher pour cette somme
    reqA.productName=reqP.productName
    and
	-- indication de la ligne produitline à rechercher pour cette somme
    reqA.productLine=reqP.productLine
    and
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1
	and 
     -- indication de la ligne du mois à rechercher pour cette somme
		month(reqP.shippedDate)=month(reqA.shippedDate)) as 'Evol Mtt/N-1'
        
        
FROM toys_and_models.view_sales as reqA
--  toutes les tuple /enregistrement qui ne disposent pas de date d'envoi ne rentre pas dans le nombre de produits vendus 
where shippedDate is not null
--  regroupement des tuples par productLine, month, et year
group by reqA.productName,reqA.productLine, month(reqA.shippedDate),year(reqA.shippedDate)
-- trie par productLine, month, et year
order by reqA.productName asc,reqA.productLine asc, month(reqA.shippedDate) asc, year(reqA.shippedDate);