function [result,time,iter,xc,e,diverge] = secant(f, n, epsilon, xp, xc)
    tic;
    prevError=100;
    no_of_Errors=0;
    diverge=0;
    fp = f(xp);
    fc = f(xc);
    e = 100;
    for i = 1:n
        iter=i;
        xn = xc - fc * (xp - xc) / (fp - fc);
        e = abs ((xn - xc) / xn) * 100 ;
        result(i,1)=i;
        result(i,2)=xp;
        result(i,3)=xc;
        result(i,4)=fp;
        result(i,5)=fc;
        result(i,6)=xn;
        result(i,7)=e;
        fn = f(xn);
        xp = xc;
        fp = fc;
        xc = xn;
        fc = fn;
        if(e <= epsilon)
            break;
        end
         if(e>prevError)
               no_of_Errors= no_of_Errors+1;
           end
           if( no_of_Errors==5)
               diverge=1;
               break;
           end
           prevError=e;
    end
   time= toc;
end