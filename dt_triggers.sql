delimiter ;;

drop trigger if exists `onAccountCreated`;;
create trigger `onAccountCreated` before insert on `account`
for each row
set new.Password = md5(new.Password);;

drop trigger if exists `onAccountUpdated`;;
create trigger `onAccountUpdated` before update on `account`
for each row
set new.Password = md5(new.Password);;

drop trigger if exists `onTryingToDeleteAccount`;; #Этот триггер не сработает из-за ограничений MySql на функционал триггеров (не может править ту же таблицу)
create trigger `onTryingToDeleteAccount` before delete on `account`
for each row
begin
	update account set IsDeleted=1 where account.AccountId=old.AccountId; #Нельзя в MySql!
end;;

drop trigger if exists `onProjectAdded`;;
create trigger `onProjectAdded` after insert on `project`
for each row
begin
	insert into eventinfo values (null, now(), concat(new.Name, " project added!"), 6);
end;;

drop trigger if exists `onPaymentAdded`;;
create trigger `onPaymentAdded` after insert on `payment`
for each row
begin
	set @sumOfPaymentsByContracts = (select sum(Ammount) from payment where payment.ContractId=new.ContractId);
    set @contractSum = (select contract.ContractSum from contract where contract.ContractId=new.ContractId);
    if @sumOfPaymentsByContracts >= @contractSum then
		update contract set contract.FullyPaied=1 where contract.ContractId=new.ContractId;
	else 
		update contract set contract.FullyPaied=0 where contract.ContractId=new.ContractId;
	end if;
end;;

drop trigger if exists `onPartnershipDel`;; #не пашет
create trigger `onPartnershipDel` before delete on `partnershipcontract`
for each row
begin
	set @pcontractID = old.PartnershipContractId;
    set @pcontractSum = old.Ammount;
    set @relatedContractIds = (select distinct contract.ContractId
								from contract, partnershipcontract, contract_partnershipcontract
								where contract.ContractId = contract_partnershipcontract.ContractId and
								contract_partnershipcontract.Partnershipcontract=@pcontractID);
                                
	update 
		contract 
		inner join contract_partnershipcontract using(ContractId)
		join partnershipcontract on(contract_partnershipcontract.Partnershipcontract = partnershipcontract.PartnershipContractId)
    set 
		contract.ContractSum = (ContractSum - @pcontractSum)
	where
		PartnershipcontractId  = @pcontractID;
	#delete from contract_partnershipcontract where contract_partnershipcontract.Partnershipcontract=@pcontractID;
end;;

drop trigger if exists `onContractPartnershipIns`;;
create trigger `onContractPartnershipIns` after insert on `contract_partnershipcontract`
for each row
begin
	set @ammount = (select Ammount from partnershipcontract where PartnershipContractId=new.Partnershipcontract);
    update contract set ContractSum = ContractSum + @ammount where contract.ContractId=new.ContractId;
end;;

drop trigger if exists `onEventAdded`;;
create trigger `onEventAdded` after insert on `eventinfo`
for each row
begin
	set @newEventId = new.EventId;
    insert into test values (null, @newEventId);
    insert into delivery (select AccountId, EventId from account join eventinfo
	where account.IsDeleted = 0 and eventinfo.EventId = @newEventId);
end;;

drop trigger if exists `onAccountDeletedFromProject`;;
create trigger `onAccountDeletedFromProject` after delete on `account_project`
for each row
begin
	set @developersLeft = (select count(*) from account_project where account_project.ProjectId=old.ProjectId);
    if (@developersLeft=0) then
		update project set ProjectStatusCode = 4 where ProjectId=old.ProjectId;
	end if;
end;;

delimiter ;