function testRouteExpiresTimeR()

    global nowlocation_x nowlocation_y;
    
    retm1 = [];
    retm2 = [];
    retm3 = [];
    reta1 = [];
    reta2 = [];
    reta3 = [];
    
    %通信半径变化 100~250,车流密度30辆/km
    initialNode(30);
    nowlocation_x_temp = nowlocation_x;
    nowlocation_y_temp = nowlocation_y;
    for set_R = 100:25:250
        setNodeNebTable(set_R);
        
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
    rm1 = smooth(retm1,15);
    rm2 = smooth(retm2,15);
    rm3 = smooth(retm3,15);
    ra1 = smooth(reta1,15);
    ra2 = smooth(reta2,15);
    ra3 = smooth(reta3,15);
     %路由生命周期随通信半径的变化
    figure(1)
    R_i = 100:25:250;
    plot(R_i,retm1,'-o');
    hold on;
    plot(R_i,retm2,'-^');
    hold on;
    plot(R_i,retm3,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('R(m)')
    ylabel('Route Expires Time(s)')
    set(gca,'xtick',[100 125 150 175 200 225 250]);
    grid on;
    title('路由剩余生存时间 车流密度:30veh/(lane*km)');
    retm1
    retm2
    retm3
    figure(2)
    R_i = 100:25:250;
    plot(R_i,reta1,'-o');
    hold on;
    plot(R_i,reta2,'-^');
    hold on;
    plot(R_i,reta3,'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('R(m)')
    ylabel('Route Expires Time(s)')
    grid on;
    title('路由剩余生存时间 车流密度:30veh/(lane*km)');
    reta1
    reta2
    reta3
end