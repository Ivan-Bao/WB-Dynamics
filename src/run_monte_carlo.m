% Runs the trajectory simulation many times in a stochastic manner using
% Monte Carlo. To sample, latin hypercube is used as it is a more
% computationally feasible method. Every variable is normally distributed.
% Now this claim can be argued against.
clc;
clear;
rng default; % For reproducibility

OUTPUT_PATH = "../output";
OUTPUT_FILE = fullfile(OUTPUT_PATH, "output.csv");
INPUT_PATH = "../input";
INPUT_FIELDS_FILE = fullfile(INPUT_PATH, "fields_input.csv");
INPUT_ERRORS_FILE = fullfile(INPUT_PATH, "errors_input.csv");

%% Simulation settings
NUM_OF_SAMPLES = 1000;
STEP_SIZE = 0.1;

% Take samples
[vehicle_samples, env_samples] = simulation_samples(INPUT_FIELDS_FILE, INPUT_ERRORS_FILE, NUM_OF_SAMPLES);


%% Perform simulation
points = zeros(NUM_OF_SAMPLES, 6);

parfor sam_num = 1:NUM_OF_SAMPLES
    vehicle = vehicle_samples(sam_num);
    env = env_samples(sam_num);

    [time, state] = trajectory(vehicle, env, STEP_SIZE);
    [apogee, apogee_time] = util.find_apogee(time, state(:,3));
    x = state(end,1);
    y = state(end,2);
    landing_time = time(end);
    
    % touch down velocity magnitude
    v_touchdown_x = spline(time, state(:,8), landing_time);
    v_touchdown_y = spline(time, state(:,9), landing_time);
    v_touchdown_z = spline(time, state(:,10), landing_time);
    v_touchdown = norm([v_touchdown_x v_touchdown_y v_touchdown_z]);
    
    points(sam_num,:) = [apogee_time, apogee, landing_time, x, y, v_touchdown];
end
writematrix(points, OUTPUT_FILE);
scatter(points(:,4), points(:,5));