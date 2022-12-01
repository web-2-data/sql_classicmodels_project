/* -- KPI : Chiffre d'Affaire par employe avec comparaison avec année précédente

-------------------------------------------------
------------------------------------------------*/

/* -- Utilisation de la vue view_RH
on considère que l'employé a réalisé une vente lorsque 
la commande est expédiée
*/
create view view_pbi_camanager_annee as 
-- selection et calcul des à utilser dans les tableaux
Select 
	reqA.employeeNumber,
	reqA.lastName,
	reqA.firstName,
    reqA.city,
    reqA.country,
    year(reqA.shippedDate) as 'Année',
	sum(reqA.CA_employe) as'CA N',
   ( Select 
		sum(reqP.CA_employe)
    from view_rh as reqP
    where 
		reqA.lastName= reqP.lastName
    and 
		reqA.firstName=reqP.firstName
	and
        reqA.employeeNumber=reqP.employeeNumber
	and
		reqA.city=reqP.city
	and 
    reqA.country=reqP.country
	and 
		year(reqA.shippedDate)=year(reqP.shippedDate)-1) as 'CA N-1',
	
    sum(reqA.CA_employe)-( Select 
							sum(reqP.CA_employe)
							from view_rh as reqP
								where 
									reqA.lastName= reqP.lastName
							and 
								reqA.firstName=reqP.firstName
							and
								reqA.employeeNumber=reqP.employeeNumber
							and
								reqA.city=reqP.city
							and 
								reqA.country=reqP.country
							and 
								year(reqA.shippedDate)=year(reqP.shippedDate)-1) as 'Evol Mtt/N-1',
  
   (sum(reqA.CA_employe)/( Select 
							sum(reqP.CA_employe)
							from view_rh as reqP
								where 
									reqA.lastName= reqP.lastName
							and 
								reqA.firstName=reqP.firstName
							and
								reqA.employeeNumber=reqP.employeeNumber
							and
								reqA.city=reqP.city
							and 
								reqA.country=reqP.country
							and 
								year(reqA.shippedDate)=year(reqP.shippedDate)-1))-1 as 'Evol %/N-1'
from view_rh as reqA
where shippedDate is not null
group by lastName,firstName,officeCode,year(shippedDate)
order by sum(reqA.CA_employe) desc

