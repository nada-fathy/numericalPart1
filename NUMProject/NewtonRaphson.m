function [result,time,iter,xr,ea,diverge] = NewtonRaphson(Fun, NumIteration , DefaultEpsilon, Xguess)
         tic;
         diverge=0;
         prevError=100;
         no_of_Errors=0;
         syms x;
         p(1)=Xguess;
         Func(x)=str2sym('Func(x)');
         DFunc(x)=str2sym('DFunc(x)');
         Func(x)=Fun;
         DFunc(x)=diff(Func(x));
         f(1)=(Func(p(1)));
         %DFun=diff(Fun);
         dfdx(1)=(DFunc(p(1)));
         MaxIteration=NumIteration;
         for i=2 : MaxIteration
           p(i)=p(i-1)-(f(i-1)/dfdx(i-1));
           f(i)=(Func(p(i)));
           dfdx(i)=(DFunc(p(i)));
           ea=(abs(p(i)-p(i-1))/p(i))*100;
           if(ea< DefaultEpsilon)
             break;
           end
           if(ea>prevError)
               no_of_Errors= no_of_Errors+1;
           end
           if( no_of_Errors==5)
               diverge=1;
               break;
           end
           prevError=ea;
           iter=i;
         end
         for i=2 : length(p)
            result(i-1,1)=i-1;
            result(i-1,2)=p(i);
            result(i-1,3)=p(i-1);
            result(i-1,4)=f(i);
            result(i-1,5)=dfdx(i);
            result(i-1,6)=(abs(p(i)-p(i-1))/p(i))*100;  
            xr=p(i);
         end 
         time=toc;
    end