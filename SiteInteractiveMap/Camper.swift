//
//  Camper.swift
//  SiteInteractiveMap
//
//  Created by Derek Scott
//  Copyright © 2019 Derek Scott. All rights reserved.
//

import UIKit

let firstNameArray = ["Abe", "Abigail", "Bruce", "Betty", "Chance", "Clarissa"]
let lastNameArray = ["Smith", "Scott", "Hunter", "Ewen", "Springtsteen", "Armstrong"]


class Camper {
    var name: String = ""
    var phone: Int = 0
    var description: String = ""
    
    func generateName() -> String {
        return "\(firstNameArray.randomElement()!) \(lastNameArray.randomElement()!)"
    }
}
