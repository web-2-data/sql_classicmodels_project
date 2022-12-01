/* 
- on utilise la vue :view_rh
- faire un histogramme histogram comparing two sets of data 
- on montre que le temps moyen entre la date de commande et la date d'envoie
le japon a progressé par rapport à l'année derniere


*/


 CREATE VIEW kpi_vue_logistic_tps_moyen_shippment AS
SELECT * FROM

(SELECT country, round(avg(DATEDIFF(shippedDate, orderDate) + 1)) AS date_difference_avg2022

FROM view_rh WHERE YEAR(shippedDate) = YEAR(CURDATE())
group by country
order by date_difference_avg2022 desc) as avg22
JOIN (
SELECT country, round(avg(DATEDIFF(shippedDate, orderDate) + 1)) AS date_difference_avg2021
FROM view_rh WHERE YEAR(shippedDate) = YEAR(CURDATE())-1
group by country
order by date_difference_avg2021 desc) AS avg21
using (country)
;
