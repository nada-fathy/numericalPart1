function varargout = GUI(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end
 
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
 
% End initialization code - DO NOT EDIT
 
 
% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
 
% Choose default command line output for GUI
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
      
      
function setting ()
cla reset
grid();
      
% --- Executes on button press in fixed.
function fixed_Callback(hObject, eventdata, handles)
%cla reset
global equ;
global fixed;
fixed=1;
[value,max,es]=GetInputs('FixedPoint');
if(strcmp(equ, '')==0)
    if(size(value)>0)
        [result,time,iter,root,ea,diverge]=FixedPoint(value(1),max,es,equ);
        if(diverge==0)
            if(ea<es)
            myString = sprintf('time=%fSec\nno.of iterations=%d\nappr.Error=%f\nprecision=%f%\n',time,iter,root,ea);
            plotting (value(1),root+5,equ)
            else
            myString=sprintf('time=%fSec\nthe precision=%f%\nthe root isnot found with this maximum no. of iterations',time,ea)
            plotting (value(1)-5,value(1)+5,equ)
            end
        else
            myString=sprintf('Diverge!! as the error increases');
            plotting (value(1)-5,value(1)+5,equ)
        end
        set(handles.results, 'String', myString);
        table_as_cell = num2cell(result);
        colnames = {'i','Xr','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);     
    end
end
 
% --- Executes on button press in newton.
function newton_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('NewtonRaphson');
if(size(value)>0)
    [result,time,iter,root,ea,diverge]=NewtonRaphson(equ,max,es,value(1));
        table_as_cell = num2cell(result);
        colnames = {'i','Xi','Xi-1','F(Xi)','F`(Xi)','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
        if(diverge==0)
           if(ea<es)
                myString = sprintf('time=%fSec\nno.of iterations=%d\nappr.Error=%f\nprecision=%f\n',time,iter,root,ea);
           else
                myString=sprintf('time=%fSec\nthe precision=%f\nthe root isnot found with this maximum no. of iterations',time,ea);
           end
        else
            myString=sprintf('Diverge!! as the error increases');
        end
        set(handles.results, 'String', myString);
        syms x;
        DFunc(x)=diff(equ(x));
        plotting (-5,5,DFunc)
end
 
% --- Executes on button press in bisection.
function bisection_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('Bisection');
if(size(value)>0)
    [result,time,iter,root,ea]=bisection(equ,value(1),value(2),es,max);
    table_as_cell = num2cell(result);
    colnames = {'i','Xl','XU','Xr','Ea'};
    set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    if(ea<es)
        myString = sprintf('time=%fSec\nno.of iterations=%d\nappr.Error=%f\nprecision=%f\n',time,iter,root,ea);
    else
        myString=sprintf('time=%fSec\nthe precision=%f\nthe root isnot found with this maximum no. of iterations',time,ea);
    end
    set(handles.results, 'String', myString);
    plotting (value(1),value(2),equ)
end
 
% --- Executes on button press in falsepos.
function falsepos_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('FalsePosition');
if(size(value)>0)
   [result,time,iter,root,ea]= falsePosition(equ,value(1),value(2),max,es);
  table_as_cell = num2cell(result);
        colnames = {'i','Xl','XU','Xr','F(Xr)','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
    if(ea<es)
     myString = sprintf('time=%fSec\nno.of iterations=%d\nappr.Error=%f\nprecision=%f\n',time,iter,root,ea);
    else
         myString = sprintf('time=%fSec\nthe precision=%f\nthe root isnot found with this maximum no. of iterations',time,ea);
    end
     set(handles.results, 'String', myString);
   plotting (value(1),value(2),equ)
end
 
 
% --- Executes on button press in secant.
function secant_Callback(hObject, eventdata, handles)
global equ;
setting();
[value,max,es]=GetInputs('Secant');
if(size(value)>0)
   [result,time,iter,root,ea,diverge] = secant(equ,max,es,value(1),value(2));
  table_as_cell = num2cell(result);
        colnames = {'i','XP','Xc','F(Xp)','F(Xc)','Xr','Ea'};
        set(handles.Table, 'Data', table_as_cell,'ColumnName',colnames);
        if(diverge==0)
            if(ea<es)
                myString = sprintf('time=%fSec\nno.of iterations=%d\nappr.Error=%f\nprecision=%f\n',time,iter,root,ea);
            else
                myString=sprintf('time=%fSec\nthe precision=%f\nthe root isnot found with this maximum no. of iterations',time,ea);
            end
        else
            myString=sprintf('Diverge!! as the error increases');
        end
        set(handles.results, 'String', myString);
         syms x;
        DFunc(x)=diff(equ(x));
        plotting (-5,5,DFunc)
end

 
% --- Executes on button press in p7.
function p7_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'7');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p4.
function p4_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'4');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p1.
function p1_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'1');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p8.
function p8_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'8');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p5.
function p5_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'5');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p2.
function p2_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'2');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p9.
function p9_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'9');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p6.
function p6_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'6');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p3.
function p3_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'3');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in pow.
function pow_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'^');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'(');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in mul.
function mul_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'*');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in sub.
function sub_Callback(hObject, eventdata, handles)
% hObject    handle to sub (see GCBO)
ca = get (handles.t1,'string');
ca = strcat(ca,'-');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in pPlus.
function pPlus_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'+');
set(handles.t1,'string',ca);
 

% --- Executes on button press in div.
function div_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'/');
set(handles.t1,'string',ca);

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,')');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in del.
function del_Callback(hObject, eventdata, handles)
set(handles.t1,'string','');
 
 global eq;
 eq = 0;
 
 
% --- Executes on button press in exp.
function exp_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'exp');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in sin.
function sin_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'sin');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in cos.
function cos_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'cos');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in var.
function var_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'x');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in p0.
function p0_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'0');
set(handles.t1,'string',ca);
 
 
% --- Executes on button press in dot.
function dot_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = strcat(ca,'.');
set(handles.t1,'string',ca);
  
% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
ca = get (handles.t1,'string');
ca = ca(1:end-1);
set(handles.t1,'string',ca);

 function solve_Callback(hObject, eventdata, handles)
global equ;
str = get (handles.t1,'string');
c =length(str)
    if(length(str)==0)
        msgbox('Please enter a valid function');
       return;
    end
    equ=str2func(['@(x)',str]);
   
    try
      equ(0);
    catch
        msgbox('Please enter a valid function');
       return;
    end
    set(handles.fixed,'Enable','on');
    set(handles.newton,'Enable','on');
    set(handles.bisection,'Enable','on');
    set(handles.falsepos,'Enable','on');
    set(handles.secant,'Enable','on');
 
function plotting (x1,x2,fun)
      global fixed;
      fplot(fun,[x1,x2]);
      hold on
      x = linspace(x1,x2,50);
      if (fixed==1)
           y=x;
          fixed=0;
      else
          y=0;
      end
      plot(x,y);
      grid();

    % --- Executes when entered data in editable cell(s) in Table.
function Table_CellEditCallback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function results_CreateFcn(hObject, eventdata, handles)
    
function fixed_CreateFcn(hObject, eventdata, handles)
    set(hObject,'Enable','off');
function newton_CreateFcn(hObject, eventdata, handles)
    set(hObject,'Enable','off');
function falsepos_CreateFcn(hObject, eventdata, handles)
    set(hObject,'Enable','off');
function bisection_CreateFcn(hObject, eventdata, handles)
    set(hObject,'Enable','off');
function secant_CreateFcn(hObject, eventdata, handles)
    set(hObject,'Enable','off');

 
