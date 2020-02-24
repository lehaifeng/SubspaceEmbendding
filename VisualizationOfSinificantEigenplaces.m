
function fig=visual_sep(varargin)
%the varargin should be sep1,sep2,...,sep g,cmap
%their forms are N(the number of obeservations)*r(the number of significant eigenplaces)

g=size(varargin,2)-1;%the number of groups
cmap=varargin{g+1};
n=size(varargin{1},2);%count the number of significant eigenplaces
t={'H','Tr','W','D','E','O'};%according to your types of demands - taxi
d=size(t,2);%count the number of types

figure;
for k=1:g 
for j=1:n
for i=1:d
    eig=varargin{k}((24*i-23):24*i,j)';
    subplot(n*d,g,g*((6*(j-1)+i)-1)+k);
    imagesc(eig);
    
    
    set(gca,'ytick',1,'yticklabel',t{i});
    h=get(gca,'ylabel');
    set(h,'fontsize',15,'Fontname','Times New Roman');
    colormap(cmap);
    set(gca, 'CLim', [-0.4745 0.8044]);
    set(gca,'XTickLabel',[])
    if j==n&&i==d
    set(gca,'xtick',5:5:20,'xticklabel',{'5','10','15','20'});
    h2=get(gca,'xlabel');
    set(h2,'fontsize',20,'Fontname','Times New Roman');
    end
end

end


end
fig=gca;

end
