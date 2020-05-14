function [value,max,es,g] = GetInputs(method)
    value=[];g='';max='';es='';
    if(strcmp(method, 'FixedPoint'))
        prompt = {'Enter the maximum no. of iterations ','Enter es:','Enter the initial value:'};
        dlgtitle = 'The FixedPoint Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]);
        if(size(Janel)>0)
             if(strcmp(Janel(3), ''))
                 msgbox('g(x)& initial value should be supplied');
                 return ;
             else
                 value(1) =str2double(char(Janel(3)));
             end
        else
            return;
        end
    elseif(strcmp(method,'NewtonRaphson'))
         prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the initial value:'};
        dlgtitle = 'The NewtonRaphson Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]); 
        if(size(Janel)>0)
            if(strcmp(Janel(3), ''))
                 msgbox('initial value should be supplied');
                 return ;
             else
                 value(1) =str2double(char(Janel(3)));
            end
        else
            return;
        end
    elseif(strcmp(method,'Bisection')||strcmp(method,'FalsePosition'))
         prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the lower bound:','Enter the upper bound:'};
        dlgtitle = 'The Bracket Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]);
        if(size(Janel)>0)
            if(strcmp(Janel(3), '')||strcmp(Janel(4), ''))
                 msgbox('Lower and Upper bounds should be supplied');
                 return ;
             else
                 value(1) = str2double(char(Janel(3)));
                  value(2)=str2double(char(Janel(4)));
            end 
        else
            return;
        end;
    else
        prompt = {'Enter the maximum no. of iterations ','Enter the Epsilon "es" :','Enter the XP:','Enter the XC:'};
        dlgtitle = 'The Secant Method';
        Janel=inputdlg(prompt,dlgtitle,[1 40]);
        if(size(Janel)>0)
            if(strcmp(Janel(3), '')||strcmp(Janel(4), ''))
                 msgbox('XP and XC bounds should be supplied');
                return ;
             else
                 value(1) =str2double(char(Janel(3)));
                  value(2)=str2double(char(Janel(4)));
            end  
        else
            return;
        end;
    end
     max=str2double(char(Janel(1)));
        es=str2double(char(Janel(2))); 
        if(strcmp(Janel(1), ''))
            max=50;
        end
        if(strcmp(Janel(2), ''))
            es=0.0001;
        end
        fprintf('%f %f \n',max,es);
end