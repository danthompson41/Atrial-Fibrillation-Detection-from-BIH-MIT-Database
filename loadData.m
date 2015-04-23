%Statistical AF Detection Algorithm
%Term Project
%Load data set from Database
%EECE 5664
%Noah Goldstein, Dan Song, Dan Thompson
 
 
clear
clc
close all
datapath = 'afdb/04126';
[t, ekg]=rdsamp(datapath,1,500000);
wqrs(datapath);
[ann,type,subtype,chan,num,comments] = rdann(datapath,'wqrs');
[ann_atr,type_atr,subtype_atr,chan_atr,num_atr,comments_atr] = rdann(datapath,'atr');

 max_indices = [0];
 
	%ann is a vector of the index of the start of each QRS wave
	%Loop through ann
	for n = 1:length(ann)
    	%If ann contains an index beyond the number of samples pulled from the
    	%database, we finished
    	if (ann(n) > length(ekg)) || (ann(n+1) > length(ekg)) == 1
        	break;
    	end
 
    	%Find the max value in between each qrs wave beginning index. This
    	%number corresponds to the peak, aka the R
    	maximum_val = max(ekg(ann(n):ann(n+1)));
    	for k = ann(n):ann(n+1)
        	if ekg(k) == maximum_val
            	%Collecting the indices of the peaks
         	   max_indices = [max_indices k];
            	continue;
        	end
    	end
	end
	
    	r_peaks = zeros (length (max_indices), 1);
 
	%Get the amplitude of the original signal at each max value index
	for m = 2:length (max_indices)
    	r_peaks (m) = ekg (max_indices (m));
	end
	
RRintervals = zeros(1,length(max_indices)-1);
for i=1:length(max_indices)-1
	RRintervals(i) = max_indices(i+1) - max_indices(i);
end
modulus = mod(length(RRintervals),128);
b = RRintervals(1:length(RRintervals)-modulus);
reshaped = reshape(b,128,[]);
