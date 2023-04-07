clear;
clc;    
close all;

data = readmatrix('train.csv');
[train_data, check_data, validate_data] = split_scale(data,1);

num_of_features = [7 10 15 20];

% cluster influence range indicates the range of influence of a cluster when you consider the data space as a unit hypercube. Specifying a small cluster radius usually generates many small clusters in the data, which produces a FIS with many rules. Specifying a large cluster radius usually produces a few large clusters in the data and results in fewer rules
ra = [0.2,0.4,0.6,0.8]; 

error = zeros(4,4);
num_of_rules = zeros(4,4);
for i = 1:length(num_of_features)
    for j = 1:length(ra)
        n_of_features = num_of_features(i);
        
        it_error = zeros(1,5);
        for k = 1:5 %k-fold cross validation
            it_data = [train_data; validate_data];
            it_data = it_data(randperm(size(it_data, 1)),:);
            it_train = it_data(1:ceil(0.8*size(it_data,1)),:);
            it_val = it_data(ceil(0.8*size(it_data,1)):end,:);
            
            %Relieff algorithm to find importance of features
            [indexes,weights] = relieff(it_train(:,1:end-1),it_train(:,end),10);
            
            %Only get the most important features and the output
            it_train = [it_train(:,indexes(1:num_of_features(i))), it_train(:,end)];
            it_val = [it_val(:,indexes(1:num_of_features(i))) ,it_val(:,end)];

            %Generate FIS Using Data Clusters
            genfis_opt = genfisOptions('SubtractiveClustering','ClusterInfluenceRange',ra(j));
            fis = genfis(it_train(:,1:end-1), it_train(:,end), genfis_opt);
            
            %Training Fis
            anfis_opt = anfisOptions('InitialFis',fis,'EpochNumber',100);
            anfis_opt.ValidationData = it_val;
            anfis_opt.DisplayANFISInformation = 0;
            [trnFis,trnError,stepSize,valFis,valError] = anfis(it_train, anfis_opt);
            
            it_error(k) = valError(100);
        end
        error(i,j) = mean(it_error);
        num_of_rules(i,j) = size(showrule(valFis),1);
    end 
   
end