//
//  ContentView.swift
//  reCalculate.SwiftUI
//
//  Created by Petter vang Brakalsvålet on 04/07/2020.
//  Copyright © 2020 Petter vang Brakalsvålet. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
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
                Spacer()
                    .frame(minHeight: 30, maxHeight: .infinity)
            }
        }
    }
}

func taped(_ buttonTaped: String){
    print("\(buttonTaped) Button tapped!")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
