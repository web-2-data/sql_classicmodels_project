/* -- KPI : Chiffre d'Affaire des deux derniers mois 
par pays où sont installés les bureaux qui sont utilisés
-------------------------------------------------
------------------------------------------------*/

/* -- Utilisation de la vue  view_sales
une commande se transforme en chiffre d'affaire dès lors qu'elle a été expédiées 
c'est à dire le status de la commande = 'Shipped'ou 'Resolved'
*/
-- Création de la vue 
CREATE view view_pbi_cadeuxmois_office as 
(SELECT
	-- c'est les pays où sont installés les bureaux qui sont utilisés
	country_office as 'Pays des bureaux',
    sum(ca) as "Chiffre d'affaires des deux derniers mois",
    MONTH(shippedDate)
FROM view_sales
-- le filtre est réalisé sur les status 'Shipped' et 'Resolved' c'est à dire les commandes qui sont envoyées 
WHERE  status in ('Shipped','Resolved')
AND 

/*shippedDate est la date d'envoi des commandes , on part de mois de la date du jour  "month(now())" 
duquel on soustrait 2 mois;  ensuite on filtre la mois d'envoi entre month(now())-2 et "month(now())" 
et sur la l'année du mois en cours */
MONTH(shippedDate) BETWEEN MONTH(now())-2 AND MONTH(NOW()) AND YEAR(shippedDate) = YEAR(now())
-- Regrouper par chiffres d'affaires par les pays où se situent les bureaux

GROUP BY country_office,MONTH(shippedDate));

    
