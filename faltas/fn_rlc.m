function J = fn_rlc(theta)
    global Pao Flow t
    R = theta(1); L = theta(2); C = theta(3);
    
    if R <= 0 || L <= 0 || C <= 0
        J = 1e10; % Punição para parâmetros fisicamente impossíveis
        return;
    end
    
    A = [0 1; -1/(L*C) -R/L];
    B = [0; 1/L];
    sys = ss(A, B, [0 1], 0);
    Flow_pred = lsim(sys, Pao, t);
    J = sum((Flow - Flow_pred).^2);
end