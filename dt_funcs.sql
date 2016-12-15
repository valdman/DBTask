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

drop function if exists `GetCountOfUnreadEvents`;;
create function `GetCountOfUnreadEvents` (userId int(5))
	returns int
begin
	return (select count(*) from delivery where AccountId = userId and WasRead = 0);
end;;

drop function if exists `FindOrders`;;
create function `FindOrders` (strToFind varchar(15))
	returns int
begin
	#select OrderId from `developersteam_valdman`.`order` where Description like(concat("%", strToFind, "%"));
    return 0;
end;;

drop function if exists `FindOrders`;;

delimiter ;