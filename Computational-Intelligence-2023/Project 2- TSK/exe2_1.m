clear;
clc;
close all;

%Import Dataset
data = importdata('airfoil_self_noise.dat');

%Normalize data
for i = 1:size(data,2)
    data(:,i) = (data(:,i) - min(data(:,i))) / ( max(data(:,i)) - min(data(:,i)));
end

%Split dataset
[train_data, check_data, validate_data] = split_scale(data,1);

RMSE = zeros(4,1);
NMSE = zeros(4,1);
NDEI = zeros(4,1);
R2 = zeros(4,1);
epochs = 200;
inputMF_n = [2, 3, 2, 3];
outputMF_type = {'constant', 'linear', 'constant', 'linear'}; %constant -> Singelton, linear-> Polynomial
for i = 1
        genfisopt = genfisOptions('GridPartition');
        genfisopt.InputMembershipFunctionType = 'gbellmf';
        genfisopt.NumMembershipFunctions = inputMF_n(i);
        genfisopt.OutputMembershipFunctionType = outputMF_type{i};        
        fis = genfis(train_data(:,1:end-1),train_data(:,end),genfisopt);
   
        anfisopt = anfisOptions;
        anfisopt.InitialFIS = fis;
        anfisopt.EpochNumber = 100;
        anfisopt.ValidationData = validate_data;
        [trnfis,trainError,stepSize,chkFIS,chkError] = anfis(train_data,anfisopt);
        
        
        %Membership Functions before training
        labels = {'Frequency (Hz)', 'Angle of attack (deg)', 'Chord length (m)', 'Free-stream velocity (m/s)', ' Suction side displacement thickness (m)'};
        figure()
        for mf = 1:5
            subplot(2,3,mf)
            plotmf(fis,'input',mf);
            xlabel(labels{mf})
            
        end
        name = strcat('[TSK Model ', num2str(i), '] Membership Functions before training');
        suptitle(name);
        saveas(gcf,name,'pdf'); 

       %Membership Functions after training
       labels = {'Frequency (Hz)', 'Angle of attack (deg)', 'Chord length (m)', 'Free-stream velocity (m/s)', ' Suction side displacement thickness (m)'};
       figure()
       for mf = 1:5
           subplot(2,3,mf)
           plotmf(chkFIS,'input',mf);
           xlabel(labels{mf})        
       end
       name = strcat('[TSK Model ', num2str(i), '] Membership Functions after training');
       suptitle(name);
       saveas(gcf,name,'pdf');  
       
       %Learning Curve 
       figure()
       hold on;
       plot(1:length(trainError),trainError,'LineWidth',2);
       plot(1:length(trainError),chkError,'LineWidth',2);
       hold off;
       xlabel('Number of Iterations');
       ylabel('Error');
       legend('Training Error', 'Validation Error');
       name = strcat('[TSK Model ', num2str(i), '] Learning Curve');
       title(name);
       saveas(gcf,name,'pdf');  
              
       %Prediction Error      
       y_pred = evalfis(chkFIS, validate_data(:,1:end-1));
       y_real = validate_data(:,end);
       pred_error = abs(y_pred - y_real);
       figure()
       subplot(1,2,1)
       hold on;
       plot(1:length(y_pred), y_pred);
       plot(1:length(y_pred), y_real);
       hold off;
       legend('Predicted Value', 'Real Value');
       title('Real and Predicted Output Value');
       subplot(1,2,2)
       plot(1:length(y_pred),pred_error);
       title('Prediction Error');
       name = strcat('[TSK Model ', num2str(i), '] Prediction Error');
       suptitle(name);
       saveas(gcf,name,'pdf');  
        
       %Display metrics
       SSres = sum((y_real - y_pred).^2);
       SStot = sum((y_real - mean(y_real)).^2);
       RMSE(i) = sqrt(SSres);
       R2(i) = 1 - SSres/SStot;
       NMSE(i) = SSres/SStot;
       NDEI(i) = sqrt(NMSE(i));
       disp(['---------------TSK MODEL ', num2str(i),'---------------']);
       disp(['RMSE = ' num2str(RMSE(i))]);
       disp(['NMSE = ' num2str(NMSE(i))]);
       disp(['NDEI = ' num2str(NDEI(i))]);
       disp(['R2 = ' num2str(R2(i))]);
end