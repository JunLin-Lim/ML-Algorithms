function best = gene(Mut,Iter,Xover,Pop)
%best is [ bestfitnessvalue x1tox10ofbestchrom ]
Mut = 0.05; %0-0.05
Iter = 1000;
Xover = 0.5;
Pop = 40;
x = rand(Pop,10) * 10;      %x  = raw data
bi = rand(10,1);
%set selection criteria
Psys = 1;
V1 = x(1,:)';
V2 = 0;
V3 = 0;

fig = figure('position',[100 100 850 600]);
frame = [];
for i = 1:19
Psys = [ Psys Psys(i)+i ];
end

for j = 1:Iter 
    if j == 250
     %   Mut = 0.2;
    end
F1 = (x - 5).^2;            
F2 = sum(F1')';             %F2 = fitness value
[F3,idx] = sort(F2);         %sorting fitness
x(:,:) = x(idx(:),:);      %sorting raw data
x(21:40,:) = []  ;            %removing unfit pop
F3(21:40,:) = [] ;            %removing unfit pop
%n = (1:20)';                    %ranking
%P = (21 - n)./ sum(1:20);       %probability

k1 = randi(211,40,1) ;               %probabiltiy selection
k4 = [];
for i = 1:40
k2 = find(k1(i)>=Psys);
k3 = k2(end);
k4 = [k4;k3];
end
Parent = x(k4,:);                %Parent gene
x2 = zeros(20,10);
for i = 1:20
    for l = 1:10
        if rand > Mut
x2(i,l) = bi(l) * Parent(2*i-1,l) + (1- bi(l)) * Parent(2*i,l);
        else
            x2(i,l) = 10*rand;
        end
    end
end
x = [x;x2];
V1 = [V1 x(1,:)'];
V2 = [V2 F2(1)];
V3 = [V3 mean(F2)];
y = 1:j+1;


subplot(3,2,1)
plot(y,V1)
title('Chromosome 1')

subplot(3,2,3)
plot(y,V1)
title('Chromosome 1 Zoomed')
ylim([1.2*min(min(V1(:,max(1,end-20):end)))-0.2*max(max(V1(:,max(1,end-20):end))) 1.2*max(max(V1(:,max(1,end-20):end)))-0.2*min(min(V1(:,max(1,end-20):end)))])
xlim([y(max(end-20,1)) y(end)])

subplot(3,2,5)
plot(y,V2)
title('Average Fitness'); 
ylim([0 10])
f(i) = getframe(fig);

subplot(3,2,[2,4,6])
bar(x(1,:),0.8,'r')
axis([0 11 0 10])

frame = [ frame getframe ];

end
F1 = (x - 5).^2;      
F2 = sum(F1')';             %F2 = fitness value
[F3,idx] = sort(F2);         %sorting fitness
x(1:40) = x(idx(1:40));      %sorting raw data
bestF = F3(1);
bestC = x(1,:);
best = [bestF bestC];
end