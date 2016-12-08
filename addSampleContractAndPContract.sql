SET SQL_SAFE_UPDATES = 0;

insert into partnershipcontract values (3, "Oracle", "JVM", 1);
insert into contract_partnershipcontract values (1,3);
insert into contract_partnershipcontract values (3,3);

SET SQL_SAFE_UPDATES = 1;
