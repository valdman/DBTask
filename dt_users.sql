delimiter ;;

drop user if exists 'admin1', 'client1', 'client2', 'manager1', 'developer1', 'developer2', 'sysmanager1';;
create user 'admin1', 'client1', 'client2', 'manager1', 'developer1', 'developer2', 'sysmanager1';;

grant 'administrator' to 'admin1';;
grant 'client' to 'client1', 'client2';;
grant 'financial_manager' to 'manager1';;
grant 'developer' to 'developer1', 'developer2';;
grant 'backup_manager' to 'sysmanager1';;

set default role all to 'admin1'@'%',
						'client1'@'%',
                        'client2'@'%',
                        'manager1'@'%',
                        'developer1'@'%',
                        'developer2'@'%',
                        'sysmanager1'@'%';;
                        
#set default role 'administrator' to 'admin1';;

delimiter ;