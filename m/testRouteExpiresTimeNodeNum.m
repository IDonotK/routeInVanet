function testRouteExpiresTimeNodeNum()

    global nowlocation_x nowlocation_y;
    
    retm1 = [];
    retm2 = [];
    retm3 = [];
    reta1 = [];
    reta2 = [];
    reta3 = [];

    for set_N = 10:5:40
        
        initialNode(set_N);
        setNodeNebTable(200);
        
        nowlocation_x_temp = nowlocation_x;
        nowlocation_y_temp = nowlocation_y;
    
        %LSPR
        now_time = 0;
        nowlocation_x = nowlocation_x_temp;
        nowlocation_y = nowlocation_y_temp;
        [~,routeTrace1] = LSPR();
    
        %AODV
        now_time = 0;
        nowlocation_x = nowlocation_x_temp;
        nowlocation_y = nowlocation_y_temp;
        [~,routeTrace2] = AODV();
    
        %GPSR
        now_time = 0;
        nowlocation_x = nowlocation_x_temp;
        nowlocation_y = nowlocation_y_temp;
        routeTrace3 = GPSR();
        
        [temp_retm1,temp_reta1] = routeExpiresTime(routeTrace1);
        [temp_retm2,temp_reta2] = routeExpiresTime(routeTrace2);
        [temp_retm3,temp_reta3] = routeExpiresTime(routeTrace3);
        retm1 = [retm1 temp_retm1];
        retm2 = [retm2 temp_retm2];
        retm3 = [retm3 temp_retm3];
        reta1 = [reta1 temp_reta1];
        reta2 = [reta2 temp_reta2];
        reta3 = [reta3 temp_reta3];
    end

    retm1
    retm2
    retm3
    reta1
    reta2
    reta3
    
%     rm1 = medfilt1(retm1,10);
%     rm2 = medfilt1(retm2,10);
%     rm3 = medfilt1(retm3,10);
%     ra1 = medfilt1(reta1,10);
%     ra2 = medfilt1(reta2,10);
%     ra3 = medfilt1(reta3,10);
     %路由生命周期随通信半径的变化
    figure(1)
    n_i = 10:5:40;
    plot(n_i,retm1,'-o');
    hold on;
    plot(n_i,retm2,'-^');
    hold on;
    plot(n_i,retm3,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expired Time(s)')
    set(gca,'xtick',[10 15 20 25 30 35 40]);
    grid on;
    title('路由剩余生存时间 通信半径:150m');
   
%     figure(2)
%     R_i = 10:5:50;
%     p1 = polyfit(R_i,retm1(1:(length(retm1)-1)),6);
%     p2 = polyfit(R_i,retm2(1:(length(retm2)-1)),6);
%     p3 = polyfit(R_i,retm3(1:(length(retm3)-1)),6);
%     plot(R_i,polyval(p1,R_i),'-o');
%     hold on;
%     plot(R_i,polyval(p2,R_i),'-^');
%     hold on;
%     plot(R_i,polyval(p3,R_i),'-d');
%     legend('LSPR','AODV','GPSR');
%     xlabel('Traffic Density(veh/(lane*km))')
%     ylabel('Route Expires Time(s)')
%     grid on;
%     title('路由剩余生存时间 通信半径:200m');
    
    figure(3)
    n_i = 10:5:40;
    plot(n_i,reta1,'-o');
    hold on;
    plot(n_i,reta2,'-^');
    hold on;
    plot(n_i,reta2,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expired Time(s)')
    grid on;
    title('路由剩余生存时间 通信半径:150m');
    
%     figure(4)
%     R_i = 10:5:50;
%     p1 = polyfit(R_i,reta1(1:(length(reta1)-1)),6);
%     p2 = polyfit(R_i,reta2(1:(length(reta2)-1)),6);
%     p3 = polyfit(R_i,reta3(1:(length(reta3)-1)),6);
%     plot(R_i,polyval(p1,R_i)-5,'-o');
%     hold on;
%     plot(R_i,polyval(p2,R_i)-5,'-^');
%     hold on;
%     plot(R_i,polyval(p3,R_i)-5,'-d');
%     legend('LSPR','AODV','GPSR');
%     xlabel('Traffic Density(veh/(lane*km))')
%     ylabel('Route Expires Time(s)')
%     grid on;
%     title('路由剩余生存时间 通信半径:200m');
end