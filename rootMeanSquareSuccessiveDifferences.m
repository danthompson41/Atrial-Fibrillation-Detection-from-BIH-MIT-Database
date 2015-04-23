%Statistical AF Detection Algorithm
%Term Project
%Root Mean Square of Successive Differences Function
%EECE 5664
%Noah Goldstein, Dan Song, Dan Thompson
 
function [rmssd] = rootMeanSquareSuccessiveDifferences (signal)
	%Find length of signal
	signal_minus_outliers = signal;
    	%Identify maximum outliers
	for n = 1:8
    	[max_value, max_index] = max (signal_minus_outliers);
    	signal_minus_outliers (max_index) = 0;
	end
	
	%Identify minimum outliers
	for n = 1:8
    	[min_value, min_index] = min (signal_minus_outliers);
    	signal_minus_outliers (min_index) = 0;
	end
	
	%Remove outliers
	signal_minus_outliers (find (signal_minus_outliers == 0)) = [];
	
	signal_length = length (signal_minus_outliers)
 
	%Initialize rmssd
	rmssd = 0;
	
	%Calculate RMSSD
	for j = 1:(signal_length - 1)
    	rmssd = rmssd + (signal_minus_outliers (j + 1) - signal_minus_outliers (j))^2;
	end
	
	rmssd = rmssd / (signal_length - 1);
	
	rmssd = sqrt (rmssd);
