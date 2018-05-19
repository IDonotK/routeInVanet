clc;
clear all;
close all;
retm1 = [8.1000   14.2000    9.9000    2.5000    0.6000    0.1000    0.1000    6.2000    1.2000    8.4000];

retm2 = [0.2000    0.3000    2.2000    0.1000    9.9000    0.1000   16.2000    8.4000    1.2000    0.1000];

retm3 = [0.3000    0.1000    0.1000    0.1000    0.4000    0.1000    0.8000   46.4000    1.2000    0.1000];

figure(3)
    R_i = 10:5:50;
    rm1 = retm1(1:length(retm1)-1);
    rm2 = retm2(1:length(retm2)-1);
    rm3 = retm3(1:length(retm3)-1);
    values1 = spcrv([[R_i(1) R_i R_i(end)];[rm1(1) rm1 rm1(end)]],3);
    values2 = spcrv([[R_i(1) R_i R_i(end)];[rm2(1) rm2 rm2(end)]],3);
    values3 = spcrv([[R_i(1) R_i R_i(end)];[rm3(1) rm3 rm3(end)]],3);
    plot(values1(1,:),values1(2,:),'-o');
    hold on;
    plot(values2(1,:),values2(2,:),'-^');
    hold on;
    plot(values3(1,:),values3(2,:),'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expires Time(s)')
    grid on;
    title('路由剩余生存时间 通信半径:200m');
    
    figure(4)
    R_i = 10:5:50;
    p1 = polyfit(R_i,retm1(1:(length(retm1)-1)),6);
    p2 = polyfit(R_i,retm2(1:(length(retm2)-1)),6);
    p3 = polyfit(R_i,retm3(1:(length(retm3)-1)),6);
    plot(R_i,polyval(p1,R_i),'-o');
    hold on;
    plot(R_i,polyval(p2,R_i),'-^');
    hold on;
    plot(R_i,polyval(p3,R_i),'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expires Time(s)')
    grid on;
    title('路由剩余生存时间 通信半径:200m');
    
    rm1 = medfilt1(retm1,5);
    rm2 = medfilt1(retm2,5);
    rm3 = medfilt1(retm3,5);
     %路由生命周期随通信半径的变化
    figure(1)
    R_i = 10:5:50;
    plot(R_i,rm1(1:(length(rm1)-1)),'-o');
    hold on;
    plot(R_i,rm2(1:(length(rm2)-1)),'-^');
    hold on;
    plot(R_i,rm3(1:(length(rm3)-1)),'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expires Time(s)')
    grid on;
    title('路由剩余生存时间 通信半径:200m');
    
    figure(2)
    R_i = 10:5:50;
    plot(R_i,retm1(1:(length(retm1)-1)),'-o');
    hold on;
    plot(R_i,retm2(1:(length(retm2)-1)),'-^');
    hold on;
    plot(R_i,retm3(1:(length(retm3)-1)),'-d');
    legend('LSPR','AODV','GPSR');
    xlabel('Traffic Density(veh/(lane*km))')
    ylabel('Route Expires Time(s)')
    grid on;
    title('路由剩余生存时间 通信半径:200m');