delimiter ;;

set @demoTestMail = "zham@bul.kz";;
set @demoTestPass = "zham1995";;
set @demoSearchString = "es";

#4?
select * from developersteam_valdman.`order`;;
call FindOrders(@demoSearchString);;

#1
select CheckPasswordQuality(@demoTestPass) as IsGood;

#2
select * from developersteam_valdman.`account`;;
select Authtorize(@demoTestMail, @demoTestPass) as UserIdOrNotAuthed;;
set @demoAuthedUserId = (select Authtorize(@demoTestMail, @demoTestPass) as UserIdOrNotAuthed);;

#3
select GetCountOfUnreadEvents(@demoAuthedUserId) as UnreadedEvents;;

delimiter ;