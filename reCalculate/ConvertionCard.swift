//
//  ConvertionCard.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 19/11/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import UIKit

class ConvertionCard: UITableViewCell {
    var prefix = UILabel()
    var textField = UITextField()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        createCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCell(){
        addAllSubviews()
    }
    
    func addAllSubviews(){
        prefix.font = UIFont(name: "American Typewriter", size: 20)
        prefix.textColor = .white
        prefix.text = ""
        prefix.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont(name: "American Typewriter", size: 20)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = UIColor.darkGray
        textField.attributedPlaceholder = NSAttributedString(string: "0.000", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(prefix)
        self.addSubview(textField)
        
        setConstraints()
    }
    
    func setConstraints(){
        prefix.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        prefix.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        textField.trailingAnchor.constraint(equalTo: prefix.leadingAnchor, constant: 10).isActive = true
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

}
