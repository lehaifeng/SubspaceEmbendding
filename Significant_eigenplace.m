
function eigval_std = findsep(X,group_);
%To find the significant eigenplaces
%The form of inputs must be  (X,group)
%the columns of X are observations.
n = max(group_); %to count the numbers of subspac

%to decide the number of significant
ep=cell(1,n);
clust=cell(1,n);
for i=1:n
    clust{i}=X(find(group_==i),:);
[ep{i},~,eigval(:,i)]=pca(clust{i})
end


eigval_std = eigval./repmat(sqrt(sum(eigval.^2,1)),size(eigval,1),1);



for j=1:size(eigval_std,2)
for i=1:size(eigval_std,1)
    if sum(eigval_std(1:i,j))/sum(eigval_std(:,j))>0.90
        break
    end
    r_all(j)=i;
end
r=max(r_all); %but if the difference among r is too large, we could judge it by ourselves.

sep_all=cell(1,n);
for i=1:n
    sep_all{i} = ep{n}(:,1:r);
end

end
