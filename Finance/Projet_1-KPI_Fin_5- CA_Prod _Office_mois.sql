/* -- Script de création de la vue Chiffre d'affaires par mois par office pour Power BI
 chiffre d'affaires par office et par mois avec comparaison 
sur le même mois de l'année précédente 
(taux de varitation sur le mois de l'année précédente) 
(Afficher CA  par OFFICE)
-------------------------------------------------
------------------------------------------------*/

-- Création de la vue
CREATE or replace VIEW view_pbi_caOffice_mois as 
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
year(reqA.shippedDate)*100+month(reqA.shippedDate) as 'AnneeMois',
month(reqA.shippedDate) as 'Mois',
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
    reqA.country_office=reqP.country_office
    and
    reqA.city_office=reqp.city_office
    and
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1
	and 
     -- indication de la ligne du mois à rechercher pour cette somme
		month(reqP.shippedDate)=month(reqA.shippedDate)))-1 as 'Evol %/N-1',
        
	-- calcule de la variation en montant 
    sum(reqA.ca)-(SELECT sum(ca)
	FROM toys_and_models.view_sales as reqP
	where
    reqA.country_office=reqP.country_office
    and
    reqA.city_office=reqp.city_office
    and
    -- indication de la ligne de l'année à rechercher pour cette somme
		year(reqP.shippedDate) = year(reqA.shippedDate) -1
	and 
     -- indication de la ligne du mois à rechercher pour cette somme
		month(reqP.shippedDate)=month(reqA.shippedDate))  as 'Evol Mtt/N-1'
    
FROM toys_and_models.view_sales as reqA
--  toutes les tuple /enregistrement qui ne disposent pas de date d'envoi ne rentre pas dans le nombre de produits vendus 
where shippedDate is not null
--  regroupement des tuples par office , month, et year
group by reqA.country_office, month(reqA.shippedDate),year(reqA.shippedDate)
-- trie par office, month, et year
order by reqA.country_office asc, reqA.city_office asc, month(reqA.shippedDate) asc, year(reqA.shippedDate);