delimiter ;;

drop role if exists 'administrator';;
create role 'administrator';;
grant all on `developersteam_valdman` to 'administrator';;

drop role if exists 'developer';;
create role 'developer';;
grant select on `developersteam_valdman`.`account` to 'developer';;
grant select on	`developersteam_valdman`.`account_project` to 'developer';;
grant select on	`developersteam_valdman`.`project` to 'developer';;
grant select on `developersteam_valdman`.`project_projecttype` to 'developer';;
grant select on `developersteam_valdman`.`projecttype` to 'developer';;
grant select on `developersteam_valdman`.`projecttype` to 'developer';;

drop role if exists 'financial_manager';;
create role 'financial_manager';;
grant select on `developersteam_valdman`.`order` to 'financial_manager';;
grant select on	`developersteam_valdman`.`order_project` to 'financial_manager';;
grant select on	`developersteam_valdman`.`project` to 'financial_manager';;
grant select on `developersteam_valdman`.`payment` to 'financial_manager';;
grant select, insert, delete, update on `developersteam_valdman`.`bank` to 'financial_manager';;

drop role if exists 'client';;
create role 'client';;
grant insert on `developersteam_valdman`.`order` to 'client';;
grant insert on	`developersteam_valdman`.`client` to 'client';;
grant insert on	`developersteam_valdman`.`client_clientpool` to 'client';;

drop role if exists 'backup_manager';;
create role 'backup_manager';;
grant reload on *.* to 'backup_manager';
grant create, insert, drop, update on mysql.backup_progress to 'backup_manager';
grant create, insert, select, drop, update on mysql.backup_history to 'backup_manager';
grant replication client on *.* to 'backup_manager';
grant super on *.* to 'backup_manager';
grant process on *.* to 'backup_manager';