% Make sure packages are loaded
pkg load signal

% 1. Simulate a continuous "analog" signal (e.g., a simple 5 Hz brainwave)
% We use a very tiny step size (0.001) to make it look smooth
t_continuous = 0 : 0.001 : 1;
f = 5; % Frequency of 5 Hz
y_continuous = sin(2 * pi * f * t_continuous);

% 2. Simulate the A/D Conversion (Sampling)
% Let's sample the signal at 15 Hz (15 samples per second)
Fs = 6;
t_sampled = 0 : 1/Fs : 1;
y_sampled = sin(2 * pi * f * t_sampled);

% 3. Plot the comparison
figure;
% Plot the continuous signal as a blue line
plot(t_continuous, y_continuous, 'b-', 'LineWidth', 1.5);
hold on; % This command keeps the first plot on the screen so we can draw over it

% Plot the sampled digital points as red stems
stem(t_sampled, y_sampled, 'r', 'filled', 'LineWidth', 1.5);

title('Efeitos da Conversao A/D: Amostragem de um Sinal');
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Sinal Continuo', 'Sinal Amostrado (Digital)');
hold off;

