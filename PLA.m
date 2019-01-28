fid = fopen('hw1_8_train.dat.txt','r');
datacell = textscan(fid, '%f%f%f%f%f', 'Collect', 1);
fclose(fid);
data = datacell{1};


%% 8. (*, 20 points) Implement a version of PLA by visiting examples in fixed, 
% pre-determined random cycles throughout the algorithm. Run the algorithm on the data set. 
% Please repeat your experiment for 2000 times, each with a different random seed. 
% What is the average number of updates before the algorithm halts? Plot a histogram ( https://en.wikipedia.org/wiki/Histogram ) to show the number of updates versus the frequency of the number.

% solution :
% 1.executes experiment of PLA for 2000 times
% 2.in each experiment,executes PLA with the data shuffled in matrix sample and caculates
%   the number of updates to matrix numUpdates
% 3.calculates the average number of updates
% 4.show the histogram using matrix numUpdates


numUpdates(1:2000)=0; % # of updates that each experiment makes
experiment=1;
while experiment <=2000
        
        w=[0 0 0 0 0];
        t=1; %the element now being considered
        count=1; %counter for consecutive success 
        idx = randperm(400); %shuffle the index of the visiting order (1~400)
        sample = data;
        for i = 1:5 %put data into training matrix by the idx order
            sample(idx,i) = data(:,i);
        end

        while count <400    
                x0   = 1;
                x1   = sample(t,1);
                x2   = sample(t,2);
                x3   = sample(t,3);
                x4   = sample(t,4);
                y    = sample(t,5);
                s = w(1,1)+w(1,2)*x1+w(1,3)*x2+w(1,4)*x3+w(1,5)*x4;
                if s == 0
                    s = -1;
                end 
                s = sign(s);
                if s == y
                   count = count+1;
                end
                if s ~= y
                   n=1; %weight
                   w(1,1)=w(1,1)+n*y;
                   w(1,2)=w(1,2)+n*y*x1;
                   w(1,3)=w(1,3)+n*y*x2;
                   w(1,4)=w(1,4)+n*y*x3;
                   w(1,5)=w(1,5)+n*y*x4; 
                   numUpdates(1,experiment)=numUpdates(1,experiment)+1;
                   count=0;
                end
                t= t + 1;
                if t > 400
                    t= 1;
                end

                %pause();
        end        
    experiment=experiment+1;
end


M = mean(numUpdates);
disp("average number of updates : " + M); 

histogram(numUpdates);






