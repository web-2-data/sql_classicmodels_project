-- Nombre commande à livrer pour le mois (holdOn= en attente)
-- utilisation de vue logisqtie
-- creation de vue commande à livere en attente
create view view_holdON_orders as 
SELECT  status,orderNumber, orderDate , country_customers
FROM toys_and_models.view_loqistique
WHERE status LIKE 'On Hold'
group by country_customers
;