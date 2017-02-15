function [obs] = Observation(ProbED)

% <Input>
% ProbED : Probabilit� d'entendre le son � droite
%
% <Output>
% obs=1 si le son est entendu � gauche, obs=2 si le son est entendu � droite

 
 if rand(1)>ProbED
     obs=1;
     disp('Etendu gauche')
 else
     obs=2;
     disp('Etendu droite')
 end