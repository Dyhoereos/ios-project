//
//  Player.swift
//  ios-project
//
//  Created by Tianyang Liu on 10/17/16.
//  Copyright © 2016 Manjot. All rights reserved.
//

import Foundation
import CoreLocation
public class Player {
    
    var playerName : String
    var level      : Int
    var skill      : Skill
    var locationManager = CLLocationManager()
    
    public init( _ n : String){
        self.playerName = n
        self.level = 1
        self.skill = ZoomGrid(skillID: 1,skillName: "ZoomGrid")
    }
    
    
    public init( _ n : String, _ l : Int){
        self.playerName = n
        self.level = l
        self.skill = ZoomGrid(skillID: 1,skillName: "ZoomGrid")
    }
    
    public func levelUp() -> String {
        if (level < 99){
            level += 1
            return LevelUp(skill: self.skill).chkLevel()
        }
        return "Player is max level"
    }
    

}
