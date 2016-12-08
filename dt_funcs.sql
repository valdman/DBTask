delimiter ;;

drop function if exists `CheckPasswordQuality`;;
create function `CheckPasswordQuality` (passwd varchar(255))
	returns bool
begin
	set @passLength = CHAR_LENGTH(passwd);
	return ( @passLength > 8 ) ;
end;;

drop function if exists `Authtorize`;;
create function `Authtorize` (email varchar(255), passwd varchar(255))
	returns int
begin
	set @resCountAuth = (select count(*) from account where Email = email and Password = md5(passwd));
    if(@resCountAuth = 1) then
		return (select AccountId from account where Email = email and Password = md5(passwd));
	else
		return -1;
	end if;
end;;

drop function if exists `DebtSumByContract`;;
create function `DebtSumByContract` (contractIdToFind int(5))
	returns int
begin
	set @sumOfPaymentsByContractsToFind = (select sum(Ammount) from payment where payment.ContractId=contractIdToFind);
    set @contractSumToFind = (select contract.ContractSum from contract where contract.ContractId=contractIdToFind);
    set @debtToRes =  @contractSumToFind - @sumOfPaymentsByContractsToFind;
    if (@debtToRes > 0) then
		return @debtToRes;
	else
		return 0;
	end if;
    
end;;

drop function if exists `GetCountOfUnreadEvents`;;
create function `GetCountOfUnreadEvents` (userId int(5))
	returns int
begin
	return (select count(*) from delivery where AccountId = userId and WasRead = 0);
end;;

delimiter ;