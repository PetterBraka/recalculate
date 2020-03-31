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
    @IBOutlet weak var scrollView: UIScrollView!
    
    ///predefined **Array** with the different units that will be used for weights.
    var weightUnits = [ UnitMass.kilograms, UnitMass.stones, UnitMass.pounds, UnitMass.ounces ]
    ///predefined **Array** with the different units that will be used for lengths.
    var lengthUnits = [ UnitLength.meters, UnitLength.inches, UnitLength.feet, UnitLength.yards ]
    ///predefined **Array** with the different units that will be used for liquids.
    var liquidUnits = [ UnitVolume.liters, UnitVolume.imperialFluidOunces, UnitVolume.imperialPints ]

    var optionalUnits = [AnyObject]()
    
    
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
     - returns:
     - warning:
     
     */
    @objc func weightTap(_ sender: UIGestureRecognizer){
        buttonPressed = "weight"
        createInfoView(weightUnits)
    }
    
    /**
     This function will be called when the weight button gets pressed for a longer time.
     
     - parameter sender: **UIGestureRecognizer**
     - returns:
     - warning:
     
     */
    @objc func weightLong(_ sender: UIGestureRecognizer){
        buttonPressed = "weight"
        if sender.state == .began{
            createOptionView(weightUnits)
        }
    }
    
    /**
     This function will be called when the button named length gets tapped.
     
     - parameter sender: **UIGestureRecognizer**
     - returns:
     - warning:
     
     */
    @objc func lengthTap(_ sender: UIGestureRecognizer){
        buttonPressed = "length"
        createInfoView(lengthUnits)
    }
    
    /**
     This function will be called when the length button gets pressed for a longer time.
     
     - parameter sender: **UIGestureRecognizer**
     - returns:
     - warning:
     
     */
    @objc func lengthLong(_ sender: UIGestureRecognizer){
        buttonPressed = "length"
        if sender.state == .began{
            createOptionView(lengthUnits)
        }
    }
    
    /**
     This function will be called when the button named liquid gets tapped.
     
     - parameter sender: **UIGestureRecognizer**
     - returns:
     - warning:
     
     */
    @objc func liquidTap(_ sender: UIGestureRecognizer){
        buttonPressed = "liquid"
        createInfoView(liquidUnits)
    }
    
    /**
     This function will be called when the liquid button gets pressed for a longer time.
     
     - parameter sender: **UIGestureRecognizer**
     - returns:
     - warning:
     
     */
    @objc func liquidLong(_ sender: UIGestureRecognizer){
        buttonPressed = "liquid"
        if sender.state == .began{
            createOptionView(liquidUnits)
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
    This funciton will create infoCards containing a UISwitch and a label. The UISwitch is were the user can turn a unit of or on. The label will show the prefix beside the UISwitch.
    
    - parameter units: An **Array** of **AnyObject** with the units that the user tapped on.
    - returns: null
    - warning:
    
    # Notes: #
    1. Parameters must be an **Array** containg **UnitMass**, **UnitLength** or **UnitVolume** of the units you want to create a optionCard for
    
    # Example #
    ```
    createInfoView(units)
    ```
    */
    func createOptionView(_ usersUnits: [AnyObject]) {
        for view in infoStack.subviews {
            //cleans the infoStack to make it ready for the new units.
            view.removeFromSuperview()
        }
        switch buttonPressed {
        case "weight":
            optionalUnits = [ UnitMass.grams, UnitMass.kilograms, UnitMass.metricTons, UnitMass.stones, UnitMass.pounds, UnitMass.ounces ]
        case "length":
            optionalUnits = [ UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers, UnitLength.yards, UnitLength.feet, UnitLength.inches, UnitLength.miles ]
        case "liquid":
            optionalUnits = [ UnitVolume.milliliters, UnitVolume.liters, UnitVolume.imperialGallons, UnitVolume.imperialPints, UnitVolume.imperialFluidOunces, UnitVolume.imperialTeaspoons, UnitVolume.imperialTablespoons ]
        default:
            break
        }
        var unitTag = 0
        for unitOption in optionalUnits {
            let newOptionCard = Card.init()
            newOptionCard.makeOptionCard(unitOption, usersUnits, unitTag)
            newOptionCard.switchOption.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            infoStack.addArrangedSubview(newOptionCard.infoCard)
            unitTag += 1
        }
        scrollView.contentSize = infoStack.frame.size
    }
    
    @objc func switchChanged(mySwitch: UISwitch){
        switch mySwitch.isOn {
        case true:
            switch buttonPressed {
            case "weight":
                weightUnits.append(optionalUnits[mySwitch.tag] as! UnitMass)
                
                // Create a dictionary to map UnitMass to Int position
                var position = [UnitMass : Int]()
                for (unitIndex, unit) in optionalUnits.enumerated() {
                    position[unit as! UnitMass] = unitIndex
                }
                // Sort the array by position.  Use Int.max if the UnitMass has no
                // position to sort it to the end of the array
                weightUnits = weightUnits.sorted { position[$0, default: Int.max] < position[$1, default: Int.max] }
                
            case "length":
                lengthUnits.append(optionalUnits[mySwitch.tag] as! UnitLength)
                // Create a dictionary to map UnitMass to Int position
                var position = [UnitLength : Int]()
                for (unitIndex, unit) in optionalUnits.enumerated() {
                    position[unit as! UnitLength] = unitIndex
                }
                // Sort the array by position.  Use Int.max if the UnitMass has no
                // position to sort it to the end of the array
                lengthUnits = lengthUnits.sorted { position[$0, default: Int.max] < position[$1, default: Int.max] }
            case "liquid":
                liquidUnits.append(optionalUnits[mySwitch.tag] as! UnitVolume)
                // Create a dictionary to map UnitMass to Int position
                var position = [UnitVolume : Int]()
                for (unitIndex, unit) in optionalUnits.enumerated() {
                    position[unit as! UnitVolume] = unitIndex
                }
                // Sort the array by position.  Use Int.max if the UnitMass has no
                // position to sort it to the end of the array
                liquidUnits = liquidUnits.sorted { position[$0, default: Int.max] < position[$1, default: Int.max] }
            default:
                break
            }
        case false:
            switch buttonPressed {
            case "weight":
                var options = optionalUnits as! [UnitMass]
                weightUnits.remove(at: weightUnits.firstIndex(of: options.remove(at: mySwitch.tag))!)
                case "length":
                    var options = optionalUnits as! [UnitLength]
                    lengthUnits.remove(at: lengthUnits.firstIndex(of: options.remove(at: mySwitch.tag))!)
                case "liquid":
                    var options = optionalUnits as! [UnitVolume]
                    liquidUnits.remove(at: liquidUnits.firstIndex(of: options.remove(at: mySwitch.tag))!)
            default:
                break
            }
        }
    }
    
    
    /**
     This funciton will create infoCards containing a textField and a label. The textField is were the user will enter a value. The label will show the prefix beside the textField.
     
     - parameter units: An **Array** of **Strings** with the units.
     - returns: null
     - warning:
     
     # Notes: #
     1. Parameters must be an **Array** containg **strings** of the units you want to create a infocard for
     
     # Example #
     ```
     createInfoView(units)
     ```
     */
    func createInfoView(_ units: [Any]) {
        for view in infoStack.subviews {
            //cleans the infoStack to make it ready for the new units.
            view.removeFromSuperview()
        }
        for unit in units {
            let newInfoCard = Card.init()
            if unit is UnitMass {
                let prefix = unit as? UnitMass
                let unitArray = units as? [UnitMass]
                newInfoCard.makeInfoCard((prefix?.symbol)!, unitArray!.firstIndex(of: unit as! UnitMass)!)
            }
            if unit is UnitLength {
                let prefix = unit as? UnitLength
                let unitArray = units as? [UnitLength]
                newInfoCard.makeInfoCard((prefix?.symbol)!, unitArray!.firstIndex(of: unit as! UnitLength)!)
            }
            if unit is UnitVolume {
                let prefix = unit as? UnitVolume
                let unitArray = units as? [UnitVolume]
                newInfoCard.makeInfoCard((prefix?.symbol)!, unitArray!.firstIndex(of: unit as! UnitVolume)!)
            }
            newInfoCard.textField.delegate = self
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            let flexibleSpaced = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
            toolBar.setItems([flexibleSpaced, doneButton], animated: false)
            newInfoCard.textField.inputAccessoryView = toolBar
            infoStack.addArrangedSubview(newInfoCard.infoCard)
        }
        scrollView.contentSize = infoStack.frame.size
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
            let mass = Measurement(value: value, unit: weightUnits[inputUnitIndex])
            convertedValue = mass.converted(to: weightUnits[outputUnitIndex]).value
        case "length":
            let length = Measurement(value: value, unit: lengthUnits[inputUnitIndex])
            convertedValue = length.converted(to: lengthUnits[outputUnitIndex]).value
        case "liquid":
            let liquid = Measurement(value: value, unit: liquidUnits[inputUnitIndex])
            convertedValue = liquid.converted(to: liquidUnits[outputUnitIndex]).value
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
