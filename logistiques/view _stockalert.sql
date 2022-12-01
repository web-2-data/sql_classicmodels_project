/* Gestion : Alert le stock d'un item ou il y a moins de 50 
unités avec son manufacturier (automatique) par rapport à la derniere command*/
-- creation de sous requete  pour le StockAlert

-- create view stockalert
alter view stockalert as 
with StockAlert as (
select quantityInStock,productName,productLine,
--  Faire une Alert quand le stock est inferieur ou egal à 100
-- creation d'une colonne pour stockalert
CASE 
     when quantityInStock <= 100 THEN 'alert'
	else 'ok'
end as stockAlert
from view_loqistique
group by productName)

select quantityInStock,productLine,productName,stockAlert 
from StockAlert 
where StockAlert = 'alert'

;


