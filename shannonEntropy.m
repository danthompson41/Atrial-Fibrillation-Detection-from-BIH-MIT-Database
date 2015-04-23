%Statistical AF Detection Algorithm
%Term Project
%Shannon Entropy Function
%EECE 5664
%Noah Goldstein, Dan Song, Dan Thompson
 
function [se] = shannonEntropy (signal)
	%Set constant calculation parameters
	bin_size = 16;
	window_size = 128;
 
	%Create vector for signal without outliers
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
	
	%Calculate histogram bins
	h = hist (signal_minus_outliers, bin_size);
	
	%Create empty vector for bin probabilities
	probabilities = zeros (bin_size, 1);
	
	%Calculate probability of each bin
	for n = 1:bin_size
    	probabilities (n) = h (n) / (window_size - bin_size);
	end
	
	%Initialize shannon entropy
	se = 0;
	
	%Calculate shannon entropy
	for n = 1:bin_size
   	if probabilities (n) ~= 0
        	se = se + probabilities (n) * (log (probabilities (n)) / log (1 / 16));
   	end
	end
