clear all
clc

% Random position of robot
x=0;

while 1
    %Caluclate distance to right
    dd=abs(5-x);

    % Calculate P(ED|D)
    P_ED_D=exp(-dd/14);
    obs=Observation(P_ED_D);
    % Construct Bayesian net according to current info
    [PD,P_not_D]=PCD_Bayes_Net(x,obs);
    disp('P_D')
    disp(PD)
    disp('P not D')
    disp(P_not_D)
    % Bayesian reasoning, based on highest possibility
    if PD < P_not_D
        %Left movement
        disp('Move left')
        x=x-1;
    else
        % Right movement
        disp('Move right')
        x=x+1;
    end
    if x == 5 || x == -5
    break
    end
end

