(define (domain domain-v0)
    
    ;; Defining options for planning system
    (:requirements :durative-actions :fluents :typing :duration-inequalities :timed-initial-literals)
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; duration-inequalities - Allows duration constraints in durative actions using inequalities.
    ;; durative-actions - Allows durative actions.
    ;; typing - Allow type names in declarations of variables
    ;; fluents - Allows numeric variables
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; Defining types
    (:types
        wafer - parts
        amr robot_arm - robot
        delivery_location part_location in_front_of_air_lock in_the_air_lock - location
    )

    (:predicates
        (robot_at ?robot - robot ?location - location)
        (piece_at ?parts - parts ?location - location)
        (is_amr_free ?amr - amr)
        (is_amr_carry ?amr - amr ?parts - parts)
        (is_robot_arm_free ?robot_arm - robot_arm)
        (is_robot_arm_carry ?robot_arm - robot_arm ?parts - parts)
        (is_sterile ?amr - amr)
        (is_dirty ?amr - amr)
        (location_is_free ?location - location)
        (is_connected_to  ?locationA - location ?locationB - location)
    )

    ;; Defining numeric variables 
    (:functions
        (abs_X_position ?location - location)
        (abs_Y_position ?location - location)
        (battery_level ?amr - amr)
        (amr_location ?amr - amr)
        (allowed_to_enter ?amr - amr)
        (factory_location ?location - location)
    )
         
    (:durative-action amr_move
        :parameters (?amr - amr ?from - location ?to - location)
        
        :duration 
            (= ?duration 
                (/
                    (+
                        (*
                            (-(abs_X_position ?from) (abs_X_position ?to)) (-(abs_X_position ?from) (abs_X_position ?to))
                        ) 
                        (*
                            (-(abs_Y_position ?from) (abs_Y_position ?to)) (-(abs_Y_position ?from) (abs_Y_position ?to))
                        )
                    ) 
                0.5)  
            ) 
        
        :condition
            (and 
                (at start (robot_at ?amr ?from))
                (at start (location_is_free ?to))
                (over all (location_is_free ?to))
                (at start (<= (factory_location ?to) (allowed_to_enter ?amr)))
            )
                
        :effect
            (and 
                (at end (robot_at ?amr ?to))
                (at start (not (location_is_free ?to)))
                (at start (location_is_free ?from))
                (at end (not (robot_at ?amr ?from)))
                (at end (assign (amr_location ?amr)  (factory_location ?to)))
            )
    )

    (:durative-action amr_pick_up_part
        :parameters (?amr - amr ?part_location - part_location ?parts - parts)
        
        :duration (= ?duration 1)
        
        :condition
            (and
                (at start (robot_at ?amr ?part_location))
                (over all (robot_at ?amr ?part_location))
                (at start (is_amr_free ?amr))
                (at start (is_sterile ?amr))
                (at start (piece_at ?parts ?part_location))
            )
            
        :effect
            (and
                (at end (is_amr_carry ?amr ?parts))
                (at end (not (piece_at ?parts ?part_location)))
                (at end (not (is_amr_free ?amr)))
            )
    )

    (:durative-action amr_deliver_part
        :parameters (?amr - amr ?location - location ?parts - parts)
        
        :duration (= ?duration 1)
        
        :condition
            (and
                (at start (robot_at ?amr ?location))
                (over all (robot_at ?amr ?location))
                (at start (is_amr_carry ?amr ?parts))
                (at start (is_dirty ?amr))
            )
            
        :effect
            (and
                (at end (is_amr_free ?amr))
                (at end (piece_at ?parts ?location))
                (at end (not (is_sterile ?amr)))
                (at end (not (is_amr_carry ?amr ?parts)))
            )
    )

    (:durative-action robot_arm_pick_part
        :parameters (?robot_arm - robot_arm ?amr - amr ?in_the_air_lock - in_the_air_lock ?parts - parts)
        
        :duration (= ?duration 1)
        
        :condition
            (and
                (at start (robot_at ?amr ?in_the_air_lock))
                (over all (robot_at ?amr ?in_the_air_lock))
                (at start (is_robot_arm_free ?robot_arm))
                (at start (is_amr_carry ?amr ?parts))
            )
            
        :effect
            (and
                (at end (is_robot_arm_carry ?robot_arm ?parts))
                (at end (not (is_robot_arm_free ?robot_arm)))
                (at end (not (is_amr_carry ?amr ?parts)))
                (at end (is_amr_free ?amr))
            )
    )

    (:durative-action robot_arm_place_part
        :parameters (?robot_arm - robot_arm ?amr - amr ?in_the_air_lock - in_the_air_lock ?parts - parts)
        
        :duration (= ?duration 1)
        
        :condition
            (and
                (at start (robot_at ?amr ?in_the_air_lock))
                (over all (robot_at ?amr ?in_the_air_lock))
                (at start (is_robot_arm_carry ?robot_arm ?parts))
                (at start (is_amr_free ?amr))
            )
            
        :effect
            (and
                (at end (is_robot_arm_free ?robot_arm))
                (at end (not (is_robot_arm_carry ?robot_arm ?parts)))
                (at end (is_amr_carry ?amr ?parts))
                (at end (not (is_amr_free ?amr)))
            )
    )
)
