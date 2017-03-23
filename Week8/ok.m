i_negative = (c_particles < 0);       % logical index of negative particles
i_positive = ~i_negative;             % invert to get positive particles
x_negative = x_particles(i_negative); % select x-coords of negative particles
x_positive = x_particles(i_positive); % select x-coords of positive particles
y_negative = y_particles(i_negative);
y_positive = y_particles(i_positive);

scatter(x_negative, y_negative, 5, [0 0 1], 'filled');
hold on; % do the next plot overlaid on the current plot
scatter(x_positive, y_positive, 5, [1 0 0], 'filled');