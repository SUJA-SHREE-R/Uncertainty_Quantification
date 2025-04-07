clear all
clc

%% Generating a random normal dataset with mean 0 and STD 1
rng(5)
X = normrnd(0,1,20,1);
X_red = X(1:15,1);

data_mean = mean(X);
data_std = std(X);

%% Method of Maximum Likelihood Estimation
figure(1)
mu_data = data_mean;
sigma_data = data_std;
x_data = mu_data - (4*sigma_data):0.01:mu_data + (4*sigma_data);
y_data = normpdf(x_data, mu_data, sigma_data);
plot(x_data, y_data, '--', 'LineWidth', 2)
hold on

% Case 1a: MLE - ExtremeValue, all points
MLE_Fit_1 = fitdist(X, 'ExtremeValue');
[KStest_MLE_Fit_1, pval_MLE_Fit_1] = kstest(X, 'CDF', MLE_Fit_1, 'Alpha', 0.01);
x_values = -5:0.2:5;
y1 = pdf(MLE_Fit_1, x_values);
plot(x_values, y1, 'LineWidth', 2)
text(-0.41, 0.2481, ['p = ' num2str(pval_MLE_Fit_1)], 'HorizontalAlignment', 'right')

% Case 1b: MLE - Normal, all points
MLE_Fit_2 = fitdist(X, 'Normal');
[KStest_MLE_Fit_2, pval_MLE_Fit_2] = kstest(X, 'CDF', MLE_Fit_2, 'Alpha', 0.01);
y2 = pdf(MLE_Fit_2, x_values);
plot(x_values, y2, 'LineWidth', 2)
text(-0.4, 0.3511, ['\leftarrow p = ' num2str(pval_MLE_Fit_2)])

% Case 2a: MLE - ExtremeValue, 15 points
MLE_Fit_3 = fitdist(X_red, 'ExtremeValue');
[KStest_MLE_Fit_3, pval_MLE_Fit_3] = kstest(X, 'CDF', MLE_Fit_3, 'Alpha', 0.01);
y3 = pdf(MLE_Fit_3, x_values);
plot(x_values, y3, 'LineWidth', 2)
text(-0.4, 0.2283, ['\leftarrow p = ' num2str(pval_MLE_Fit_3)])

% Case 2b: MLE - Normal, 15 points
MLE_Fit_4 = fitdist(X_red, 'Normal');
[KStest_MLE_Fit_4, pval_MLE_Fit_4] = kstest(X, 'CDF', MLE_Fit_4, 'Alpha', 0.01);
y4 = pdf(MLE_Fit_4, x_values);
plot(x_values, y4, 'LineWidth', 2)
text(-0.6, 0.2906, ['\leftarrow p = ' num2str(pval_MLE_Fit_4)])

title('Distribution Fitting Techniques: Method of Maximum Likelihood Estimation')
legend('Sample data fit', 'ExtremeValue Fit - all points', 'Normal Fit - all points', ...
       'ExtremeValue Fit - 15 points', 'Normal Fit - 15 points')


%% Method of Moments
figure(2)
plot(x_data, y_data, '--', 'LineWidth', 2)
hold on

% Case 1: MOM - all points
mu_MOM_Fit_1 = mean(X);
sigma_MOM_Fit_1 = std(X);
cdf_MOM_Fit_1 = [X, normcdf(X, mu_MOM_Fit_1, sigma_MOM_Fit_1)];
[KStest_MOM_Fit_1, pval_MOM_Fit_1] = kstest(X, 'CDF', cdf_MOM_Fit_1, 'Alpha', 0.01);
x1 = mu_MOM_Fit_1 - 4*sigma_MOM_Fit_1 : 0.01 : mu_MOM_Fit_1 + 4*sigma_MOM_Fit_1;
y1 = normpdf(x1, mu_MOM_Fit_1, sigma_MOM_Fit_1);
plot(x1, y1, 'LineWidth', 2)
text(0.1824, 0.3718, ['\leftarrow p = ' num2str(pval_MOM_Fit_1)])

% Case 2: MOM - 15 points
mu_MOM_Fit_2 = mean(X_red);
sigma_MOM_Fit_2 = std(X_red);
cdf_MOM_Fit_2 = [X_red, normcdf(X_red, mu_MOM_Fit_2, sigma_MOM_Fit_2)];
[KStest_MOM_Fit_2, pval_MOM_Fit_2] = kstest(X, 'CDF', cdf_MOM_Fit_2, 'Alpha', 0.01);
x2 = mu_MOM_Fit_2 - 4*sigma_MOM_Fit_2 : 0.01 : mu_MOM_Fit_2 + 4*sigma_MOM_Fit_2;
y2 = normpdf(x2, mu_MOM_Fit_2, sigma_MOM_Fit_2);
plot(x2, y2, 'LineWidth', 2)
text(-0.6743, 0.2879, ['\leftarrow p = ' num2str(pval_MOM_Fit_2)])

title('Distribution Fitting Techniques: Method of Moments')
legend('Sample data fit', 'Normal Fit - all points', 'Normal Fit - 15 points')


%% Method of L-Moments
figure(3)
plot(x_data, y_data, '--', 'LineWidth', 2)
hold on

% Case 1: L-MOM - all points
mu_LMO_Fit_1 = mean(X);
sigma_LMO_Fit_1 = std(X)/sqrt(pi);
cdf_LMO_Fit_1 = [X, normcdf(X, mu_LMO_Fit_1, sigma_LMO_Fit_1)];
[KStest_LMO_Fit_1, pval_LMO_Fit_1] = kstest(X, 'CDF', cdf_LMO_Fit_1, 'Alpha', 0.01);
x1 = mu_LMO_Fit_1 - 4*sigma_LMO_Fit_1 : 0.01 : mu_LMO_Fit_1 + 4*sigma_LMO_Fit_1;
y1 = normpdf(x1, mu_LMO_Fit_1, sigma_LMO_Fit_1);
plot(x1, y1, 'LineWidth', 2)
text(0.1587, 0.6218, ['\leftarrow p = ' num2str(pval_LMO_Fit_1)])

% Case 2: L-MOM - 15 points
mu_LMO_Fit_2 = mean(X_red);
sigma_LMO_Fit_2 = std(X_red)/sqrt(pi);
cdf_LMO_Fit_2 = [X_red, normcdf(X_red, mu_LMO_Fit_2, sigma_LMO_Fit_2)];
[KStest_LMO_Fit_2, pval_LMO_Fit_2] = kstest(X, 'CDF', cdf_LMO_Fit_2, 'Alpha', 0.01);
x2 = mu_LMO_Fit_2 - 4*sigma_LMO_Fit_2 : 0.01 : mu_LMO_Fit_2 + 4*sigma_LMO_Fit_2;
y2 = normpdf(x2, mu_LMO_Fit_2, sigma_LMO_Fit_2);
plot(x2, y2, 'LineWidth', 2)
text(0.2, 0.4, ['\leftarrow p = ' num2str(pval_LMO_Fit_2)])

title('Distribution Fitting Techniques: Method of L-Moments')
legend('Sample data fit', 'Normal Fit - all points', 'Normal Fit - 15 points')
