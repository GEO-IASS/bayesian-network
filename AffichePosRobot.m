function AffichePosRobot(X)

% <Input>
% X : position du robot en -5 et 5

figure(20), clf, hold on, grid on, title('Appuyez sur une touche')
plot(-5,0,'gV'); text(-5,0.1,'source gauche');
plot(5,0,'gV'); text(5,0.1,'source droite');

plot(X,0,'bS'); text(X,-0.1,'robot');
axis([-6,6,-1,1]), pause();