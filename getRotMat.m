function R = getRotMat(n,theta)

    if (size(n,1)<size(n,2)) n = n'; end  % make n a column vector
    if (norm(n) ~= 1) n = n/norm(n); end  % make n a unit vector
        
    R = zeros(size(n,1),size(n,1));
    
    for i=1:size(n,1)
        for j=1:size(n,1)
            for k=1:size(n,1)
                R(i,j) = n(i)*n(j) + cos(theta)*(kroneckerDelta(i,j)-n(i)*n(j)) - sin(theta)*alternatingEpsilon(i,j,k)*n(k);
                if i==j || alternatingEpsilon(i,j,k)~=0 break; end
            end
        end
    end
    
end