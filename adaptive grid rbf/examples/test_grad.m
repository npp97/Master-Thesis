VFsym = cMFSP.derivatives.sym.VF;
M     = cMFSP.state.sym.M;
dMdt  = cMFSP.state.sym.dMdt;
c     = cMFSP.parameters.sym.c;

n_c = 6;
n_z = 2;
n_C = 3;
n_y_index = 2;

% Definition of sensitivities
SM = sym(nan(length(M),n_c));
dSMdt = sym(nan(length(M),n_c));
for i = 1:n_c
    for j = 1:length(M)
        SM(j,i) = ['d' char(M(j)) '_dc' num2str(i,'%i')];
        dSMdt(j,i) = ['dd' char(M(j)) '_dcdt' num2str(i,'%i')];
    end
end

% Jacobian
dVFdM = jacobian(VFsym,M);
for i = 1:n_c
    dVFdc{i} = jacobian(VFsym,c(i));
end

% Derivation of residual function
resS = sym(nan(length(M),n_c));
VFS = sym(nan(length(M),n_c));
MMS = sym(ones(length(M),n_c));
for i = 1:n_c
    VFS(:,i) = dVFdM*SM(:,i) + dVFdc{i};
    for j = 1:n_y_index
        I = n_y_index + (j-1)*(n_z+n_C) + [1:(n_z+n_C)];
        VFS(I,i)  = -SM(j,i)*dMdt(I) + VFS(I,i);
        MMS(I,i)  = M(j);
    end
end
resS = MMS.*dSMdt - VFS;
    
%% CONVERSION TO EXECUTABLE FUNCTION
% Write function
str_VF_S  = '@(x,dx,sx,dsx,theta) [';
str_MM_S  = '@(x,dx,sx,dsx,theta) [';
str_RES_S = '@(x,dx,sx,dsx,theta) [';
for i = 1:length(M)
    for j = 1:n_c
        str_VF_S  = [str_VF_S  char(VFS(i,j) )];
        str_MM_S  = [str_MM_S  char(MMS(i,j) )];
        str_RES_S = [str_RES_S char(resS(i,j))];
        if j == n_c
            str_VF_S  = [str_VF_S  ';'];
            str_MM_S  = [str_MM_S  ';'];
            str_RES_S = [str_RES_S ','];
        else
            str_VF_S  = [str_VF_S  ','];
            str_MM_S  = [str_MM_S  ','];
            str_RES_S = [str_RES_S ','];
        end
    end
end
str_VF_S  = [str_VF_S  ']'];
str_MM_S  = [str_MM_S  ']'];
str_RES_S = [str_RES_S ']'];
% Exchange variables (backwards to avoid errors)
for i = length(M):-1:1
    for j = 1:n_c
        str_VF_S  = strrep(str_VF_S ,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_MM_S  = strrep(str_MM_S ,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_RES_S = strrep(str_RES_S,char(dSMdt(i,j)),['dsx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);    
        str_VF_S  = strrep(str_VF_S ,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
        str_MM_S  = strrep(str_MM_S ,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
        str_RES_S = strrep(str_RES_S,char(SM(i,j))   ,['sx(' num2str(i,'%d') ',' num2str(j,'%d') ')']);
    end
end
for i = length(M):-1:1
    str_VF_S  = strrep(str_VF_S ,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_MM_S  = strrep(str_MM_S ,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_RES_S = strrep(str_RES_S,char(dMdt(i)),['dx(' num2str(i,'%d') ')']);    
    str_VF_S  = strrep(str_VF_S ,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_MM_S  = strrep(str_MM_S ,char(M(i)),['x(' num2str(i,'%d') ')']);    
    str_RES_S = strrep(str_RES_S,char(M(i)),['x(' num2str(i,'%d') ')']);    
end
% Exchange parameters (backwards to avoid errors)
for i = n_c:-1:1
    str_VF_S  = strrep(str_VF_S ,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_MM_S  = strrep(str_MM_S ,char(c(i)),['theta(' num2str(i,'%d') ')']);  
    str_RES_S = strrep(str_RES_S,char(c(i)),['theta(' num2str(i,'%d') ')']);  
end
% Construct function
VF_S  = eval(str_VF_S);
MM_S  = eval(str_MM_S);
RES_S = eval(str_RES_S);

%% CONSTRUCT FUNCTION HANDLE
% Open file
fid = fopen([options.filename '_S.m'],'w');
% Construct string
str_FUN = ['function [res_S,flag,new_data] = ' options.filename '_S(t,x,dx,sx,dsx,theta) \n\n'...
           'theta = data.params;\n\n'...
           'res_S =' strrep(str_RES_S(21:end),';',';...\n         ') ';\n\n'...
           'flag = 0;\n'...
           'new_data = [];'];
% Write to file
fprintf(fid,str_FUN);
fclose(fid);


