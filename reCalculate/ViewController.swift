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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting upp each button to look like a rounded button with an gray outline.
        weight.backgroundColor = .clear
        weight.layer.cornerRadius = 20
        weight.layer.borderWidth = 3
        weight.layer.borderColor = UIColor.darkGray.cgColor
        //This part of the code sets up a listener for a tap or a long tapp
        let weigthTapGesture = UITapGestureRecognizer(target: self, action: #selector(weightTap))
        weight.addGestureRecognizer(weigthTapGesture)
        let weightLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(weightLong))
        weightLongGesture.minimumPressDuration = 1
        weight.addGestureRecognizer(weightLongGesture)
        
        //Setting upp each button to look like a rounded button with an gray outline.
        length.backgroundColor = .clear
        length.layer.cornerRadius = 20
        length.layer.borderWidth = 3
        length.layer.borderColor = UIColor.darkGray.cgColor
        //This part of the code sets up a listener for a tap or a long tapp
        let lengthTapGesture = UITapGestureRecognizer(target: self, action: #selector(lengthTap))
        length.addGestureRecognizer(lengthTapGesture)
        let lengthLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(lengthLong))
        lengthLongGesture.minimumPressDuration = 1
        length.addGestureRecognizer(lengthLongGesture)
        
        //Setting upp each button to look like a rounded button with an gray outline.
        liquid.backgroundColor = .clear
        liquid.layer.cornerRadius = 20
        liquid.layer.borderWidth = 3
        liquid.layer.borderColor = UIColor.darkGray.cgColor
        //This part of the code sets up a listener for a tap or a long tapp
        let liquidTapGesture = UITapGestureRecognizer(target: self, action: #selector(liquidTap))
        liquid.addGestureRecognizer(liquidTapGesture)
        let liquidLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(liquidLong))
        liquidLongGesture.minimumPressDuration = 1
        liquid.addGestureRecognizer(liquidLongGesture)
        
        //Starts to listen for the keyboard to changes.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    /**
     This function will be called when the button named weight gets tapped.
     
     - parameter sender: **UIGestureRecognizer**
     - returns: **nil**
     - warning:
     
     */
    @objc func weightTap(_ sender: UIGestureRecognizer){
        buttonPressed = "weight"
        let units = ["kg", "st", "lb", "oz"]
        createInfoView(units)
    }
    
    /**
    This function will be called when the weight button gets pressed for a longer time.
    
    - parameter sender: **UIGestureRecognizer**
    - returns: **nil**
    - warning:
    
    */
    @objc func weightLong(_ sender: UIGestureRecognizer){
        if sender.state == .began{
            print("Long tap")
        }
    }
    
    /**
    This function will be called when the button named length gets tapped.
    
    - parameter sender: **UIGestureRecognizer**
    - returns: **nil**
    - warning:
    
    */
    @objc func lengthTap(_ sender: UIGestureRecognizer){
        let units = ["m", "in", "ft", "yd", "mi"]
        buttonPressed = "length"
        createInfoView(units)
    }
    
    /**
    This function will be called when the length button gets pressed for a longer time.
    
    - parameter sender: **UIGestureRecognizer**
    - returns: **nil**
    - warning:
    
    */
    @objc func lengthLong(_ sender: UIGestureRecognizer){
        if sender.state == .began{
            print("Long tap")
        }
    }
    
    /**
    This function will be called when the button named liquid gets tapped.
    
    - parameter sender: **UIGestureRecognizer**
    - returns: **nil**
    - warning:
    
    */
    @objc func liquidTap(_ sender: UIGestureRecognizer){
        let units = ["l", "ml", "fl. oz", "pt"]
        buttonPressed = "liquid"
        createInfoView(units)
    }
    
    /**
    This function will be called when the liquid button gets pressed for a longer time.
    
    - parameter sender: **UIGestureRecognizer**
    - returns: **nil**
    - warning:
    
    */
    @objc func liquidLong(_ sender: UIGestureRecognizer){
        if sender.state == .began{
            print("Long tap")
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        for stack in infoStack.subviews{
            for view in stack.subviews {
                if view is UITextField, let input = view as? UITextField {
                    input.text = ""
                }
            }
        }
        return true
    }
    
    /**
     This funciton will create infoCards containing a textField and a label. The textField is were the user will enter a value. The label will show the prefix beside the textField.
     
     - parameter units: An array of strings with the units.
     - returns: null
     - warning:
     
     # Notes: #
     1. Parameters must be an **Array** containg **strings** of the units you want to create a infocard for
     
     # Example #
     ```
     createInfoView(units)
     ```
     */
    fileprivate func createInfoView(_ units: [String]) {
        for view in infoStack.subviews {
            //cleans the infoStack to make it ready for the new units.
            view.removeFromSuperview()
        }
        for unit in units {
            let newInfoCard = InfoCard.init()
            newInfoCard.creatInfoCard(unit, units.firstIndex(of: unit)!)
            newInfoCard.textField.delegate = self
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let flexibleSpaced = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
            toolBar.setItems([flexibleSpaced, doneButton], animated: false)
            newInfoCard.textField.inputAccessoryView = toolBar
            infoStack.addArrangedSubview(newInfoCard.infoCard)
        }
    }
    
    /**
     This function will be called if the user press the done button and are finiched entering a value.
     
     # Notes: #
     it will call for handleInput and this will check for any updates in any of the text feilds.
     */
    @objc func doneClicked(){
        view.endEditing(true)
        handleInput(searchForUpdates())
    }

    /**
    This function will get the hight of the keyboard and move the UI upp so that the keyboard is not covering anything, and it will move the UI down when the keyboard moves down.
    
    - parameter notification: will catch any notification happening.
    - returns: **nil**
    - warning:
    
    */
    @objc func keyboardWillChange(notification: Notification){
        guard let kbHight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification{
            view.frame.origin.y = -kbHight
        } else {
            view.frame.origin.y = 0
        }
    }
    
    /**
     This will chack for changes in the UITextFields and call for an updating of  the other UITextFields.
     
     - parameter input: A UITextField were the user inputs some values.
     - returns: **nil**
     - warning:
     
     # Notes: #
     1.  Parameters input must be an **UITextField**
     
     # Example #
     ```
     handleInput(input)
     ```
     */
    func handleInput(_ input: UITextField) {
        for stack in infoStack.subviews {
            for view in stack.subviews {
                if view is UITextField, let output = view as? UITextField{
                    updateUI(input, output)
                }
            }
        }
    }
    
    /**
     This function will go through each one of the infocards in the infoStack. it will not stopp before it finds a textfield that has something writen in it.
     
     - returns: **searching** it contains the UITextField that has been edited.
     
     # Example #
     ```
     textField = searchForUpdates()
     ```
     */
    func searchForUpdates() -> UITextField {
        for infocard in infoStack.subviews {
            for view in infocard.subviews {
                if view is UITextField, let searching = view as? UITextField {
                    if searching.text != "" {
                        return searching
                    }
                }
            }
        }
        return UITextField.init()
    }
    
    /**
     This function will update all the **UITextField**s
     
     - parameter input: The **UITextField** that gets the input form the user.
     - parameter output: The output **UITextField** .
     - returns: **nil**
     - warning:
     
     # Example #
     ```
     updateUI(input, output)
     ```
     */
    func updateUI(_ input: UITextField, _ output: UITextField) {
        guard let inputString = input.text, let inputValue = Double(inputString) else {
            return
        }
        let convertedValue = convert( inputValue, input.tag, output.tag )
        output.text = String(format: "%.3f", convertedValue)
    }
    
    /**
     This function will convert a unit  to another unit depending on what type off unit type it is.
     
     - parameter value: a **Double** that will be converted.
     - parameter inputUintIndex: an **Integer** that tells whitch unit to covert from
     - parameter outputUnitIndex: an **Integer** that tells whitch unit to covert too
     - returns: a **Double** the value coverted
     
     # Notes: #
     1. paremeter value needs too be of type **Double**
     2. paremeter inputUnitTag needs too be of type **Integer**
     3. paremeter outputUnitTag needs too be of type **Integer**
     
     # Example #
     ```
     outputValue = convert(inputValue, inputUnitTag, outputUnitTag)
     ```
     */
    private func convert(_ value: Double, _ inputUnitIndex: Int, _ outputUnitIndex: Int) -> Double {
        //The mass unit will be picked by the index of the textfield were the user edited
        var convertedValue = Double()
        switch buttonPressed {
        case "weight":
            let unitLookupTable = [ UnitMass.kilograms, UnitMass.stones, UnitMass.pounds, UnitMass.ounces ]
            let mass = Measurement(value: value, unit: unitLookupTable[inputUnitIndex])
            convertedValue = mass.converted(to: unitLookupTable[outputUnitIndex]).value
        case "length":
            let unitLookupTable = [ UnitLength.meters, UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles ]
            let length = Measurement(value: value, unit: unitLookupTable[inputUnitIndex])
            convertedValue = length.converted(to: unitLookupTable[outputUnitIndex]).value
        case "liquid":
            let unitLookupTable = [ UnitVolume.liters, UnitVolume.milliliters, UnitVolume.fluidOunces, UnitVolume.pints ]
            let liquid = Measurement(value: value, unit: unitLookupTable[inputUnitIndex])
            convertedValue = liquid.converted(to: unitLookupTable[outputUnitIndex]).value
        default:
            break
        }
        return convertedValue
    }
    
    deinit {
        //Stopps listening for the keyboard to changes.
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillChangeFrameNotification)
    }
}

