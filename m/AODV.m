function [route_stab,route_trace] = AODV()
    global source_id des_id;
    
    link_matrix = aodvInitialLink();
    [route_stab,route_trace] = Dijkstra(link_matrix,source_id,des_id);
end