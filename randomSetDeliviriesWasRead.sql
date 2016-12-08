set SQL_SAFE_UPDATES = 0;
update delivery set WasRead = (FLOOR( RAND( ) *2 ));
set SQL_SAFE_UPDATES = 1;
select * from delivery;