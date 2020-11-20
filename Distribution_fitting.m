clear all
clc

%% Generating a randomn normal data set with mean 0 and STD 1

rng(5)
X = normrnd(0,1,20,1);
X_red = X(1:15,1);

data_mean = mean(X)
data_std = std(X)

figure(1)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2)
hold on

%% Method of Maximum Likelihood Estimation
%=========================================%

% Case 1: Considering the entire data set
%------------------------------------------%

% Case a: Assuming the data set to be Extremevalue distributed
MLE_Fit_1 = fitdist(X,'ExtremeValue')
[KStest_MLE_Fit_1,pval_MLE_Fit_1,ksstat_MLE_Fit_1,cv_MLE_Fit_1] = kstest(X,'CDF',MLE_Fit_1,'Alpha',0.01)
% [Ztest_MLE_Fit_1,pval_MLE_Fit_1,ci_MLE_Fit_1,zval_MLE_Fit_1] = ztest(X,...
%     MLE_Fit_1.mu, MLE_Fit_1.sigma, 'Tail', 'both', 'Alpha', 0.01)
x_values = -5:0.2:5;
y1 = pdf(MLE_Fit_1,x_values);
plot(x_values,y1,'LineWidth',2)
txt = ['p =' num2str(pval_MLE_Fit_1) '\rightarrow'];
text(-0.41,0.2481,txt,'HorizontalAlignment','right')
hold on

% Case b: Assuming the data set to be Gaussian distributed
MLE_Fit_2 = fitdist(X,'Normal')
[KStest_MLE_Fit_2,pval_MLE_Fit_2,ksstat_MLE_Fit_2,cv_MLE_Fit_2] = kstest(X,'CDF',MLE_Fit_2,'Alpha',0.01)
% [Ztest_MLE_Fit_2,pval_MLE_Fit_2,ci_MLE_Fit_2,zval_MLE_Fit_2] = ztest(X,...
%     MLE_Fit_2.mu, MLE_Fit_2.sigma, 'Tail', 'both', 'Alpha', 0.01)
y2 = pdf(MLE_Fit_2,x_values);
plot(x_values,y2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_MLE_Fit_2)];
text(-0.4,0.3511,txt)
hold on


% Case 2: Considering 15 points in the data set
%----------------------------------------------%

% Case a: Assuming the data set to be Extremevalue distributed
MLE_Fit_3 = fitdist(X_red,'ExtremeValue')
[KStest_MLE_Fit_3,pval_MLE_Fit_3,ksstat_MLE_Fit_3,cv_MLE_Fit_3] = kstest(X,'CDF',MLE_Fit_3,'Alpha',0.01)
% [Ztest_MLE_Fit_3,pval_MLE_Fit_3,ci_MLE_Fit_3,zval_MLE_Fit_3] = ztest(X,...
%     MLE_Fit_3.mu, MLE_Fit_3.sigma, 'Tail', 'both', 'Alpha', 0.01)
y3 = pdf(MLE_Fit_3,x_values);
plot(x_values,y3,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_MLE_Fit_3)];
text(-0.4,0.2283,txt)
hold on

% Case b: Assuming the data set to be Gaussian distributed
MLE_Fit_4 = fitdist(X_red,'Normal')
[KStest_MLE_Fit_4,pval_MLE_Fit_4,ksstat_MLE_Fit_4,cv_MLE_Fit_4] = kstest(X,'CDF',MLE_Fit_4,'Alpha',0.01)
% [Ztest_MLE_Fit_4,pval_MLE_Fit_4,ci_MLE_Fit_4,zval_MLE_Fit_4] = ztest(X,...
%     MLE_Fit_4.mu, MLE_Fit_4.sigma, 'Tail', 'both', 'Alpha', 0.01)
y4 = pdf(MLE_Fit_4,x_values);
txt = ['\leftarrow p =' num2str(pval_MLE_Fit_4)];
text(-0.6,0.2906,txt)
plot(x_values,y4,'LineWidth',2)


title ('Distribution Fitting Techniques: Method of Maximum Likelihood Estimation')
legend ('Sample data fit','Extremevalue Fit with all points','Normal Fit with all points',...
    'Extremevalue Fit with 15 points','Normal Fit with 15 points')

%% Method of Moments
%==============================%

% Case 1: Assuming the data set follows a Gaussian distribution
% (considering all points)
%---------------------------------------------------------------%

figure(2)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2)
hold on

mean_MOM_Fit_1 = 0;
for loop = 1:20
    mean_MOM_Fit_1 = mean_MOM_Fit_1 + X(loop)/20;
end

var_MOM_Fit_1 = 0;
for loop = 1:20
    var_MOM_Fit_1 = var_MOM_Fit_1 + ((X(loop)- mean_MOM_Fit_1)^2)/20;
end

std_MOM_Fit_1 = sqrt(var_MOM_Fit_1);


mu_MOM_Fit_1 = mean_MOM_Fit_1;
sigma_MOM_Fit_1 = std_MOM_Fit_1;
% [Ztest_MOM_Fit_1,pval_MOM_Fit_1,ci_MOM_Fit_1,zval_MOM_Fit_1] = ztest(X,...
%     mean_MOM_Fit_1,std_MOM_Fit_1, 'Tail', 'both', 'Alpha', 0.01)
cdf_MOM_Fit_1 = [X,normcdf(X, mean_MOM_Fit_1, std_MOM_Fit_1)];
[KStest_MOM_Fit_1,pval_MOM_Fit_1,ksstat_MOM_Fit_1,cv_MOM_Fit_1] = kstest(X,'CDF',cdf_MOM_Fit_1,'Alpha',0.01)
x_MOM_Fit_1 = mu_MOM_Fit_1-(4*sigma_MOM_Fit_1):0.01:mu_MOM_Fit_1+(4*sigma_MOM_Fit_1);
y_MOM_Fit_1 = normpdf(x_MOM_Fit_1,mu_MOM_Fit_1,sigma_MOM_Fit_1);
plot(x_MOM_Fit_1,y_MOM_Fit_1,'LineWidth',2)
hold on
txt = ['\leftarrow p =' num2str(pval_MOM_Fit_1)];
text(0.1824,0.3718,txt)


% Case 2: Assuming the data set follows a Gaussian distribution
% (considering 15 points)
%---------------------------------------------------------------%
mean_MOM_Fit_2 = 0;
for loop = 1:15
    mean_MOM_Fit_2 = mean_MOM_Fit_2 + X_red(loop)/15;
end

var_MOM_Fit_2 = 0;
for loop = 1:15
    var_MOM_Fit_2 = var_MOM_Fit_2 + ((X_red(loop)- mean_MOM_Fit_2)^2)/15;
end

std_MOM_Fit_2 = sqrt(var_MOM_Fit_2);

mu_MOM_Fit_2 = mean_MOM_Fit_2;
sigma_MOM_Fit_2 = std_MOM_Fit_2;
% [Ztest_MOM_Fit_2,pval_MOM_Fit_2,ci_MOM_Fit_2,zval_MOM_Fit_2] = ztest(X,...
%     mean_MOM_Fit_2,std_MOM_Fit_2, 'Tail', 'both', 'Alpha', 0.01)
cdf_MOM_Fit_2 = [X_red,normcdf(X_red, mean_MOM_Fit_2, std_MOM_Fit_2)];
[KStest_MOM_Fit_2,pval_MOM_Fit_2,ksstat_MOM_Fit_2,cv_MOM_Fit_2] = kstest(X,'CDF',cdf_MOM_Fit_2,'Alpha',0.01)
x_MOM_Fit_2 = mu_MOM_Fit_2-(4*sigma_MOM_Fit_2):0.01:mu_MOM_Fit_2+(4*sigma_MOM_Fit_2);
y_MOM_Fit_2 = normpdf(x_MOM_Fit_2,mu_MOM_Fit_2,sigma_MOM_Fit_2);
plot(x_MOM_Fit_2,y_MOM_Fit_2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_MOM_Fit_2)];
text(-0.6743,0.2879,txt)


title ('Distribution Fitting Techniques: Method of Moments')
legend ('Sample data fit','Normal Fit considering all points', 'Normal Fit considering 15 points')


%% Method of L - Moments
%==============================%

% Case 1: Assuming the data set follows a Gaussian distribution
% (considering all points)
%---------------------------------------------------------------%

figure(3)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2)
hold on

mean_LMO_Fit_1 = data_mean;
std_LMO_Fit_1 = data_std/sqrt(pi);
mu_LMO_Fit_1 = mean_LMO_Fit_1;
sigma_LMO_Fit_1 = std_LMO_Fit_1;
cdf_LMO_Fit_1 = [X,normcdf(X, mean_LMO_Fit_1, std_LMO_Fit_1)];
[KStest_LMO_Fit_1,pval_LMO_Fit_1,ksstat_LMO_Fit_1,cv_LMO_Fit_1] = kstest(X,'CDF',cdf_LMO_Fit_1,'Alpha',0.01)
% [Ztest_LMO_Fit_1,pval_LMO_Fit_1,ci_LMO_Fit_1,zval_LMO_Fit_1] = ztest(X,...
%     mean_LMO_Fit_1,std_LMO_Fit_1, 'Tail', 'both', 'Alpha', 0.01)
x_LMO_Fit_1 = mu_LMO_Fit_1-(4*sigma_LMO_Fit_1):0.01:mu_LMO_Fit_1+(4*sigma_LMO_Fit_1);
y_LMO_Fit_1 = normpdf(x_LMO_Fit_1,mu_LMO_Fit_1,sigma_LMO_Fit_1);
plot(x_LMO_Fit_1,y_LMO_Fit_1,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_LMO_Fit_1)];
text(0.1587,0.6218,txt)
hold on

% Case 2: Assuming the data set follows a Gaussian distribution
% (considering 15 points)
%---------------------------------------------------------------%
mean_LMO_Fit_2 = mean(X_red);
std_LMO_Fit_2 = std(X_red)/sqrt(pi);
mu_LMO_Fit_2 = mean_LMO_Fit_2;
sigma_LMO_Fit_2 = std_LMO_Fit_2;
cdf_LMO_Fit_2 = [X_red,normcdf(X_red, mean_LMO_Fit_2, std_LMO_Fit_2)];
[KStest_LMO_Fit_2,pval_LMO_Fit_2,ksstat_LMO_Fit_2,cv_LMO_Fit_2] = kstest(X,'CDF',cdf_LMO_Fit_2,'Alpha',0.01)
% [Ztest_LMO_Fit_2,pval_LMO_Fit_2,ci_LMO_Fit_2,zval_LMO_Fit_2] = ztest(X,...
%     mean_LMO_Fit_2,std_LMO_Fit_2, 'Tail', 'both', 'Alpha', 0.01)
x_LMO_Fit_2 = mu_LMO_Fit_2-(4*sigma_LMO_Fit_2):0.01:mu_LMO_Fit_2+(4*sigma_LMO_Fit_2);
y_LMO_Fit_2 = normpdf(x_LMO_Fit_2,mu_LMO_Fit_2,sigma_LMO_Fit_2);
plot(x_LMO_Fit_2,y_LMO_Fit_2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_LMO_Fit_2)];
text(-0.474,0.4569,txt)

title ('Distribution Fitting Techniques: Method of L - Moments')
legend ('Sample data fit','Normal Fit considering all points', 'Normal Fit considering 15 points')

%% Method of Maximum Spacing Estimation
%======================================%

% Case 1: Assuming the data set follows a Gaussian distribution
% (considering all points)
%---------------------------------------------------------------%

figure(4)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2)
hold on

% cdf_fun =  @(stat_var) (-1/16)*(erf((X(1) - stat_var(1))/(sqrt(2)*stat_var(2))) - erf((X(2) - stat_var(1))/(sqrt(2)*stat_var(2)))).*...
%     (erf((X(2) - stat_var(1))/(sqrt(2)*stat_var(2))) - erf((X(3) - stat_var(1))/(sqrt(2)*stat_var(2)))).*...
%     (erf((X(3) - stat_var(1))/(sqrt(2)*stat_var(2))) - erf((X(4) - stat_var(1))/(sqrt(2)*stat_var(2)))).*...
%     (erf((X(4) - stat_var(1))/(sqrt(2)*stat_var(2))) - erf((X(5) - stat_var(1))/(sqrt(2)*stat_var(2))));

X_sort = sort(X);
cdf_fun = @(stat_var) stat_var(1)*stat_var(2)/(stat_var(1)*stat_var(2));
for loop = 1:19
    cdf_fun = @(stat_var)cdf_fun(stat_var).*(-1/2)*(erf((X(loop) - stat_var(1))/(sqrt(2)*stat_var(2))) - erf((X(loop+1) - stat_var(1))/(sqrt(2)*stat_var(2))));
end
int = [5,5];
stat_var = fminsearch (cdf_fun, int)

mean_MSE_Fit_1 = - stat_var(1);
std_MSE_Fit_1 = - stat_var(2);
mu_MSE_Fit_1 = mean_MSE_Fit_1;
sigma_MSE_Fit_1 = std_MSE_Fit_1;
cdf_MSE_Fit_1 = [X,normcdf(X, mean_MSE_Fit_1, std_MSE_Fit_1)];
[KStest_MSE_Fit_1,pval_MSE_Fit_1,ksstat_MSE_Fit_1,cv_MSE_Fit_1] = kstest(X,'CDF',cdf_MSE_Fit_1,'Alpha',0.01)
x_MSE_Fit_1 = mu_MSE_Fit_1-(4*sigma_MSE_Fit_1):0.01:mu_MSE_Fit_1+(4*sigma_MSE_Fit_1);
y_MSE_Fit_1 = normpdf(x_MSE_Fit_1,mu_MSE_Fit_1,sigma_MSE_Fit_1);
plot(x_MSE_Fit_1,y_MSE_Fit_1,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_MSE_Fit_1)];
text(0.5136,0.5502,txt)


title ('Distribution Fitting Techniques: Method of Maximum Spacing Estimation')
legend ('Sample data fit','Normal Fit considering all points')

%% Histogram
%============%

% Case 1: Considering all the points
%-------------------------------------%

figure(5)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2) 
hold on

Hist_Fit_1 = histogram(X,'Normalization','pdf');
Hist_Fit_1(1).FaceColor = [.8 .8 1];
bin_count = histcounts(X);
sum = 0;
for loop = 1:Hist_Fit_1.NumBins
    sum = sum + (Hist_Fit_1.BinEdges(loop) + 0.1*bin_count(loop));
end
mean_Hist_Fit_1 = sum / length(X);

var_Hist_Fit_1 = 0;
for loop = 1:Hist_Fit_1.NumBins
    var_Hist_Fit_1 = var_Hist_Fit_1 + ...
        (1/length(X))*(bin_count(loop)*((Hist_Fit_1.BinEdges(loop) - mean_Hist_Fit_1)^2));
end
std_Hist_Fit_1 = sqrt(var_Hist_Fit_1);

mu_Hist_Fit_1 = mean_Hist_Fit_1;
sigma_Hist_Fit_1 = std_Hist_Fit_1;
cdf_Hist_Fit_1 = [X,normcdf(X, mean_Hist_Fit_1, std_Hist_Fit_1)];
[KStest_Hist_Fit_1,pval_Hist_Fit_1,ksstat_Hist_Fit_1,cv_Hist_Fit_1] = kstest(X,'CDF',cdf_Hist_Fit_1,'Alpha',0.01)
x_Hist_Fit_1 = mu_Hist_Fit_1-(4*sigma_Hist_Fit_1):0.01:mu_Hist_Fit_1+(4*sigma_Hist_Fit_1);
y_Hist_Fit_1 = normpdf(x_Hist_Fit_1,mu_Hist_Fit_1,sigma_Hist_Fit_1);
plot(x_Hist_Fit_1,y_Hist_Fit_1,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_Hist_Fit_1)];
text(1.198, 0.2169,txt)
hold on


% Case 2: Considering 15 points
%--------------------------------%

Hist_Fit_2 = histogram(X_red,'Normalization','pdf');
Hist_Fit_2(1).FaceColor = [.2 .2 .2];
bin_count = histcounts(X_red);
sum = 0;
for loop = 1:Hist_Fit_2.NumBins
    sum = sum + (Hist_Fit_2.BinEdges(loop) + 0.1*bin_count(loop));
end
mean_Hist_Fit_2 = sum / length(X_red);

var_Hist_Fit_2 = 0;
for loop = 1:Hist_Fit_2.NumBins
    var_Hist_Fit_2 = var_Hist_Fit_2 + ...
        (1/length(X_red))*(bin_count(loop)*((Hist_Fit_2.BinEdges(loop) - mean_Hist_Fit_2)^2));
end
std_Hist_Fit_2 = sqrt(var_Hist_Fit_2);

mu_Hist_Fit_2 = mean_Hist_Fit_2;
sigma_Hist_Fit_2 = std_Hist_Fit_2;
cdf_Hist_Fit_2 = [X_red,normcdf(X_red, mean_Hist_Fit_2, std_Hist_Fit_2)];
[KStest_Hist_Fit_2,pval_Hist_Fit_2,ksstat_Hist_Fit_2,cv_Hist_Fit_2] = kstest(X,'CDF',cdf_Hist_Fit_2,'Alpha',0.01)
x_Hist_Fit_2 = mu_Hist_Fit_2-(4*sigma_Hist_Fit_2):0.01:mu_Hist_Fit_2+(4*sigma_Hist_Fit_2);
y_Hist_Fit_2 = normpdf(x_Hist_Fit_2,mu_Hist_Fit_2,sigma_Hist_Fit_2);
plot(x_Hist_Fit_2,y_Hist_Fit_2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_Hist_Fit_2)];
text(2.364,0.09224,txt)

title ('Distribution Fitting Techniques: Histogram')
legend ('Sample data fit','Histogram of Fit containing all the points', 'Fit considering all points',...
    'Histogram of Fit containing 15 points', 'Fit considering 15 points')


% Case 3: Considering all the points and bins calculated using Doane's formula 
%-----------------------------------------------------------------------------%

figure(6)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2) 
hold on

nbins = 8;
Hist_Fit_3 = histogram(X,nbins,'Normalization','pdf');
Hist_Fit_3(1).FaceColor = [.8 .8 1];
bin_count = histcounts(X,8);
sum = 0;
for loop = 1:Hist_Fit_3.NumBins
    sum = sum + (Hist_Fit_3.BinEdges(loop) + 0.1*bin_count(loop));
end
mean_Hist_Fit_3 = sum / length(X);

var_Hist_Fit_3 = 0;
for loop = 1:Hist_Fit_3.NumBins
    var_Hist_Fit_3 = var_Hist_Fit_3 + ...
        (1/length(X))*(bin_count(loop)*((Hist_Fit_3.BinEdges(loop) - mean_Hist_Fit_1)^2));
end
std_Hist_Fit_3 = sqrt(var_Hist_Fit_3);

mu_Hist_Fit_3 = mean_Hist_Fit_3;
sigma_Hist_Fit_3 = std_Hist_Fit_3;
cdf_Hist_Fit_3 = [X,normcdf(X, mean_Hist_Fit_3, std_Hist_Fit_3)];
[KStest_Hist_Fit_3,pval_Hist_Fit_3,ksstat_Hist_Fit_3,cv_Hist_Fit_3] = kstest(X,'CDF',cdf_Hist_Fit_3,'Alpha',0.01)
x_Hist_Fit_3 = mu_Hist_Fit_3-(4*sigma_Hist_Fit_3):0.01:mu_Hist_Fit_3+(4*sigma_Hist_Fit_3);
y_Hist_Fit_3 = normpdf(x_Hist_Fit_3,mu_Hist_Fit_3,sigma_Hist_Fit_3);
plot(x_Hist_Fit_3,y_Hist_Fit_3,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_Hist_Fit_3)];
text(0.7759,0.3047,1,txt)
hold on


% Case 4: Considering 15 points and bins calculated using Doane's formula
%------------------------------------------------------------------------%

nbins = 7;
Hist_Fit_4 = histogram(X_red,nbins,'Normalization','pdf');
Hist_Fit_4(1).FaceColor = [.2 .2 .2];
bin_count = histcounts(X_red,7);
sum = 0;
for loop = 1:Hist_Fit_4.NumBins
    sum = sum + (Hist_Fit_4.BinEdges(loop) + 0.1*bin_count(loop));
end
mean_Hist_Fit_4 = sum / length(X_red);

var_Hist_Fit_4 = 0;
for loop = 1:Hist_Fit_4.NumBins
    var_Hist_Fit_4 = var_Hist_Fit_4 + ...
        (1/length(X_red))*(bin_count(loop)*((Hist_Fit_4.BinEdges(loop) - mean_Hist_Fit_4)^2));
end
std_Hist_Fit_4 = sqrt(var_Hist_Fit_4);

mu_Hist_Fit_4 = mean_Hist_Fit_4;
sigma_Hist_Fit_4 = std_Hist_Fit_4;
cdf_Hist_Fit_4 = [X_red,normcdf(X_red, mean_Hist_Fit_4, std_Hist_Fit_4)];
[KStest_Hist_Fit_4,pval_Hist_Fit_4,ksstat_Hist_Fit_4,cv_Hist_Fit_4] = kstest(X,'CDF',cdf_Hist_Fit_4,'Alpha',0.01)
x_Hist_Fit_4 = mu_Hist_Fit_4-(4*sigma_Hist_Fit_4):0.01:mu_Hist_Fit_2+(4*sigma_Hist_Fit_4);
y_Hist_Fit_4 = normpdf(x_Hist_Fit_4,mu_Hist_Fit_4,sigma_Hist_Fit_4);
plot(x_Hist_Fit_4,y_Hist_Fit_4,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_Hist_Fit_4)];
text(1.972,0.1251,txt)

title ('Distribution Fitting Techniques: Histogram using Doane bins')
legend ('Sample data fit','Histogram of Fit containing all the points', 'Fit considering all points',...
    'Histogram of Fit containing 15 points', 'Fit considering 15 points')



%% Kernel Density Estimate
%==========================%

% Case 1: Considering all the points
%-------------------------------------%

figure(7)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data-(4*sigma_data):0.01:mu_data+(4*sigma_data);
y_data = normpdf(x_data,mu_data,sigma_data);
plot(x_data,y_data,'--','LineWidth',2) 
hold on

KDE_Fit_1 = fitdist(X,'kernel','Bandwidth',0.63);
[KStest_KDE_Fit_1,pval_KDE_Fit_1,ksstat_KDE_Fit_1,cv_KDE_Fit_1] = kstest(X,'CDF',KDE_Fit_1,'Alpha',0.01)
y2 = pdf(KDE_Fit_1,x_values);
plot(x_values,y2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_KDE_Fit_1)];
text(-1.6, 0.1722 ,txt)
hold on

% Case 2: Considering 15 points
%-------------------------------------%

KDE_Fit_2 = fitdist(X_red,'kernel','Bandwidth',0.75);
[KStest_KDE_Fit_2,pval_KDE_Fit_2,ksstat_KDE_Fit_2,cv_KDE_Fit_2] = kstest(X,'CDF',KDE_Fit_2,'Alpha',0.01)
y2 = pdf(KDE_Fit_2,x_values);
plot(x_values,y2,'LineWidth',2)
txt = ['\leftarrow p =' num2str(pval_KDE_Fit_2)];
text(-0.8, 0.2541 ,txt)
title ('Distribution Fitting Techniques: Kernel Density Estimation')
legend ('Sample data fit','Fit considering all points','Fit considering 15 points')

%% Probability plots 

% Case 1: Assuming the data comes from a Extremevalue Distribution
% considering all points

figure(8)
% suptitle ('Probabilty Plots')

subplot(2,3,1)
Probplot_Fit_1 = probplot ('extreme value',X);
Probplot_Fit_1(1).Color = 'r';
Probplot_Fit_1(1).Marker = '*';
title('EV Distribution')

% Case 2: Assuming the data comes from a Normal distribution
% considering all points

subplot(2,3,2)
Probplot_Fit_2 = probplot ('normal',X);
Probplot_Fit_2(1).Color = 'r';
Probplot_Fit_2(1).Marker = '*';
title('Normal Distribution')

% Case 2: Assuming the data comes from a Half Normal distribution
% considering all points

subplot(2,3,3)
Probplot_Fit_3 = probplot ('half normal',X);
Probplot_Fit_3(1).Color = 'r';
Probplot_Fit_3(1).Marker = '*';
title('Half Normal Distribution')

% Case 4: Assuming the data comes from a Extremevalue Distribution
% considering 15 points

subplot(2,3,4)
Probplot_Fit_4 = probplot ('extreme value',X_red);
Probplot_Fit_4(1).Color = 'r';
Probplot_Fit_4(1).Marker = '*';
title('EV Distribution (15 pts)')

% Case 2: Assuming the data comes from a Normal distribution
% considering 15 points

subplot(2,3,5)
Probplot_Fit_5 = probplot ('normal',X_red);
Probplot_Fit_5(1).Color = 'r';
Probplot_Fit_5(1).Marker = '*';
title('Normal Distribution (15 pts)')

% Case 2: Assuming the data comes from a Half Normal distribution
% considering 15 points

subplot(2,3,6)
Probplot_Fit_6 = probplot ('half normal',X_red);
Probplot_Fit_6(1).Color = 'r';
Probplot_Fit_6(1).Marker = '*';
title('HalfNormal Distribution (15 pts)')