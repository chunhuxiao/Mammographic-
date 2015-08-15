function [] = matchingModule()
rng(1);
load('data.mat');
f = size(roi_features,2);
X = roi_features(:,1:f-1);
Y = roi_features(:,f);
c = cvpartition(Y,'KFold',5);

avgTrainConf = zeros(2,2);
avgTestConf = zeros(2,2);

for i=1:5
    trX = [];
    trY = [];
    tsX = [];
    tsY = [];
    ind = c.training(i);
    for j = 1:size(ind,1)
        if( ind(j)==1 )
            trX = [ trX;X(j,:)];
            trY = [ trY;Y(j,:)];
        else
            tsX = [ tsX;X(j,:)];
            tsY = [ tsY;Y(j,:)];
        end
    end
    svmModel = svmtrain(trX,trY,'kernel_function','quadratic');
    predictedTr = svmclassify(svmModel,trX);
    
    conM = zeros(2,2);
    conM(1,1) = sum( ( (predictedTr==1) + (trY==1))==2 );
    conM(1,2) = sum( ((predictedTr==-1) + (trY==1))==2);
    conM(2,1 ) = sum( ((predictedTr==1) + (trY==-1))==2);
    conM(2,2) = sum( ((predictedTr==-1) + (trY==-1))==2);
    
    disp('Confusion matrix for training ');
    conM
    avgTrainConf = avgTrainConf + conM;
    predictedTs = svmclassify(svmModel,tsX);
    
    conM = zeros(2,2);
    conM(1,1) = sum( ( (predictedTs==1) + (tsY==1))==2 );
    conM(1,2) = sum( ((predictedTs==-1) + (tsY==1))==2);
    conM(2,1 ) = sum( ((predictedTs==1) + (tsY==-1))==2);
    conM(2,2) = sum( ((predictedTs==-1) + (tsY==-1))==2);
    
    disp('Confusion matrix for testing ');
    conM
    avgTestConf = avgTestConf + conM;
end
avgTestConf = avgTestConf/5;
avgTrainConf = avgTrainConf/5;

sm = sum(sum(avgTrainConf));
avgTrainConf = avgTrainConf/sm

sm = sum(sum(avgTestConf));
avgTestConf = avgTestConf/sm
end