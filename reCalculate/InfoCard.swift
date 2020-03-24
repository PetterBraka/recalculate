//
//  InfoCard.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 24/03/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import Foundation
import UIKit

class InfoCard {
    var userInput : UITextField
    var prefix : String
    
    init(userInput: UITextField, prefix : String) {
        self.userInput = userInput
        self.prefix = prefix
    }
}
