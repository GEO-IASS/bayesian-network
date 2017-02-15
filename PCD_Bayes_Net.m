function [pd,pd_not_d]=PCD_Bayes_Net(x, ED_true)
%% This function create a Bayesian net . It takes 2 parameters
%% x is the current position of the robot
%% ED_true is information indicate if the robot detects sound coming from right
%% Return: P(¬D|ED)  or P(D|¬ED) depending on ED_true
 

%% Distance
dg=abs(-5-x);
dd=abs(5-x);
%% Construct Bayesian net
N = 2;
dag = zeros(N,N);
D=1;ED=2;
dag(D,ED) = 1;

%% Node size: binary
node_sizes = 2*ones(1,N);

%% Creation of Bayesian net
bnet = mk_bnet(dag, node_sizes);
%% Visualize net
% names={'D','ED'};
% draw_graph(bnet.dag,names);

%% Define paramters

bnet.CPD{D} = tabular_CPD(bnet, D, [0.5 0.5]);
bnet.CPD{ED} = tabular_CPD(bnet, ED, [exp(-dg/10)  1-exp(-dd/14)  1-exp(-dg/11) exp(-dd/14)]);


%% Définition de l'algorithme d'inférence
engine = jtree_inf_engine(bnet);

evidence = cell(1,N);


evidence{ED} = ED_true;

[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, D);
pd_not_d=marg.T(1);
pd=marg.T(2);

