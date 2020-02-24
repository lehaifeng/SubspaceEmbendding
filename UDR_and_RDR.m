
function affmatrix = allaff (varargin)
%to calculate the all affinity between subspaces and store them into a
%matrix.
%to calculate UDR,use signifant eigenplaces
n = size(varargin, 2); %to count the numbers of subspaces
affmatrix = size(n,n);
opt=2;
for i = 1:n
    for j = 1:n
        affmatrix(i,j) = affinity(varargin{i},varargin{j},opt);
    end 
end
affmatrix = affmatrix-diag(diag(affmatrix));%make the diagonal elements equal to 0
UDR = sqrt((n-1)./sum(affmatrix.*affmatrix,1))
end

function RDA = allcluster(varargin)
%to calculate RDA,use clusters as input
n = size(varargin, 2); %to count the numbers of clusters
%r is the number of significant eigen places
RDA = zeros(n,1)
for i = 1:n
    [coeff,score,latent,~,explained,mu]= pca(varargin{i});
    re=score(:,1:r)*coeff(:,1:r)';
    for i=1:size(re,1)
    re(i,:)=re(i,:)+mu;
    end
    diff=re-varargin{i};
    RDA(i)=norm(diff)/norm(varargin{i});
end
end

function aff = affinity(bases1,bases2,opt)
%this is for calculating the affinity between subspaces based on the
%principle angles computed by subspacea.m
if opt==1
pabs = subspacea(bases1,bases2);
aff = norm(cos(pabs),2);
else
    cos_pabs=bases1'*bases2;
    aff=norm(cos_pabs,2);
end
end

