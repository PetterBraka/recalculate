//
//  ViewController.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 22/03/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var liquid: UIButton!
    @IBOutlet weak var height: UIButton!
    @IBOutlet weak var weight: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting upp each button to look like a rounded button with an gray outline.
        liquid.backgroundColor = .clear
        liquid.layer.cornerRadius = 20
        liquid.layer.borderWidth = 3
        liquid.layer.borderColor = UIColor.darkGray.cgColor
        height.backgroundColor = .clear
        height.layer.cornerRadius = 20
        height.layer.borderWidth = 3
        height.layer.borderColor = UIColor.darkGray.cgColor
        weight.backgroundColor = .clear
        weight.layer.cornerRadius = 20
        weight.layer.borderWidth = 3
        weight.layer.borderColor = UIColor.darkGray.cgColor
       
    }


}

