% Coeficientes del polinomio y su derivada
coefficients_P = [1 11 -21 -10 -21 -5];
coefficients_prime = polyder(coefficients_P);  % Derivada del polinomio

% Aproximación inicial
z0 = -12;

% Número máximo de iteraciones
max_iterations = 100;

% Tolerancia para la convergencia
tolerance = 1e-5;

% Número de ejecuciones para medir el tiempo de ejecución 
num_executions = 100;

% Inicializar vector para almacenar los tiempos y errores
execution_times = zeros(1, num_executions);

for k = 1:num_executions
    % Inicialización
    z = z0;
    iteration = 0;

    % Iniciar temporizador
    tic;

    % Iteraciones del método de Newton-Raphson
    while iteration < max_iterations
        % Evaluación de P(z) y P'(z)
        P = polyval(coefficients_P, z);
        P_prime = polyval(coefficients_prime, z);

        % Fórmula de Newton-Raphson para números complejos
        z_new = z - P / P_prime;

        % Calcular el error relativo
        et = abs(z_new - z) / abs(z_new);

        % Verificar la convergencia
        if et < tolerance
            disp('Convergencia alcanzada.');
            break;
        end

        % Actualizar z para la siguiente iteración
        z = z_new;

        % Incrementar el contador de iteraciones
        iteration = iteration + 1;
    end

    % Detener temporizador y almacenar el tiempo
    execution_times(k) = toc;
    
    % Mostrar la raíz compleja encontrada
    disp(['Raíz compleja encontrada: ', num2str(z)]);
end

% Mostrar los tiempos de ejecución almacenados
disp('Tiempos de ejecución para varias ejecuciones:');
disp(execution_times);

% Ajuste de curvas mediante regresión lineal
execution_numbers = 1:num_executions;
fit_result = polyfit(execution_numbers, execution_times, 1);

% Mostrar los coeficientes de la regresión lineal
disp('Coeficientes del Ajuste de Curvas (regresión lineal):');
disp(fit_result);

% Evaluar el modelo en los números de ejecución
predicted_times = polyval(fit_result, execution_numbers);

% Graficar los datos y el ajuste de curvas
figure;
plot(execution_numbers, execution_times, 'o', 'DisplayName', 'Datos');
hold on;
plot(execution_numbers, predicted_times, 'r-', 'DisplayName', 'Ajuste de Curvas');
hold off;
xlabel('Número de Ejecución');
ylabel('Tiempo de Ejecución');
title('Ajuste de Curvas a los Tiempos de Ejecución');
legend;

