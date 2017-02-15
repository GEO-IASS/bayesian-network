clear all, close all, clc
%% Construct Bayesian net
N = 2;
dag = zeros(N,N);
M=1;T1=2;
dag(M,T1) = 1;


%% Node size: binary
node_sizes = 2*ones(1,N);

%% Creation of Bayesian net
bnet = mk_bnet(dag, node_sizes);
%% Visualize net
names={'M','T1'};
draw_graph(bnet.dag,names);

%% Define paramters

bnet.CPD{M} = tabular_CPD(bnet, M, [0.99 0.01]);
bnet.CPD{T1} = tabular_CPD(bnet, T1, [0.95 0.05 0.05 0.95]);


%% Définition de l'algorithme d'inférence
engine = jtree_inf_engine(bnet);

evidence = cell(1,N);

%  P(M|T)
evidence{T1} = 2;

[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, M);

disp('P(M|T)=')
disp(marg.T(2))
