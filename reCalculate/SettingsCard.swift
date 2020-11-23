//
//  SettingsCard.swift
//  reCalculate
//
//  Created by Petter vang Brakalsvålet on 19/11/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import UIKit

class SettingsCard: UITableViewCell {
    var prefix = UILabel()
    var unitSwitch = UISwitch()

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
        
        self.addSubview(prefix)
        self.addSubview(unitSwitch)
        setConstraints()
    }
    
    func setConstraints(){
        prefix.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        prefix.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
