function [let] = linkExpiresTime(node_i,node_j)
    global R;
    global mobi_model_x mobi_model_y mobi_model_speed mobi_model_direct;
    a = mobi_model_speed(node_i)*cos(mobi_model_direct(node_i)) - mobi_model_speed(node_j)*cos(mobi_model_direct(node_j));
    b = mobi_model_x(node_i) - mobi_model_x(node_j);
    c = mobi_model_speed(node_i)*sin(mobi_model_direct(node_i)) - mobi_model_speed(node_j)*sin(mobi_model_direct(node_j));
    d = mobi_model_y(node_i) - mobi_model_y(node_j);
    let = abs((-1*(a*b + c*d) + sqrt((a^2 + c^2)*R^2 - (a*d - b*c)^2))/(a^2 + c^2));    %abs£¿
end