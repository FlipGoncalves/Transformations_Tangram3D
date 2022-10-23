function pFinal = Animate(h, P, pInicial, D, N)

    % pFinal - matrix com a posicao do objeto na posicao final
    % h - handle gráfico do objeto a animar
    % P - matrix de pontos do objeto
    % pInicial - Matriz de transformação da posição inicial do objeto
    % D - vetor [x, y, z, alpha_x, alpha_y, alpha_z]
    % N - duração do movimento

    x = linspace(0, D(1), N);
    y = linspace(0, D(2), N);
    z = linspace(0, D(3), N);
    ax = linspace(0, D(4), N);
    ay = linspace(0, D(5), N);
    az = linspace(0, D(6), N);

    for k = 1:N
        % sobre o seu proprio referencial
        M = Trans(x(k), y(k), z(k)) * RotX(ax(k)) * RotY(ay(k)) * RotZ(az(k));

        % Transformação final ou seja a trans. local (M) afetada pela trans. global (pInicial)
        T = M*pInicial;
        P1 = T*P;

        set(h, 'XData', P1(1,:), 'YData', P1(2,:), 'ZData', P1(3,:));
        pause(0.05);
    end

    pFinal = T;

end