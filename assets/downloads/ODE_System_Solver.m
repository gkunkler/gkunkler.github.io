%---------- Setup ----------%
warning('off', 'MATLAB:plot:IgnoreImaginaryXYPart');
clf
hold on
axis([-5,5,-5,5]);
T = linspace(-5,5,1000);

%---------- Create Matrix and Diagonalize ----------%

M = [1, 2;
     3, 1];

[V, D] = eig(M);

D = round(D,4);

display(D); %displays diagonal matrix (has eigenvalues)
display(V); %displays eigenvector matrix (the S in S^-1 A S = D)

%---------- Call Functions ----------%

% drawGrid(M)
    % draws the transformed gridlines parallel to the column vectors of M
drawGrid(M)

% solveAndPlotSolution(M, t)
    % uses the built-in MATLAB function dsolve()
    % plugs in time values to the solution
    % plots the final result thicker than plotFromGeneral()
%solveAndPlotSolution(M, T);

% plotFromGeneral(M, V, D, grid, t)
    % uses a hand solved generic solution that doesn't depend on M
    % plugs various values in for the arbitrary constants
    % uses generalized eigenvector for a defective matrix
plotFromGeneral(M, V, D, 3, T);

% plotVectors(M, V)
    % plots the column vectors of M
    % plots dotted lines in the directions of the eigenvectors 
plotVectors(M, V);

% animateFromGeneral(M, V, D, grid, repeats, range, maxPoints)
    % repeats a certain number of times
    % adds points to a line following an exact solution
    % c1 and c2 vary from -grid to grid
    % time varies from -range to range in increments of 0.5
    % method varies based on the number and type of eigenvalues
        % defective: generalized eigenvector
        % imaginary: euler's identity and real() / imag() 
    % animatedline has maximum number of points
animateFromGeneral(M, V, D, 3, 5, 5, 10);

% animateByEulersMethod(M, position, length, segments, pauseTime, drawComponents)
    % approximates a particular solution using Euler's method
    % starts at position and travels for length
    % pauseTime changes the speed of the animation
    % can also draw the components of velocity in terms of the 
        % column vectors of M
animateByEulersMethod(M, [1;2], 10, 1000, 0.001, false);

% ---------- functions below ----------%

function drawGrid(M)

    %Calculate values for first vector
    mag1 = sqrt(M(1,1)^2+M(2,1)^2); %magnitude of first vector
    
    x1 = [-M(1,1), M(1,1)];
    y1 = [-M(2,1), M(2,1)];
    
    %Calculate values for second vector
    mag2 = sqrt(M(1,2)^2+M(2,2)^2); %magnitude of second vector
    
    x2 = [-M(1,2), M(1,2)];
    y2 = [-M(2,2), M(2,2)];
    
    %plot grid lines for first vector while translating based on second
    %vector
    
    scale = 30; %scales length of grid lines
    iterations1 = 40/(mag1+1); %sets number of grid lines in first direction
    
    %plots axis for first vector
    plot(x1/mag1*scale, y1/mag1*scale, 'Color',  [0.75,0.75,0.75], 'LineWidth',1);
    
    %plots rest of the gridlines for first vector
    for i=[0:-1:-iterations1 0:1:iterations1]
        plot(x1/mag1*scale+i*M(1,2), y1/mag1*scale+i*M(2,2), 'Color',  [0.75,0.75,0.75], 'LineWidth',0.1);
    end
    
    iterations2 = 40/(mag2+1); %sets number of grid lines in second direction
    
    %plots axis for second vector
    plot(x2/mag2*scale, y2/mag2*scale, 'Color',  [0.75,0.75,0.75], 'LineWidth',1);
    
    %plots rest of the gridlines for second vector
    for i=[0:-1:-iterations2 0:1:iterations2]
        plot(x2/mag2*scale+i*M(1,1), y2/mag2*scale+i*M(2,1), 'Color',  [0.75,0.75,0.75], 'LineWidth',.1);
    end
end

function plotVectors(M, V)
    %plot original vectors
    plot([0,M(1,1)], [0,M(2,1)],'LineWidth',1, 'Color', 'r')
    plot([0,M(1,2)], [0,M(2,2)],'LineWidth',1, 'Color','m')
    
    %plot eigenvectors
    for i = 1:size(V,1)
        
        if isreal(V(:,i)) %check if eigenvector has an imaginary compenent
            if ~(V(2,i) == 0 && V(1,i) == 0) %check if eigenvector isn't the zero vector
                %plot eigenvector
                %plot([0,V(1,i)], [0,V(2,i)], 'Color','k','LineWidth',1);
                plot(15*[-V(1,i), V(1,i)],15*[-V(2,i), V(2,i)], 'Color', 'k','LineStyle','--', 'LineWidth',1);
            end
        end
    end
end

function solveAndPlotSolution(M, T)

    syms a(t) b(t) 
    %a(t) refers to x position
    %b(t) refers to y position

    %set up ODE
    odea = diff(a) == M(1,1)*a + M(1,2)*b; 
    odeb = diff(b) == M(2,1)*a + M(2,2)*b;

    %draws solution for 9 starting points within transformed plane
    for c1=-1:1:1
        for c2=-1:1:1
            %solve system with initial conditions
            S = dsolve([odea;odeb], [a(0)==c1*M(1,1)+c2*M(1,2), b(0)==c1*M(2,1)+c2*M(2,2)]);

            %plot solution to ODE
            plot(subs(S.a, t, T),subs(S.b, t, T), 'LineWidth',2);

            %plot starting point as star
            plot(c1*M(1,1)+c2*M(1,2),c1*M(2,1)+c2*M(2,2),'r*');
        end
    end

end

function plotFromGeneral(M, V, D, grid, t)
    %draws solution for various inputs for the arbitrary constants
    %rather than solving each initial condition from the beginning, I
    %plug into the general solution
    for c1=-grid:1:grid
        for c2=-grid:1:grid     
            %plug in for particular solution
            if D(1,1)==D(2,2)
                %use generalized eigenvector if defective
                v = (M-D(1,1)*eye(2))*[1;0];                        
                x = c1*v(1).*exp(D(1,1).*t) + c2.*exp(D(1,1).*t).*(1+v(1).*t);
                y = c1*v(2).*exp(D(1,1).*t) + c2.*exp(D(1,1).*t).*(v(2).*t);
            else
                x = c1*V(1,1)*exp(D(1,1)*t)+c2*V(1,2)*exp(D(2,2)*t);
                y = c1*V(2,1)*exp(D(1,1)*t)+c2*V(2,2)*exp(D(2,2)*t);
            end    
            %plot positions vs. time as dashed lines
            plot(x,y);
        end
    end
end

function animateFromGeneral(M, V, D, grid, repeats, range, maxPoints)

   %initialize animatedLines
   g = animatedline;
   for c1=-grid:1:grid
       for c2=-grid:1:grid   
           andy = animatedline('LineWidth',1.5, 'MaximumNumPoints',maxPoints);
           g(c1+grid+1,c2+grid+1) = andy;
       end
   end
   %repeat a specific number of times
   for r = 0:repeats-1
       %iterate through various values of time
       for k = -range:0.05:range
           for c1=-grid:1:grid
               for c2=-grid:1:grid
                   %for each animatedLine, add the correct points
                   x=0;
                   y=0;
                   if(D(1,1)==D(2,2))
                       %use generalized eignevector
                       v = (M-D(1,1)*eye(2))*[1;0];
                       x = c1*v(1)*exp(D(1,1)*k) + c2*exp(D(1,1)*k)*(1+v(1)*k);
                       y = c1*v(2)*exp(D(1,1)*k) + c2*exp(D(1,1)*k)*(v(2)*k);
                   elseif isreal(D(1,1))==false && isreal(D(2,2))==false
                       %use real and imaginary parts as x1 and x2
                       a = real(D(1,1));
                       b = imag(D(1,1));
                       c = real(V(1,1));
                       d = imag(V(1,1));
                       f = real(V(2,1));
                       h = imag(V(2,1));
                       x = c1*exp(a*k)*(c*cos(b*k)-d*sin(b*k)) + c2*exp(a*k)*(d*cos(b*k)+c*sin(b*k));
                       y = c1*exp(a*k)*(f*cos(b*k)-h*sin(b*k)) + c2*exp(a*k)*(h*cos(b*k)+f*sin(b*k));
                   else    
                       x = c1*V(1,1)*exp(D(1,1)*k) + c2*V(1,2)*exp(D(2,2)*k);
                       y = c1*V(2,1)*exp(D(1,1)*k) + c2*V(2,2)*exp(D(2,2)*k);
                   end   
                   addpoints(g(c1+grid+1,c2+grid+1), x, y);
               end
           end
           %draw to the screen between frames
           drawnow
       end
       %clear points between repetitions
       for c1=-grid:1:grid
           for c2=-grid:1:grid   
               clearpoints(g(c1+grid+1,c2+grid+1));
           end
       end
   end
end

function animateByEulersMethod(M, position, length, segments, pauseTime, drawComponents)
    %segments = number of steps
    %length = total length of the arc
    
    pos = position; %starting position
    
    vel = M*pos; %get starting velocity from ODE and position
    
    an = animatedline(pos(1), pos(2), 'LineWidth',3);
    dir = animatedline('Color', 'g', 'LineWidth', 2);
    dir1 = animatedline('Color', 'r', 'LineWidth', 2);
    dir2 = animatedline('Color', 'm', 'LineWidth', 2);
    
    %loop through each step for Euler integration
    for frame=0:length/segments:length
    
        %get unit vector for velocity
        direction = vel./(sqrt(sum(vel.^2)));
    
        %get vector projection of direction onto first vector
        direction1 = M(:,1)*dot(M(:, 1),direction)/dot(M(:,1), M(:,1));
    
        %get vector projection of direction onto second vector
        direction2 = M(:,2)*(dot(M(:, 2),direction))/dot(M(:,2), M(:,2));
    
        %add current position to arc
        addpoints(an, pos(1), pos(2));
    
        %draw direction vector
        clearpoints(dir);
        addpoints(dir, pos(1), pos(2));
        addpoints(dir, pos(1)+direction(1), pos(2)+direction(2));
    
        if drawComponents

            %draw projection on first vector
            clearpoints(dir1);
            addpoints(dir1, pos(1), pos(2));
            addpoints(dir1, pos(1)+direction1(1), pos(2)+direction1(2));
            addpoints(dir1, pos(1)+m(1, 1), pos(2)+m(2, 1));
        
            %draw projection on second vector
            clearpoints(dir2);
            addpoints(dir2, pos(1), pos(2));
            addpoints(dir2, pos(1)+direction2(1), pos(2)+direction2(2));
            addpoints(dir2, pos(1)+m(1, 2), pos(2)+m(2, 2));
            addpoints(dir2, pos(1)+direction2(1)-direction2(2), pos(2)+direction2(2)+direction2(1))
    
        end

        drawnow %redraw plot
    
        %add one segment's length of velocity to the current position
        pos = pos+direction*length/segments; 
    
        %get new velocity at new position
        vel = M*pos;
    
        %wait for slower animation
        pause(pauseTime);
    end
end