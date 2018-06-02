;;Domain for cleaning floor tiles
;; Define the name for this domain (needs to match the domain definition
;;   in the problem files)

(define (domain floor-tile)

	;; We only require some typing to make this plan faster. We can do without!
	(:requirements :typing)

	;; We have two types: robots and the tiles, both are objects
	(:types robot tile - object)

	;; define all the predicates as they are used in the problem files
	(:predicates  

    ;; described what tile a robot is at
    (robot-at ?robot - robot ?robotTile - tile)

    ;; indicates that tile ?tileAbove is above tile ?tileBelow
    (up ?tileAbove - tile ?tileBelow - tile)

    ;; indicates that tile ?tileBelow is below tile ?tileAbove
    (down ?tileBelow - tile ?tileAbove - tile)

    ;; indicates that tile ?tileOnRight is right of tile ?tileOnLeft
    (right ?tileOnRight - tile ?tileOnLeft - tile)

    ;; indicates that tile ?tileOnLeft is left of tile ?tileOnRight
    (left ?tileOnLeft - tile ?tileOnRight - tile)
    
    ;; indicates that a tile is clear (robot can move there)
    (clear ?clearedTile - tile)

    ;; indicates that a tile is cleaned
    (cleaned ?cleanedTile - tile)
 	)
  
  ;; actions
  ;; clean-up action  
  (:action clean-up
        ;; clean-up action takes a robot object called robot and it takes two tile objects called tileToBeCleaned and robotTile
        :parameters (?robot - robot ?robotTile - tile ?tileToBeCleaned - tile)
        ;; Preconditions for the action clean-up
        :precondition (and
                       ;; The clean-up action uses the predicate called robot-at to check a robot is on a tile
                       (robot-at ?robot ?robotTile) 
                       ;; The predicate called up is used to check if the tileToBeCleaned is above the tile that the robot is on
                       (up ?tileToBeCleaned ?robotTile) 
                       ;;The predicate clear is used to check if the tileToBeCleaned is clear
                       (clear ?tileToBeCleaned)
                       ;; This precondition uses the predicate cleaned,this  is used to check if the tileToBeCleaned is not cleaned
                       (not(cleaned ?tileToBeCleaned))
                  )
    ;;Effects of the action clean-up 					
    :effect (and 
              ;; The action clean-up causes the tileToBeCleaned to be cleaned and so the predicate cleaned is used to show the tileToBeCleaned is cleaned
               ( cleaned ?tileToBeCleaned)
              ;; As the tile is now clean it is also not clear as the robot cannot move on clean tiles
               (not(clear ?tileToBeCleaned))
            )
  )
  
  ;;clean-down action
  (:action clean-down
      ;; clean-down action takes a robot object called robot and it takes two tile objects called tileToBeCleaned and robotTile
     :parameters (?robot - robot ?robotTile - tile ?tileToBeCleaned - tile )
   ;; Preconditions for the action clean-down 
   :precondition (and 
                       ;; The clean-down action uses the predicate called robot-at to check a robot is on a tile
                      (robot-at ?robot ?robotTile)
                       ;; The predicate called up is used to check if the tileToBeCleaned is above the tile that the robot is on
                      (down ?tileToBeCleaned ?robotTile)
                       ;;The predicate clear is used to check if the tileToBeCleaned is clear
                      (clear ?tileToBeCleaned) 
                       ;; This precondition uses the predicate cleaned,this  is used to check if the tileToBeCleaned is not cleaned
                      (not(cleaned ?tileToBeCleaned))
                  )
   ;;Effects of the action clean-down 	
    :effect (and 
              ;; The action clean-down causes the tileToBeCleaned to be cleaned and so the predicate cleaned is used to show the tileToBeCleaned is cleaned
              ( cleaned ?tileToBeCleaned)
              ;; As the tile is now clean it is also not clear as the robot cannot move on clean tiles
              (not(clear ?tileToBeCleaned))
          )
  )
  
  ;; up action
  (:action up
          ;; up action takes a robot object called robot and it takes two tile objects called moveToNextTile and robotTile
         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)
         ;; Preconditions for the action up
         :precondition (and 
                      ;; The up action uses the predicate called robot-at to check a robot is on a tile
                        (robot-at ?robot ?robotTile)
                       ;; The predicate called up is used to check if the moveToNextTile is above the tile that the robot is on 
                        (up ?moveToNextTile ?robotTile)
                        ;;The predicate clear is used to check if the moveToNextTile is clear
                        (clear ?moveToNextTile)
                         ;; This precondition uses the predicate cleaned,this  is used to check if the moveToNextTile is not cleaned
                        (not(cleaned ?moveToNextTile))
                       )
          ;;Effects of the action up
         :effect (and 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is not on its old tile position
                  (not(robot-at ?robot ?robotTile)) 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is on the moveToNextTile
                  (robot-at ?robot ?moveToNextTile)
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot is on the moveToNextTile and so it is not clear
                  (not(clear ?moveToNextTile)) 
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot's old tile position is now clear
                  ( clear ?robotTile)
                 )  
  )
  
  ;; down action
  (:action down
         ;; down action takes a robot object called robot and it takes two tile objects called moveToNextTile and robotTile
         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)
         ;; Preconditions for the action down
         :precondition (and 
                      	;; The down action uses the predicate called robot-at to check a robot is on a tile
                        (robot-at ?robot ?robotTile)
                       	;; The predicate called down is used to check if the moveToNextTile is below the tile that the robot is on 
                        (down ?moveToNextTile ?robotTile)
                        ;;The predicate clear is used to check if the moveToNextTile is clear
                        (clear ?moveToNextTile)
                        ;; This precondition uses the predicate cleaned,this  is used to check if the moveToNextTile is not cleaned
                        (not(cleaned ?moveToNextTile))
                       )
          ;;Effects of the action down
         :effect (and 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is not on its old tile position
                  (not(robot-at ?robot ?robotTile)) 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is on the moveToNextTile
                  (robot-at ?robot ?moveToNextTile)
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot is on the moveToNextTile and so it is not clear
                  (not(clear ?moveToNextTile)) 
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot's old tile position is now clear
                  ( clear ?robotTile)
                 )  
  )
  
  ;; right action
  (:action right
         ;; right action takes a robot object called robot and it takes two tile objects called moveToNextTile and robotTile
         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)
         ;; Preconditions for the action right
         :precondition (and 
                      	;; The right action uses the predicate called robot-at to check a robot is on a tile
                        (robot-at ?robot ?robotTile)
                      	;; The predicate called right is used to check if the moveToNextTile is below the tile that the robot is on 
                        (right ?moveToNextTile ?robotTile)
                        ;;The predicate clear is used to check if the moveToNextTile is clear
                        (clear ?moveToNextTile)
                        ;; This precondition uses the predicate cleaned,this  is used to check if the moveToNextTile is not cleaned
                        (not(cleaned ?moveToNextTile))
                       )
         ;;Effects of the action right
         :effect (and 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is not on its old tile position
                  (not(robot-at ?robot ?robotTile)) 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is on the moveToNextTile
                  (robot-at ?robot ?moveToNextTile)
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot is on the moveToNextTile and so it is not clear
                  (not(clear ?moveToNextTile)) 
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot's old tile position is now clear
                  ( clear ?robotTile)
                 )  
  )
  
  ;; left action
  (:action left
         ;; left action takes a robot object called robot and it takes two tile objects called moveToNextTile and robotTile
         :parameters(?robot - robot ?robotTile - tile ?moveToNextTile - tile)
         ;; Preconditions for the action left
         :precondition (and 
                     	 ;; The left action uses the predicate called robot-at to check a robot is on a tile
                        (robot-at ?robot ?robotTile)
                       	;; The predicate called left is used to check if the moveToNextTile is below the tile that the robot is on 
                        (left ?moveToNextTile ?robotTile)
                        ;;The predicate clear is used to check if the moveToNextTile is clear
                        (clear ?moveToNextTile)
                        ;; This precondition uses the predicate cleaned,this  is used to check if the moveToNextTile is not cleaned
                        (not(cleaned ?moveToNextTile))
                       )
         ;;Effects of the action left
         :effect (and 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is not on its old tile position
                  (not(robot-at ?robot ?robotTile)) 
                  ;; As the robot has moved it would need to used the robot-at predicate to say that the robot is on the moveToNextTile
                  (robot-at ?robot ?moveToNextTile)
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot is on the moveToNextTile and so it is not clear
                  (not(clear ?moveToNextTile)) 
                  ;; As the robot has moved it would need to used the clear predicate to say that the robot's old tile position is now clear
                  ( clear ?robotTile)
                 )  
  )
)

  


