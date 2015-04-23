%Statistical AF Detection Algorithm
%Term Project
%Implementation of algorithm on preloaded Data Set
%EECE 5664
%Noah Goldstein, Dan Song, Dan Thompson
 
close all
numberOfWindows = (size(reshaped))
 
tpr_expected = zeros(1,numberOfWindows(2));
tpr_actual = zeros(1,numberOfWindows(2));
tpr_sigma_expected = zeros(1,numberOfWindows(2));
tpr_sigma_real = zeros(1,numberOfWindows(2));
se = zeros(1,numberOfWindows(2));
rmssd = zeros(1,numberOfWindows(2));
 
 
 
thr_tpr(1:numberOfWindows(2)) = 54;
thr_se(1:numberOfWindows(2)) = .7;
thr_rmssd(1:numberOfWindows(2)) = .1*mean(RRintervals);
detected = zeros(1,28);
 
for i = 1:numberOfWindows(2)
window = reshaped(:,i);
[tpr_expected(i),tpr_actual(i),tpr_sigma_expected(i),tpr_sigma_real(i)] = turningPointRatio(window);
se(i) = shannonEntropy(window);
rmssd(i) = rootMeanSquareSuccessiveDifferences(window);
if (tpr_actual(i) > thr_tpr(i)) & (se(i)> thr_se(i)) & (rmssd(i) > thr_rmssd)
	detected(i) = 1;
end
end
 
 
 
%Plots
x=1:numberOfWindows(2);
figure
subplot(5,1,2),plot(detected),title('Detected AFIB');
subplot(5,1,1),plot(ekg),title('EKG');
subplot(5,1,3),plot(x,tpr_actual,x,thr_tpr),title('Turning Point Ratio');
subplot(5,1,4),plot(x,se,x,thr_se),title('Shannon Entropy');
subplot(5,1,5),plot(x,rmssd,x,thr_rmssd),title('Root mean squared of Successive Differences');


