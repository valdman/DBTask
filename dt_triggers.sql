delimiter ;;

drop trigger if exists `onAccountCreated`;;
create trigger `onAccountCreated` before insert on `account`
for each row
set new.Password = md5(new.Password);;

drop trigger if exists `onAccountUpdated`;;
create trigger `onAccountUpdated` before update on `account`
for each row
begin
	if(new.Password != old.Password) then
		set new.Password = md5(new.Password);
	end if;
end;;

drop trigger if exists `onTryingToDeleteAccount`;; #Этот триггер не сработает из-за ограничений MySql на функционал триггеров (не может править ту же таблицу)
create trigger `onTryingToDeleteAccount` after delete on `account`
for each row
begin
	#update account set IsDeleted=1 where account.AccountId=old.AccountId; #Нельзя в MySql!
    insert into account_old values (null, old.FirstName, old.LastName, old.Email, old.Password, 1);
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
	
    SET SQL_SAFE_UPDATES = 0;
	update contract join contract_partnershipcontract on(contract.ContractId=contract_partnershipcontract.ContractId)
	set contract.ContractSum = contract.ContractSum - @pcontractSum
    where contract_partnershipcontract.Partnershipcontract = @pcontractID;
    
	delete from contract_partnershipcontract where contract_partnershipcontract.Partnershipcontract=@pcontractID;
    SET SQL_SAFE_UPDATES = 1;
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

drop trigger if exists `onProjectStatusUpdated`;;
create trigger `onProjectStatusUpdated` after update on `project`
for each row
begin
	if (old.ProjectStatusCode !=3 and new.ProjectStatusCode = 3) then
    begin
		insert into test values (null, concat(old.ProjectId, " prjId is old"));
		SET SQL_SAFE_UPDATES = 0;
		delete from account_project where account_project.ProjectId = old.ProjectId;
		SET SQL_SAFE_UPDATES = 1;
	end;
    end if;
end;;

drop trigger if exists `onOrderCreated`;;
create trigger `onOrderCreated` after insert on `order`
for each row
begin
	insert into project values (null, "", new.Description, 1);
end;;

delimiter ;