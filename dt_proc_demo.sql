set @demoUserId = 5;
set @demoContractId = 2;
set @demoBroadcastRext = "Hello Word!";

#1
call DebtSumByContract(@demoContractId);
call Broadcast("Test broadcast");

#2
call GetUnreadEvents(@demoUserId);
call MarkAllDeliviriesAsRead(@demoUserId);
call GetUnreadEvents(@demoUserId);

