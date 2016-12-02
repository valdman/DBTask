select 
	client.firstname, client.secondname, sum(payment.ammount)
from 
	client, clientpools, payment, contract, client_clientpool
where 
	client.id=client_clientpool.ClientId and
    clientpools.PoolName = contract.ClientPool and
    payment = clientpools.PoolName
group by
	payment.clientpool, contract.ContractSum
having
	sum(payment.ammount) < contract.ContractSum
	
