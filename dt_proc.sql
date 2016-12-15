delimiter ;;

drop procedure if exists FindOrders;;
create procedure FindOrders(strToFind varchar(255)) 
begin
	select OrderId from `developersteam_valdman`.`order` where Description like(concat("%", strToFind, "%"));
end;;

drop procedure if exists GetUnreadEvents;;
create procedure GetUnreadEvents(userId int(5)) 
begin
	select 
		eventinfo.EventId, eventinfo.EventTypeId, eventinfo.OccuredOn, eventinfo.Text
    from
		delivery join eventinfo on(delivery.EventInfoId = eventinfo.EventId)
	where
		delivery.WasRead = 0 and delivery.AccountId = userId;
end;;

drop procedure if exists Broadcast;;
create procedure Broadcast(text varchar(4000))
begin
	set SQL_SAFE_UPDATES = 0;
	insert into eventinfo 
    set eventinfo.EventId = null,
		eventinfo.OccuredOn = now(), 
		eventinfo.Text = concat('Admin said: ', text), 
        eventinfo.EventTypeId = 7;
    set @newEventId = LAST_INSERT_ID();
    insert into delivery (select AccountId, EventId, 0 as WasRead from account join eventinfo
	where account.IsHidden = 1 and eventinfo.EventId = @newEventId);
    set SQL_SAFE_UPDATES = 1;
end;;

drop procedure if exists MarkAllDeliviriesAsRead;;
create procedure MarkAllDeliviriesAsRead(userId int(5))
begin
	set SQL_SAFE_UPDATES = 0;
    update delivery set WasRead = 1 where AccountId = userId;
    set SQL_SAFE_UPDATES = 1;
end;;

drop procedure if exists DebtSumByContract;;
create procedure DebtSumByContract(contractIdToFind int(5))
begin
	set @sumOfPaymentsByContractsToFind = (select sum(Ammount) from payment where payment.ContractId=contractIdToFind);
    set @contractSumToFind = (select contract.ContractSum from contract where contract.ContractId=contractIdToFind);
    set @debtToRes =  @contractSumToFind - @sumOfPaymentsByContractsToFind;
    if (@debtToRes > 0) then
		select @debtToRes;
	else
		select 0;
	end if;
end;;

delimiter ;