delimiter ;;

drop function if exists `checkPasswordQuality`;;
create function `checkPasswordQuality` (passwd varchar(255))
	returns bool
begin
	set @passLength = CHAR_LENGTH(passwd);
	return ( @passLength > 8 ) ;
end;;

CREATE PROCEDURE `my_proc`(OUT t INTEGER(11))
    NOT DETERMINISTIC
    SQL SECURITY INVOKER
    COMMENT ''
BEGIN
select val1+val2 into 't' from `my` LIMIT 0,1;
END;

delimiter ;