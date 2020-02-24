warning off ;
disp_opt = 0 ;

cvx_solver sdpt3
cvx_quiet(true) ;


N = size(X,2); % X:D*N ，N is the total number of observations
 
 Z =zeros ( N , N ) ;
 for kk = 1 : N
            
    if rem( kk , 10 ) == 0 
                
        disp([num2str(kk), ' of ', num2str( N )] ) ;
    end
    cvx_begin
            
    variable z( N , 1 ) ;
    minimize norm(z,1)
    subject to
    X(:,kk) == X*z ;
    z(kk)==0 ;
            
    cvx_end
            
    Z(:,kk) = z ;
            
 end
 
 MAXiter = 1000; % Maximum iteration for KMeans Algorithm
 REPlic = 100;   % Replication for KMeans Algorithm
 %group for SSC
 W = abs( Z ) + abs( Z.' ) ;
 N = size(W,1);
 DKS = ( diag( sum(W)+eps ) )^(-1/2);
 Lap  = speye(N) - DKS * W * DKS;
        
[uKS,sKS,vKS] = svd(Lap );
svals = diag(sKS);
[ min_val , ind_min ] = min( diff( svals(1:end-1) ) ) ;  
n = size(W, 1 ) - ind_min ;
        
f = size(vKS,2);
kerKS = vKS(:,f-n+1:f);
 for i = 1:N
     kerKS(i,:) = kerKS(i,:) ./ norm(kerKS(i,:));
 end
group = kmeans(kerKS,n,'start','sample','maxiter',MAXiter,'replicates',REPlic,'EmptyAction','singleton');

