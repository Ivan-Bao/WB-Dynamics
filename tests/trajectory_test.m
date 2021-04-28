%% Unit tests for the `trajectory` function
%
%   The tests are relatively basic in nature in that it only just checks
%   the apogee to see if it is within reasonable bounds of what it is
%   somewhat expected to be. Essentially it is just an automated way to
%   check if new changes gives an completely unreasonable trajectory
%   instead of checking if the computed trajectory is super accurate.
function tests = trajectory_test
    tests = functiontests(localfunctions);
end

function test_40km_target(testCase)
    TARGET_ALT = 40000;
    ACCEPTABLE_ERR = 3000;
    
    load_mass = 319.5162962;
    fuselage_dia = 0.3048;
    fuselage_length = 5.943587967;
    nose_length = 0.6;
    num_of_fins = 4;
    fin_span = 0.4064;
    fin_thickness = 0.01;
    fin_leading_edge_sweep_angle = 30;
    fin_leading_edge_thickness_angle = 15;
    burn_time = 32;
    prop_flow_rate = 5.625;
    nozzle_eff = 0.98;
    c_star = 1584.619354;
    exit_pressure = 77295.59995;
    chamber_pressure = 900000;
    exp_area_ratio = 2.6;
    nozzle_exit_area = 0.024462561;
    ballute_alt = 75000;
    main_chute_alt = 3000;
    ballute_drag_coeff = 0.75;
    main_chute_drag_coeff = 0.53;
    ballute_dia = 1;
    main_chute_dia = 4.13;
    launch_angle = 89;
    launch_alt = 1401;

    vehicle = create_rocket(...
        load_mass, ...
        fuselage_dia, ...
        fuselage_length, ...
        nose_length, ...
        num_of_fins, ...
        fin_span, ...
        fin_thickness, ...
        fin_leading_edge_sweep_angle, ...
        fin_leading_edge_thickness_angle, ...
        burn_time, ...
        prop_flow_rate, ...
        nozzle_eff, ...
        c_star, ...
        exit_pressure, ...
        chamber_pressure, ...
        exp_area_ratio, ...
        nozzle_exit_area, ...
        ballute_alt, ...
        main_chute_alt, ...
        ballute_drag_coeff, ...
        main_chute_drag_coeff, ...
        ballute_dia, ...
        main_chute_dia, ...
        launch_angle, ...
        launch_alt);

    [time, state] = trajectory(vehicle);
    [apogee, ~] = find_apogee(time, state(:,3));
    verifyEqual(testCase, apogee, TARGET_ALT, 'AbsTol', ACCEPTABLE_ERR);
end

function test_100km_target(testCase)
    TARGET_ALT = 100000;
    ACCEPTABLE_ERR = 3000; % 3km is a bit high and maybe can be tone down a bit.

    load_mass = 657.6964825;
    fuselage_dia = 0.4064;
    fuselage_length = 7.006609822;
    nose_length = 0.7112;
    num_of_fins = 4;
    fin_span = 0.4064;
    fin_thickness = 0.01;
    fin_leading_edge_sweep_angle = 30;
    fin_leading_edge_thickness_angle = 15;
    burn_time = 36;
    prop_flow_rate = 12;
    nozzle_eff = 0.98;
    c_star = 1584.619354;
    exit_pressure = 62227.7237;
    chamber_pressure = 900000;
    exp_area_ratio = 2.8;
    nozzle_exit_area = 0.06244574;
    ballute_alt = 75000;
    main_chute_alt = 3000;
    ballute_drag_coeff = 0.75;
    main_chute_drag_coeff = 0.53;
    ballute_dia = 1;
    main_chute_dia = 4.13;
    launch_angle = 89;
    launch_alt = 1401;

    vehicle = create_rocket(...
        load_mass, ...
        fuselage_dia, ...
        fuselage_length, ...
        nose_length, ...
        num_of_fins, ...
        fin_span, ...
        fin_thickness, ...
        fin_leading_edge_sweep_angle, ...
        fin_leading_edge_thickness_angle, ...
        burn_time, ...
        prop_flow_rate, ...
        nozzle_eff, ...
        c_star, ...
        exit_pressure, ...
        chamber_pressure, ...
        exp_area_ratio, ...
        nozzle_exit_area, ...
        ballute_alt, ...
        main_chute_alt, ...
        ballute_drag_coeff, ...
        main_chute_drag_coeff, ...
        ballute_dia, ...
        main_chute_dia, ...
        launch_angle, ...
        launch_alt);

    [time, state] = trajectory(vehicle);
    [apogee, ~] = find_apogee(time, state(:,3));
    verifyEqual(testCase, apogee, TARGET_ALT, 'AbsTol', ACCEPTABLE_ERR);
end
