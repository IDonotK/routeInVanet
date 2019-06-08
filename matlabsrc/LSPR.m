function [route_stab,route_trace] = LSPR()
    global source_id des_id;
    
    link_matrix = lsprInitialLink();
    [route_stab,route_trace] = Dijkstra(link_matrix,source_id,des_id);
end