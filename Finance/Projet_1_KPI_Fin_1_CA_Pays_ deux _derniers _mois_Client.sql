/* -- KPI : Chiffre d'Affaire des deux derniers
mois par pays des clients
-------------------------------------------------
------------------------------------------------*/

/* -- Utilisation de la vue  view_sales
une commande se transforme en chiffre d'affaire dès lors qu'elle a été expédiées 
c'est à dire le status de la commande = 'Shipped'ou 'Resolved'
*/
-- Création de la vue 
CREATE view view_pbi_cadeuxmois_client as 

/* -- selection de tous les champs dont on aura besoins pour faire les calculs des KPI
 une seule vue est utiliée : view_sales
*/

(SELECT
	-- c'est le pays du client qui est utilisé  à valider avec 
	country_customer as 'Pays des clients',
    sum(ca) as "Chiffre d'affaires des deux derniers mois"
FROM view_sales
-- le filtre est réalisé sur les status 'Shipped' et 'Resolved' c'est à dire les commandes qui sont envoyées 
WHERE  status in ('Shipped','Resolved')
AND 

/*shippedDate est la date d'envoi des commandes , on part de mois de la date du jour  "month(now())" 
duquel on soustrait 3 mois;  ensuite on filtre la mois d'envoi entre month(now())-3 et "month(now())" 
et sur la l'année du mois en cours */
MONTH(shippedDate) BETWEEN MONTH(now())-3 AND MONTH(NOW()) AND YEAR(shippedDate) = YEAR(now())
-- Regrouper par chiffres d'affaires par pays où se trrouve les clients
GROUP BY country_customer);

    
