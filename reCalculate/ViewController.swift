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
        let units = ["kg", "st", "lb", "oz"]
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
                    updateUI(input, textField)
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
    
    func updateUI(_ input: UITextField, _ textField: UITextField) {
        guard let inputString = input.text, let inputValue = Double(inputString) else {
            return
        }
        let convertedValue = convert(mass: inputValue, inputUnitIndex: input.tag, outputUnitIndex: textField.tag)
        textField.text = String(format: "%.3f", convertedValue)
    }
    private func convert(mass: Double, inputUnitIndex: Int, outputUnitIndex: Int) -> Double {
        //The mass unit will be picked by the index of the textfield were the user edited
        var convertedValue = Double()
        switch buttonPressed {
        case "weight":
            let unitLookupTable = [ UnitMass.kilograms, UnitMass.stones, UnitMass.pounds, UnitMass.ounces ]
            let mass = Measurement(value: mass, unit: unitLookupTable[inputUnitIndex])
            convertedValue = mass.converted(to: unitLookupTable[outputUnitIndex]).value
        case "length":
            let unitLookupTable = [ UnitLength.meters, UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles ]
            let length = Measurement(value: mass, unit: unitLookupTable[inputUnitIndex])
            convertedValue = length.converted(to: unitLookupTable[outputUnitIndex]).value
        case "liquid":
            let unitLookupTable = [ UnitVolume.liters, UnitVolume.milliliters, UnitVolume.fluidOunces, UnitVolume.pints ]
            let liquid = Measurement(value: mass, unit: unitLookupTable[inputUnitIndex])
            convertedValue = liquid.converted(to: unitLookupTable[outputUnitIndex]).value
        default:
            break
        }
        return convertedValue
    }
    
}

