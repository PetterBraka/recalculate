//
//  InfoCard.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 26/03/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import UIKit

class InfoCard: NSObject, UITextFieldDelegate {
    var buttonPressed: String
    var textField: UITextField
    var infoStack: UIStackView
    var prefix: UILabel
    
    override init(){
        self.buttonPressed = String()
        self.textField = UITextField()
        self.infoStack = UIStackView()
        self.prefix = UILabel()
    }
    
    func createCard(_ unit: String, _ unitIndex: Int) -> UIStackView{
        infoStack.axis = .horizontal
        infoStack.alignment = .trailing
        infoStack.distribution = .fill
        
        textField = UITextField(frame : CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.attributedPlaceholder = NSAttributedString(string: "0.000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = UIColor.white
        textField.textAlignment = .right
        textField.tag = unitIndex
        textField.font = UIFont(name: "American Typewriter", size: 20)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = UIColor.darkGray
        textField.delegate = self
        infoStack.addArrangedSubview(textField)
        
        prefix = UILabel(frame: CGRect.zero)
        prefix.text = " " + unit
        prefix.textColor = .white
        prefix.font = UIFont(name: "American Typewriter", size: 20)
        prefix.addConstraint(NSLayoutConstraint(item: prefix, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60))
        infoStack.addArrangedSubview(prefix)
        return infoStack
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleInput(textField)
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
    func updatedButtonPressed(_ buttonPressed: String){
        self.buttonPressed = buttonPressed
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
