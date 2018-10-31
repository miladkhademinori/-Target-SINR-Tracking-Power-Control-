% Milad Khademi Nori 95123012
% Exercise 1
% Target-SINR Tracking Power Control

% In this homework, you should apply constrained TPC algorithm to a simple CDMA network. The network
% conditions are chosen such that the system is feasible:
% Number of users Nu = 5
% Cell coverage area = 50m * 50m
% Background noise power DELTA2= e-10W
% Maximum power of each user Pi = 1mW
% Target SINR GAMAi = 0.05
% Path gain hi = 0.09d^(-3)
% Simulate the system under the above conditions. The users should be uniformly distributed in the cell.

%% 1. Plot SINR and power of each user versus the number of iterations (a measure of time).
Nu = 10;
Length = 50;
Width = 50;
DeltaPower2 = 5e-9 * ones( Nu , 1);
PowerMax = 1e-3;
TargetSINRGama = 0.05 * ones( Nu , 1);
PositionOfBS = [ 0 , 0 ];
X = 1:Length/Nu:Length;
Y = 1:Length/Nu:Length;
XYVector = [X;Y]';
DistanceFromBS = pdist2(XYVector,PositionOfBS,'euclidean');
PathGainh = 0.09*DistanceFromBS.^(-3);
MaxOfIteration = 1000;
PowerVector = zeros( Nu , 1);
GamaVector = zeros( Nu , 1);
PowerVectorHistory = [];
GamaVectorHistory = [];
PrePowerVector = zeros( Nu , 1);
PostPowerVector = zeros( Nu , 1);

for k = 1:MaxOfIteration
    PowerVectorHistory = [PowerVectorHistory;PowerVector'];
    GamaVectorHistory = [GamaVectorHistory;GamaVector'];
    PrePowerVector = PostPowerVector;
    for i = 1:Nu
        PowerVector( i , 1 ) =  TargetSINRGama( i , 1 ) * ( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) )/(PathGainh( i , 1 ));
        if  PowerVector( i , 1 ) > 1e-3
            PowerVector( i , 1 ) = 1e-3;
        end
        GamaVector( i , 1 ) = ( PowerVector( i , 1 ) * PathGainh( i , 1 ))/( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) );
    end
    PostPowerVector = PowerVector;
    if abs(PostPowerVector - PrePowerVector) <= 0.00001  
        break;
    end

end

figure
subplot(2,1,1);
plot(GamaVectorHistory);
title('GamaVectorHistory');
subplot(2,1,2);
plot(PowerVectorHistory);
title('PowerVectorHistory');
%% 2. Now increase the number of users one-by-one to 10 users.
      % – Compare the achieved SINR and Target-SINR for each user.
      % – For how many users system becomes infeasible? Why?
      % – Plot the number of admitted users versus the total number of users.
      % – Can we increase the number of admitted users by changing the other parameters? How? Explain.
GamaVectorForDifferentNumOfUser = [];
Nu = 10;
for j = 1:Nu
Length = 50;
Width = 50;
DeltaPower2 = 7e-9 * ones( Nu , 1);
PowerMax = 1e-3;
TargetSINRGama = 0.05 * ones( Nu , 1);
PositionOfBS = [ 0 , 0 ];
X = 1:Length/Nu:Length;
Y = 1:Length/Nu:Length;
XYVector = [X;Y]';
DistanceFromBS = pdist2(XYVector,PositionOfBS,'euclidean');
PathGainh = 0.09*DistanceFromBS.^(-3);
MaxOfIteration = 1000;
PowerVector = zeros( Nu , 1);
GamaVector = zeros( Nu , 1);
PrePowerVector = zeros( Nu , 1);
PostPowerVector = zeros( Nu , 1);
for k = 1:MaxOfIteration
    PrePowerVector = PostPowerVector;
    for i = 1:j
        PowerVector( i , 1 ) =  TargetSINRGama( i , 1 ) * ( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) )/(PathGainh( i , 1 ));
        if  PowerVector( i , 1 ) > 1e-3
            PowerVector( i , 1 ) = 1e-3;
        end
        GamaVector( i , 1 ) = ( PowerVector( i , 1 ) * PathGainh( i , 1 ))/( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) );
    end
    PostPowerVector = PowerVector;
    if abs(PostPowerVector - PrePowerVector) <= 0.00001
        
        break;
    end

end
GamaVectorForDifferentNumOfUser = [GamaVectorForDifferentNumOfUser;GamaVector'];
end
Result = GamaVectorForDifferentNumOfUser >= 0.049;
plot(sum(Result'));
%% 3. Now increase the users’ Target-SINR from 0.01 to 1 by step size 0.01.
   % – Plot the number of admitted users versus the total number of users.
   % – For what Target-SINR system becomes infeasible? Why?
   % – Can we increase the number of admitted users by changing the other parameters? How?
GamaVectorForDifferentNumOfUser = [];
Nu = 5;
for j = 0.01:0.01:1
Length = 50;
Width = 50;
DeltaPower2 = 7e-9 * ones( Nu , 1);
PowerMax = 1e-3;
TargetSINRGama = j * ones( Nu , 1);
PositionOfBS = [ 0 , 0 ];
X = 1:Length/Nu:Length;
Y = 1:Length/Nu:Length;
XYVector = [X;Y]';
DistanceFromBS = pdist2(XYVector,PositionOfBS,'euclidean');
PathGainh = 0.09*DistanceFromBS.^(-3);
MaxOfIteration = 1000;
PowerVector = zeros( Nu , 1);
GamaVector = zeros( Nu , 1);
PrePowerVector = zeros( Nu , 1);
PostPowerVector = zeros( Nu , 1);
for k = 1:MaxOfIteration
    PrePowerVector = PostPowerVector;
    for i = 1:Nu
        PowerVector( i , 1 ) =  TargetSINRGama( i , 1 ) * ( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) )/(PathGainh( i , 1 ));
        if  PowerVector( i , 1 ) > 1e-3
            PowerVector( i , 1 ) = 1e-3;
        end
        GamaVector( i , 1 ) = ( PowerVector( i , 1 ) * PathGainh( i , 1 ))/( PowerVector' * PathGainh ...
        - PowerVector( i , 1 ) * PathGainh( i , 1 ) + DeltaPower2( i , 1 ) );
    end
    PostPowerVector = PowerVector;
    if PostPowerVector == PrePowerVector
        
        break;
    end

end
GamaVectorForDifferentNumOfUser = [GamaVectorForDifferentNumOfUser;GamaVector'];
end
n = 1;
Result = [];
for m = 0.01:0.01:1
Temporary = GamaVectorForDifferentNumOfUser( n , 1:Nu ) >= (m-.001);
Result = [Result;Temporary];
n = n+1;
end
plot(0.01:0.01:1,sum(Result'));