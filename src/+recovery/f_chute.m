function force_chute = f_chute(altitude, v_ground, v_apparent, vehicle, env)
%F_CHUTE Computes force from chutes.
%   Relatively simply model.
%   Advanced model here:
%   https://www.researchgate.net/publication/238563816_Six-Degree-of-Freedom_Model_of_a_Controlled_Circular_Parachute
    if (v_ground(3) < 0) && (altitude <= vehicle.main_chute_alt)
        total_area = vehicle.num_of_chutes*pi*(vehicle.main_chute_dia/2)^2;
        force_chute = ...
            -0.5*vehicle.main_chute_drag_coeff*env.density*total_area...
            *norm(v_apparent)*v_apparent;
    else
        force_chute = [0;0;0];
    end
end
