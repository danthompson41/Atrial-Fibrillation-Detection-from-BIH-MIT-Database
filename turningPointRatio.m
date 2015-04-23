%Statistical AF Detection Algorithm
%Term Project
%Turning Point Ratio Function
%EECE 5664
%Noah Goldstein, Dan Song, Dan Thompson
 
function [u_tp_expected, u_tp_actual, sigma_tp_expected, sigma_tp_real] = turningPointRatio (qrs_signal)
	%Initialize vector for turning points
	qrs_length = 128
	tp = zeros (1,qrs_length);
	
	%Find turning points
	for j = 2:(qrs_length - 1)
    	if ((qrs_signal (j - 1) < qrs_signal (j)) &&  (qrs_signal (j + 1) < qrs_signal (j)))
        	tp (j) = 1;
    	else if ((qrs_signal (j - 1) > qrs_signal (j)) &&  (qrs_signal (j + 1) > qrs_signal (j)))
        	tp (j) = 1;
        	end
    	end
	end
	
	%Determine segment length
	l = length (tp);
	
	%Determine mean of turning point ratio
	u_tp_expected = (2 * l - 4) / 3;
	u_tp_actual = sum(tp);
	
	%Determine standard deviation of turning point ratio
	sigma_tp_expected = sqrt ((16 * l - 29) / 90);
	sigma_tp_real = std(tp);


