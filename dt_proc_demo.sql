set @demoUserId = 5;
set @demoContractId = 2;
set @demoBroadcastRext = "This is broadcast";

#1
call DebtSumByContract(@demoContractId);
call Broadcast(@demoBroadcastRext);

#2
call GetUnreadEvents(@demoUserId);
call MarkAllDeliviriesAsRead(@demoUserId);
call GetUnreadEvents(@demoUserId);

