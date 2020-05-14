function [result,time,iter,xr,ea] = bisection(f,xl, xu, es, imax)
tic;
  %thError=log10((xu-xl)*(1/es))/log10(2);
  %thError = ceil(thError);
  if (f(xl))*(f(xu))>0 % if guesses do not bracket, exit
      disp('no bracket')
      return
  end
  xro=0;
  for i=1:1:imax
        iter=i;
      result(i,1) = i;
      result(i,2) = xl;
      result(i,3) = xu;
     
      xr=(xu+xl)/2; % compute the midpoint xr
      result(i,4) = xr;
     
      ea = abs((xr-xro)/xr); % approx. relative error
      result(i,5) = ea;
      % f(xr)
      test= (f(xl)) * (f(xr)); % compute f(xl)*f(xr)
      if (test < 0) 
          xu=xr;
      else
          xl=xr;
      end
      if (test == 0) 
          ea=0;
      end
      if (ea < es) 
          break;
      end
      xro=xr;
  end
time=toc;
end