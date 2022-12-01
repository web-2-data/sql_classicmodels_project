
-- creation de vue commandes annulé
-- 
create view cancelled_order as 
select status, customerName,country_customers from view_loqistique
where status= 'Cancelled' and month(shippedDate) is not null
group by customerName;


