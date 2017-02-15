clear all, close all, clc
%% Construct Bayesian net
N = 4;
dag = zeros(N,N);
ng = 1; ar = 2; pl = 3; sm = 4;
dag(ng,[pl ar]) = 1;
dag(pl,sm) = 1;
dag(ar,sm)=1;
%% Node size: binary
node_sizes = 2*ones(1,N);

%% Creation of Bayesian net
bnet = mk_bnet(dag, node_sizes);
%% Visualize net
names={'ng','ar','pl','sm'};
draw_graph(bnet.dag,names);

%% Define paramters

bnet.CPD{ng} = tabular_CPD(bnet, ng, [0.5 0.5]);
bnet.CPD{pl} = tabular_CPD(bnet, pl, [0.8 0.2 0.2 0.8]);
bnet.CPD{ar} = tabular_CPD(bnet, ar, [0.5 0.9 0.5 0.1]);
bnet.CPD{sm} = tabular_CPD(bnet, sm, [1 0.1 0.1 0.01 0 0.9 0.9 0.99]);

%% Définition de l'algorithme d'inférence
engine = jtree_inf_engine(bnet);

evidence = cell(1,N);

% Q1 P(pl|sm)
evidence{sm} = 2;

[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, pl);

disp('P(pl|sm)=')
disp(marg.T(2))

% Q2 P(ar|sm)

evidence{sm} = 2;

[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, ar);

disp('P(ar|sm)=')
disp(marg.T(2))

% Q3 P(ar|sm,ng)

evidence{sm} = 2;
evidence{ng} = 2;
[engine, loglik] = enter_evidence(engine, evidence);

marg = marginal_nodes(engine, ar);

disp('P(ar|sm,ng)=')
disp(marg.T(2))
