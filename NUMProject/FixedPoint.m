function [result,time,iter,xr,ea,diverge] = FixedPoint(x0,iter_max,es,g)
%FIXEDPOINT Summary of this function goes here
%   Detailed explanation goes here
    xr=x0; 
    iter=1;
    ea =0;
    tic;
    prevError=100;
    no_of_Errors=0;
    diverge=0;
    while (iter<=iter_max)
        xr_old =xr;
        xr = double(g(xr_old)); % g(x) has to be supplied
        if (xr ~= 0)
            ea = abs((xr-xr_old) / xr) * 100;
        if(ea>prevError)
            no_of_Errors=no_of_Errors+1;
        end
        if(no_of_Errors==5)
            diverge=1;
            time=toc;
            return;
        end
        result(iter,1)=iter;
        result(iter,2)=double(xr);
        result(iter,3)=double(ea);
        if(ea<es)
            time=toc;
            return;
        end
        prevError=ea;
        end
        iter=iter+1;
    end

time=toc;
end