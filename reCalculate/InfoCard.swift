//
//  InfoCard.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 27/03/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import UIKit

class InfoCard: NSObject {
    var textField: UITextField
    var prefixLable: UILabel
    var infoCard: UIStackView
    var option: UISwitch
    
    override init() {
        self.textField = UITextField()
        self.prefixLable = UILabel()
        self.infoCard = UIStackView()
        self.option = UISwitch()
    }
    
    func makeInfoCard(_ unit: String, _ unitIndex: Int){
        self.infoCard.axis = .horizontal
        self.infoCard.alignment = .trailing
        self.infoCard.distribution = .fill
        
        self.textField = UITextField(frame : CGRect(x: 0, y: 0, width: 200, height: 40))
        self.textField.attributedPlaceholder = NSAttributedString(string: "0.000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.textField.textColor = UIColor.white
        self.textField.textAlignment = .right
        self.textField.tag = unitIndex
        self.textField.font = UIFont(name: "American Typewriter", size: 20)
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.keyboardType = UIKeyboardType.decimalPad
        self.textField.returnKeyType = UIReturnKeyType.done
        self.textField.backgroundColor = UIColor.darkGray
        infoCard.addArrangedSubview(textField)
        
        let label = UILabel(frame: CGRect.zero)
        label.text = " " + unit
        label.textColor = .white
        label.font = UIFont(name: "American Typewriter", size: 20)
        label.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60))
        infoCard.addArrangedSubview(label)
    }
    
    func makeOptionCard(_ unit: Any, _ usersUnits: [AnyObject]){
        var unitOption = unit
        var chosenUnits = usersUnits
        if unit is UnitMass{
            unitOption = unit as! UnitMass
            chosenUnits = usersUnits as! [UnitMass]
        } else if unit is UnitLength {
            unitOption = unit as! UnitLength
            chosenUnits = usersUnits as! [UnitLength]
        } else if unit is UnitVolume{
            unitOption = unit as! UnitVolume
            chosenUnits = usersUnits as! [UnitVolume]
        }
        self.infoCard = UIStackView()
        self.infoCard.axis = .horizontal
        self.infoCard.alignment = .trailing
        self.infoCard.distribution = .fill
        
        self.option = UISwitch()
        for usersUnit in chosenUnits {
            if (unitOption as AnyObject).isEqual(usersUnit){
                self.option.setOn(true, animated: false)
                break
            } else {
                self.option.setOn(false, animated: false)
            }
        }
        self.infoCard.addArrangedSubview(self.option)
        self.prefixLable.text = " " + (unitOption as AnyObject).symbol
        self.prefixLable.textColor = .white
        self.prefixLable.font = UIFont(name: "American Typewriter", size: 20)
        self.prefixLable.addConstraint(NSLayoutConstraint(item: self.prefixLable, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60))
        self.infoCard.addArrangedSubview(self.prefixLable)
        return
    }
}
