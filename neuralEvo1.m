function [error] = neuralEvo(x)

tic
[iris_data] = Iris_data;
iris_data = (iris_data(:,[1:4]))';


for n=1:4;
    iris_inputs(n,:)=(iris_data(n,:)-min(iris_data(n,:)))/...
        (max(iris_data(n,:)-min(iris_data(n,:))));
end
           
iris_target1 = [1 0 0]'; setosa=find(iris_target1);
iris_target2 = [0 1 0]'; versicolor=find(iris_target2);
iris_target3 = [0 0 1]'; verginica=find(iris_target3);

for n=1:(50-1)
   iris_target1=[iris_target1 iris_target1(:,1)];
   iris_target2=[iris_target2 iris_target2(:,1)];
   iris_target3=[iris_target3 iris_target3(:,1)];
end

iris_targets = [iris_target1 iris_target2 iris_target3];


p=[]; t=[]; test_p=[]; test_t=[];

for n=1:150
      test_p=[test_p iris_inputs(:,n)];
      test_t=[test_t iris_targets(:,n)];
end

% ----------------- Inputs no i [a1 a2 a3 a4]' ---------------------
   p=[iris_inputs(:,1)];
%---------------------------------------------------

[m n]=size(test_p);


echo on

fprintf(1,' Iris-setosa is represented by output:      %.0f \n',setosa);
fprintf(1,' Iris-versicolor is represented by output:  %.0f \n',versicolor);
fprintf(1,' Iris-verginica is represented by output:   %.0f \n',verginica);


n_setosa=0; n_versicolor=0; n_verginica=0;
error_setosa=0; error_versicolor=0; error_verginica=0; error=0;

% ----------------- Real Output no i [1 or 2 or 3]---------------------
b=compet(test_t(:,140)); b=find(b);
%-----------------------------------------------------------------

%Genetic evolution part%

for i=1:150
input = [iris_inputs(:, i)]';
%input = 0.2222    0.6250    0.0678    0.0417
weight1 = [x(1) x(2) x(3) x(4)]';
prod1 = input * weight1 ;
if prod1>x(35+1)
    y1 = 1;
else
    y1 = 0;
end

weight2 = [x(5) x(6) x(7) x(8)]';
prod2 = input * weight2 ;
if prod2>x(35+2)
    y2 = 1;
else
    y2 = 0;
end

weight3 = [x(9) x(10) x(11) x(12)]';
prod3 = input * weight3 ;
if prod3>x(35+3)
    y3 = 1;
else
    y3 = 0;
end

weight4 = [x(13) x(14) x(15) x(16)]';
prod4 = input * weight4 ;
if prod4>x(35+4)
    y4 = 1;
else
    y4 = 0;
end

weight5 = [x(17) x(18) x(19) x(20)]';
prod5 = input * weight5 ;
if prod5>x(35+5)
    y5 = 1;
else
    y5 = 0;
end

y = [y1 y2 y3 y4 y5];

lweight1 = [x(21) x(22) x(23) x(24) x(25)]';
lprod1 = y * lweight1;
if lprod1>x(35+6)
    out1 = 1;
else
    out1 = 0;
end

lweight2 = [x(26) x(27) x(28) x(29) x(30)]';
lprod2 = y * lweight2;
if lprod2>x(35+7)
    out2 = 1;
else
    out2 = 0;
end

lweight3 = [x(31) x(32) x(33) x(34) x(35)]';
lprod3 = y * lweight3;
if lprod3>x(35+8)
    out3 = 1;
else
    out3 = 0;
end

out = [out1 out2 out3];

a=find(out); %program output

b=compet(test_t(:,i)); b=find(b);


if b==1
      n_setosa=n_setosa+1;
      %fprintf('      Iris-setosa            ');
      if abs(a-b)>0
         error_setosa=error_setosa+1;
         %fprintf('%.0f        Yes\n',a);
      else
         %fprintf('%.0f        No\n',a);
      end
    elseif b==2
      n_versicolor=n_versicolor+1;
      %fprintf('      Iris-versicolor        ');
      if abs(a-b)>0
         error_versicolor=error_versicolor+1;
         %fprintf('%.0f        Yes\n',a);
      else
         %fprintf('%.0f        No\n',a);
      end
    else
      n_verginica=n_verginica+1;
      %fprintf('      Iris-verginica         ');
      if abs(a-b)>0
         error_verginica=error_verginica+1;
         %fprintf('%.0f        Yes\n',a);
      else
         %fprintf('%.0f        No\n',a);
      end      
   end
end


error=((error_setosa+error_versicolor+error_verginica)/n)*100;

error_setosa=error_setosa/n_setosa*100;
error_versicolor=error_versicolor/n_versicolor*100;
error_verginica=error_verginica/n_verginica*100;

fprintf(1,' \n')
fprintf(1,' Iris-setosa recognition error:      %.2f \n',error_setosa);
fprintf(1,' Iris-versicolor recognition error:  %.2f \n',error_versicolor);
fprintf(1,' Iris-verginica recognition error:   %.2f \n',error_verginica);
fprintf(1,' \n')
fprintf(1,' Total Iris plant recognition error: %.2f \n',error);
fprintf(1,' \n')

%t= cputime;
t = toc;
disp(t);
disp(x);




