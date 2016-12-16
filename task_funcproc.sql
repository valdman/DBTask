delimiter ;;

drop function if exists `GetsumOfPaymentsBetween`;;
create function `GetsumOfPaymentsBetween` (contractIdToFind int(5), bgn date, en date)
	returns int
begin
	return (select sum(Ammount) from payment where payment.ContractId=contractIdToFind and payment.Date >= bgn and payment.Date <= en);
end;;

drop function if exists `GetsumOfPaymentsBetween`;;

drop procedure if exists TestProc;;
create procedure TestProc(bgn date, en date) 
begin
	set @monthBetween = TIMESTAMPDIFF(MONTH, bgn, en);
    
	select contract.ContractId, contract.ContractSum as Contact_Sum, GetsumOfPaymentsBetween(Contract.ContractId, bgn , en) as Sum_Of_payments, project.ProjectId, projectstatus.Description
    from contract, project, order_project, projectstatus
    where contract.OrderId = order_project.OrderId and order_project.ProjectId = project.ProjectId and project.ProjectStatusCode = projectstatus.ProjectStatusId;
    
end;;
drop procedure if exists TestProc;;

delimiter ;