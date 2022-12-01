/* -- Script de création de la vue Chiffre d'affaires par année pour Power BI
 chiffre d'affaires par office et par année avec comparaison 
avec l'année précédente 
(taux de varitation sur le mois de l'année précédente) 
(Afficher CA  par OFFICE)
-------------------------------------------------
------------------------------------------------*/

-- Création de la vue
CREATE VIEW view_pbi_caOffice_annee as 
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
reqA.country_office as 'Pays (Bureau)',
reqA.city_office as 'Ville(Bureau)',
year(reqA.shippedDate) as 'Année',
-- calcul du la somme de quantité pour l'année de la ligne en cours
sum(reqA.ca) as 'Chiffre affaires',
/*
 calcul de la variation = 1- ( caP/Chiffre affaires )
 caP = la somme des chiffre d'affaires de la ligne précédente depuis la vue view_sales de l'année 
 de la ligne en cours - 1 et le mois reste inchangé)
 */
(sum(reqA.ca)/(SELECT sum(ca)
	FROM toys_and_models.view_sales as reqP
	where
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1))-1 as 'Evol %/N-1',
 -- Calcul de variation en montant
 sum(reqA.ca)-(SELECT sum(ca)
	FROM toys_and_models.view_sales as reqP
	where
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1) as 'Evol Mtt/N-1'
        
FROM toys_and_models.view_sales as reqA
--  toutes les tuple /enregistrement qui ne disposent pas de date d'envoi ne rentre pas dans le nombre de produits vendus 
where shippedDate is not null
--  regroupement des tuples par office , month, et year
group by reqA.country_office,year(reqA.shippedDate)
-- trie par office, month, et year
order by reqA.country_office asc, reqA.city_office asc, year(reqA.shippedDate);