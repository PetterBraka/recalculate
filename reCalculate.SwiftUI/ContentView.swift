//
//  ContentView.swift
//  reCalculate.SwiftUI
//
//  Created by Petter vang Brakalsvålet on 04/07/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import SwiftUI

let weightUnits: [UnitMass] = [.milligrams, .centigrams, .decigrams, .kilograms,
                                .metricTons, .ounces, .pounds, .stones]
let lengthUnits: [UnitLength] = [.centimeters, .decameters, .meters, .kilometers, .scandinavianMiles,
                                 .inches, .feet, .yards, .fathoms, .miles, .nauticalMiles, .lightyears]
let liquidUnits: [UnitVolume] = [.milliliters, .centiliters, .deciliters, .liters,
                                 .gallons, .pints, .fluidOunces, .teaspoons, .tablespoons]

var units : [Unit] = []

struct ContentView: View {
    @State var input: String = ""
    @State var refresh: Bool = false
    
    var body: some View {
        ZStack{
            Color(UIColor().hexStringToUIColor("212121"))
                .edgesIgnoringSafeArea(.all)
            VStack(){
                Text("reCalculate")
                    .foregroundColor(.white)
                    .font(.custom("American Typewriter Condensed Bold", size: 50))
                Spacer()
                    .frame(minHeight: 30, maxHeight: 200)
                Text("What to you want to \n reCalculate")
                    .foregroundColor(.white)
                    .font(.custom("American Typewriter", size: 20))
                    .multilineTextAlignment(.center)
                Spacer()
                    .frame(height: 25)
                HStack(){
                    Spacer()
                    Button(action: {
                        taped("Weight")
                    }) {
                        Text("Weight")
                            .fontWeight(.bold)
                            .font(.custom("American Typewriter Bold", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(UIColor.darkGray), lineWidth: 4)
                        )
                    }
                    Spacer()
                    Button(action: {
                        taped("Length")
                    }) {
                        Text("Length")
                            .fontWeight(.bold)
                            .font(.custom("American Typewriter Bold", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(UIColor.darkGray), lineWidth: 4)
                        )
                    }
                    Spacer()
                    Button(action: {
                        taped("Liquid")
                    }) {
                        Text("Liquid")
                            .fontWeight(.bold)
                            .font(.custom("American Typewriter Bold", size: 20))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(UIColor.darkGray), lineWidth: 4)
                        )
                    }
                    Spacer()
                }
                    List(units, id: \.self) { unit in
                        HStack(){
                            TextField("Enter value", text: self.$input, onEditingChanged: { (changed) in
                                print("Entered: \(changed)")
                            })
                                .padding(.all, 5)
                                .frame(width: 120, height: 40, alignment: .center)
                                .foregroundColor(Color(UIColor.lightGray))
                                .background(Color(UIColor.gray))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(UIColor.lightGray), lineWidth: 2)
                            )
                            Text("\(unit.symbol)")
                                .foregroundColor(.white)
                                .font(.custom("American Typewriter", size: 20))
                            
                        }
                    }
                    .frame(minHeight: 30, maxHeight: .infinity)
                }
        }
    }
}

func taped(_ buttonTaped: String){
    print("\(buttonTaped) Button tapped!")
    switch buttonTaped {
        case "Weight":
            units = weightUnits
        case "Lenght":
            units = lengthUnits
        case "Liquid":
            units = liquidUnits
        default:
            units = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
