//
//  ViewController.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 22/03/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var liquid: UIButton!
    @IBOutlet weak var length: UIButton!
    @IBOutlet weak var weight: UIButton!
    @IBOutlet weak var infoStack: UIStackView!
    //This function will be called when the weight button gets pressed.
    
    @IBAction func pressedWeight(_ sender: Any) {
        let units = ["Kg", "oz", "lb"]
        createInfoView(units)
    }
    //This function will be called when the height button gets pressed.
    @IBAction func pressedHeight(_ sender: Any) {
        let units = ["m", "cm", "ft", "yd", "mi", "in"]
        createInfoView(units)
    }
    //This function will be called when the liquid button gets pressed.
    @IBAction func pressedLiquid(_ sender: Any) {
        let units = ["l", "ml", "fl. oz", "pt"]
        createInfoView(units)
    }
    
    fileprivate func createInfoView(_ units: [String]) {
        //This method will take a string array and make an input box for the user and show the unit its for beside it.
        for view in infoStack.subviews {
            view.removeFromSuperview()
        }
        for unit in units {
            let infoCard = UIStackView()
            infoCard.axis = .horizontal
            infoCard.alignment = .fill
            infoCard.distribution = .fill
            
            let userInput = UITextField(frame : CGRect(x: 0, y: 0, width: 200, height: 40))
            userInput.attributedPlaceholder = NSAttributedString(string: "0000.00", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            userInput.textColor = UIColor.white
            userInput.font = UIFont(name: "American Typewriter", size: 20)
            userInput.borderStyle = UITextField.BorderStyle.roundedRect
            userInput.keyboardType = UIKeyboardType.numbersAndPunctuation
            userInput.returnKeyType = UIReturnKeyType.done
            userInput.backgroundColor = UIColor.darkGray
            userInput.delegate = self
            infoCard.addArrangedSubview(userInput)
            
            let lable = UILabel(frame: CGRect.zero)
            lable.text = " " + unit
            lable.textColor = .white
            lable.font = UIFont(name: "American Typewriter", size: 20)
            infoCard.addArrangedSubview(lable)
            infoStack.addArrangedSubview(infoCard)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting upp each button to look like a rounded button with an gray outline.
        liquid.backgroundColor = .clear
        liquid.layer.cornerRadius = 20
        liquid.layer.borderWidth = 3
        liquid.layer.borderColor = UIColor.darkGray.cgColor
        length.backgroundColor = .clear
        length.layer.cornerRadius = 20
        length.layer.borderWidth = 3
        length.layer.borderColor = UIColor.darkGray.cgColor
        weight.backgroundColor = .clear
        weight.layer.cornerRadius = 20
        weight.layer.borderWidth = 3
        weight.layer.borderColor = UIColor.darkGray.cgColor

        //Starts to listen for the keyboard to changes.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        }

    
    @objc func keyboardWillChange(notification: Notification){
        //gets the hight of the keyboard and moves the UI upp so that you can se whats happening and notting is coverd by the keyboard.
        guard let kbHight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification{
            view.frame.origin.y = -kbHight
        } else {
            view.frame.origin.y = 0
        }
    }
    
}

