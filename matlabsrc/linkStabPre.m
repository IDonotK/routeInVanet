function [link_stability] = linkStabPre(link_fnode_id,link_bnode_id)
    
    global mobi_model_speed mobi_model_direct;
    global num_neb;
    global fis;
    
    %定义模糊推理输入量：速度相对度
    vmax = 16.7;
    detav = abs(mobi_model_speed(link_fnode_id) - mobi_model_speed(link_bnode_id))/vmax;
    
    %定义模糊推理输入量：方向相对度
    detadp = abs(mobi_model_direct(link_fnode_id) - mobi_model_direct(link_bnode_id));
    if (detadp > pi)
        detad = (2*pi - detadp)/pi;
    else
        detad = detadp/pi;
    end
    
    %定义模糊推理输入量：链路区域密度
    nmax = 1.1*max(num_neb);  %取节点邻居数的最大值 可能aven会偏大或者是集中于某个值附近？定义调节因子？
    aven = (num_neb(link_fnode_id) + num_neb(link_bnode_id))/(2*nmax);
    
    %计算模糊推理输出量：链路稳定度
    %link_stability = evalfis([detav detad],fis);
    link_stability = evalfis([detav detad aven],fis);
end