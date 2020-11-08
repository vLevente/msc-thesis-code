(define (problem task)
(:domain domain-v0)
(:objects
    wafer1 wafer2 wafer3 wafer4 wafer5 wafer6 wafer7 wafer8 wafer9 wafer10 - wafer
    robot0 robot1 - amr
    robot_arm - robot_arm
    delivery_location - delivery_location
    part_location1 part_location2 part_location3 part_location4 part_location5 - part_location
    in_front_of_air_lock1 in_front_of_air_lock2 - in_front_of_air_lock
    in_the_air_lock - in_the_air_lock
)
(:init
    (robot_at robot0 in_front_of_air_lock1)
    (robot_at robot1 in_front_of_air_lock2)
    (robot_at robot_arm in_the_air_lock)

    (piece_at wafer1 part_location1)
    (piece_at wafer2 part_location1)
    (piece_at wafer3 part_location2)
    (piece_at wafer4 part_location2)
    (piece_at wafer5 part_location3)
    (piece_at wafer6 part_location3)
    (piece_at wafer7 part_location4)
    (piece_at wafer8 part_location4)
    (piece_at wafer9 part_location5)
    (piece_at wafer10 part_location5)

    (is_amr_free robot0)
    (is_amr_free robot1)


    (is_robot_arm_free robot_arm)


    (is_sterile robot0)

    (is_dirty robot1)

    (location_is_free part_location1)
    (location_is_free part_location2)
    (location_is_free part_location3)
    (location_is_free part_location4)
    (location_is_free part_location5)
    (location_is_free in_the_air_lock)
    (location_is_free delivery_location)

    (is_connected_to part_location1 in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 part_location1)
    (is_connected_to part_location2 in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 part_location2)
    (is_connected_to part_location3 in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 part_location3)
    (is_connected_to part_location4 in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 part_location4)
    (is_connected_to part_location5 in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 part_location5)
    (is_connected_to in_the_air_lock in_front_of_air_lock1)
    (is_connected_to in_front_of_air_lock1 in_the_air_lock)
    (is_connected_to in_the_air_lock in_front_of_air_lock2)
    (is_connected_to in_front_of_air_lock2 in_the_air_lock)
    (is_connected_to delivery_location in_front_of_air_lock2)
    (is_connected_to in_front_of_air_lock2 delivery_location)

    (= (abs_x_position part_location1) 16.84)
    (= (abs_x_position part_location2) 12.598)
    (= (abs_x_position part_location3) 9.598)
    (= (abs_x_position part_location4) 5.573)
    (= (abs_x_position part_location5) 2.647)
    (= (abs_x_position in_front_of_air_lock1) 18.437)
    (= (abs_x_position in_front_of_air_lock2) 23.646)
    (= (abs_x_position in_the_air_lock) 21.051)
    (= (abs_x_position delivery_location) 48.6)

    (= (abs_y_position part_location1) 0.238)
    (= (abs_y_position part_location2) 1.121)
    (= (abs_y_position part_location3) 1.121)
    (= (abs_y_position part_location4) 2.104)
    (= (abs_y_position part_location5) 5.275)
    (= (abs_y_position in_front_of_air_lock1) 8.834)
    (= (abs_y_position in_front_of_air_lock2) 8.766)
    (= (abs_y_position in_the_air_lock) 8.829)
    (= (abs_y_position delivery_location) 9)


    (= (amr_location robot0) 6)
    (= (amr_location robot1) 8)

    (= (allowed_to_enter robot0) 9)
    (= (allowed_to_enter robot1) 3)

    (= (factory_location part_location1) 9)
    (= (factory_location part_location2) 8)
    (= (factory_location part_location3) 7)
    (= (factory_location part_location4) 6)
    (= (factory_location part_location5) 5)
    (= (factory_location in_front_of_air_lock1) 4)
    (= (factory_location in_the_air_lock) 3)
    (= (factory_location in_front_of_air_lock2) 2)
    (= (factory_location delivery_location) 1)

)
(:goal (and
    (piece_at wafer1 delivery_location)
    (piece_at wafer2 delivery_location)
))
(:metric minimize (* (total-time) 3))
)
