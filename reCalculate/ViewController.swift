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

    var buttonPressed = String()
    @IBOutlet weak var liquid: UIButton!
    @IBOutlet weak var length: UIButton!
    @IBOutlet weak var weight: UIButton!
    @IBOutlet weak var infoStack: UIStackView!
    //This function will be called when the weight button gets pressed.
    
    @IBAction func pressedWeight(_ sender: Any) {
        let units = ["Kg", "oz", "lb"]
        buttonPressed = "weight"
        createInfoView(units)
    }
    //This function will be called when the height button gets pressed.
    @IBAction func pressedLength(_ sender: Any) {
        let units = ["m", "in", "ft", "yd", "mi"]
        buttonPressed = "length"
        createInfoView(units)
    }
    //This function will be called when the liquid button gets pressed.
    @IBAction func pressedLiquid(_ sender: Any) {
        let units = ["l", "ml", "fl. oz", "pt"]
        buttonPressed = "liquid"
        createInfoView(units)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //This method cleans all the textFields when someone clicks on one of them.
        for stack in infoStack.subviews{
            for view in stack.subviews {
                if view is UITextField, let input = view as? UITextField {
                    input.text = ""
                }
            }
        }
        return true
    }
    
    func handleInput(_ input: UITextField) {
        for stack in infoStack.subviews {
            for view in stack.subviews {
                if view is UITextField, let textField = view as? UITextField{
                    switch buttonPressed {
                    case "weight":
                        weightMath(input, textField)
                    case "length":
                        lengthMath(input, textField)
                    case "liquid":
                        liquidMath(input, textField)
                    default:
                        break
                    }
                }
            }
        }
    }
    func toFloat(_ value: String) -> Float{
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // USA: Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        let number = formatter.number(from: value)
        if number == nil {
            return 0
        }
        return number as! Float
    }
    
    fileprivate func createInfoView(_ units: [String]) {
        //This method will take a string array and make an input box for the user and show the unit its for beside it.
        for view in infoStack.subviews {
            view.removeFromSuperview()
        }
        for unit in units {
            let infoCard = UIStackView()
            infoCard.axis = .horizontal
            infoCard.alignment = .trailing
            infoCard.distribution = .fill
            
            let userInput = UITextField(frame : CGRect(x: 0, y: 0, width: 200, height: 40))
            userInput.attributedPlaceholder = NSAttributedString(string: "0.000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            userInput.textColor = UIColor.white
            userInput.textAlignment = .right
            userInput.tag = units.firstIndex(of: unit)!
            userInput.font = UIFont(name: "American Typewriter", size: 20)
            userInput.borderStyle = UITextField.BorderStyle.roundedRect
            userInput.keyboardType = UIKeyboardType.numbersAndPunctuation
            userInput.returnKeyType = UIReturnKeyType.done
            userInput.backgroundColor = UIColor.darkGray
            userInput.delegate = self
            infoCard.addArrangedSubview(userInput)
            
            let label = UILabel(frame: CGRect.zero)
            label.text = " " + unit
            label.textColor = .white
            label.font = UIFont(name: "American Typewriter", size: 20)
            label.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60))
            infoCard.addArrangedSubview(label)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleInput(textField)
        return true
    }
    deinit {
        //Stopps listening for the keyboard to changes.
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillChangeFrameNotification)
    }
    
    
    func weightMath(_ input: UITextField, _ textField: UITextField) {
        //The math for doing weight calculations. This will also round up the answer to the third decimal.
        switch input.tag {
            /*
             case 0 is for when the user want to calculate from kilogram
             case 1 is for when the user want to calculate from ounces
             case 2 is for when the user want to calculate from pounds
             */
        case 0:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to kilogram
                case 1 is for when the user want to calculate to ounces
                case 2 is for when the user want to calculate to pounds
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 35.274)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 2.205)
            default:
                break
            }
        case 1:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to kilogram
                case 1 is for when the user want to calculate to ounces
                case 2 is for when the user want to calculate to pounds
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 0.028)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 0.063)
            default:
                break
            }
        case 2:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to kilogram
                case 1 is for when the user want to calculate to ounces
                case 2 is for when the user want to calculate to pounds
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 0.454)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 16)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            default:
                break
            }
        default:
            break
        }
    }
    
    func lengthMath(_ input: UITextField, _ textField: UITextField) {
        //The math for doing length calculations. This will also round up the answer to the third decimal.
        switch input.tag {
            /*
             case 0 is for when the user want to calculate from meters
             case 1 is for when the user want to calculate from inchest
             case 2 is for when the user want to calculate from feets
             case 3 is for when the user want to calculate from yards
             case 4 is for when the user want to calculate from miles
             */
        case 0:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to meters
                case 1 is for when the user want to calculate to inchest
                case 2 is for when the user want to calculate to feets
                case 3 is for when the user want to calculate to yards
                case 4 is for when the user want to calculate to miles
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 39.37)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 3.281)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1.094)
            case 4:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 1609)
            default:
                break
            }
        case 1:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to meters
                case 1 is for when the user want to calculate to inchest
                case 2 is for when the user want to calculate to feets
                case 3 is for when the user want to calculate to yards
                case 4 is for when the user want to calculate to miles
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 39.37)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 12)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 36)
            case 4:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 63360)
            default:
                break
            }
        case 2:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to meters
                case 1 is for when the user want to calculate to inchest
                case 2 is for when the user want to calculate to feets
                case 3 is for when the user want to calculate to yards
                case 4 is for when the user want to calculate to miles
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 3.281)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 12)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 3)
            case 4:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 5280)
            default:
                break
            }
        case 3:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to meters
                case 1 is for when the user want to calculate to inchest
                case 2 is for when the user want to calculate to feets
                case 3 is for when the user want to calculate to yards
                case 4 is for when the user want to calculate to miles
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 1.094)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 36)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 3)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 4:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 1760)
            default:
                break
            }
        case 4:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to meters
                case 1 is for when the user want to calculate to inchest
                case 2 is for when the user want to calculate to feets
                case 3 is for when the user want to calculate to yards
                case 4 is for when the user want to calculate to miles
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1609)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 63360)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 5280)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1760)
            case 4:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            default:
                break
            }
        default:
            break
        }
    }
    func liquidMath(_ input: UITextField, _ textField: UITextField) {
        //The math for doing weight calculations. This will also round up the answer to the third decimal.
        switch input.tag {
            /*
             case 0 is for when the user want to calculate from litres
             case 1 is for when the user want to calculate from milliliters
             case 2 is for when the user want to calculate from pints
             case 3 is for when the user want to calculate from fluid ounces
             */
        case 0:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to liters
                case 1 is for when the user want to calculate to milliliters
                case 2 is for when the user want to calculate to pints
                case 3 is for when the user want to calculate to fluid ounces
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1000)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1.76)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 35.195)
            default:
                break
            }
        case 1:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to liters
                case 1 is for when the user want to calculate to milliliters
                case 2 is for when the user want to calculate to pints
                case 3 is for when the user want to calculate to fluid ounces
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 1000)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 568)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 28.413)
            default:
                break
            }
        case 2:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to liters
                case 1 is for when the user want to calculate to milliliters
                case 2 is for when the user want to calculate to pints
                case 3 is for when the user want to calculate to fluid ounces
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 1.76)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 568)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 20)
            default:
                break
            }
        case 3:
            switch textField.tag {
                /*
                case 0 is for when the user want to calculate to liters
                case 1 is for when the user want to calculate to milliliters
                case 2 is for when the user want to calculate to pints
                case 3 is for when the user want to calculate to fluid ounces
                */
            case 0:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 35.195)
            case 1:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 28.413)
            case 2:
                textField.text = String(format: "%.3f", toFloat(input.text!) / 20)
            case 3:
                textField.text = String(format: "%.3f", toFloat(input.text!) * 1)
            default:
                break
            }
        default:
            break
        }
    }
}

