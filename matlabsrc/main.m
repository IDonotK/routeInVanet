clc;
clear all;
close all;

%性能参考自变量：时间 车流密度 通信半径 

%测试路由变化度和链路中断率 随时间的变化 局部放大分析路由移动图
testLlaAndLlr();

%基于LET的路由剩余生存时间
%testRouteExpiresTimeR();
%testRouteExpiresTimeNodeNum();