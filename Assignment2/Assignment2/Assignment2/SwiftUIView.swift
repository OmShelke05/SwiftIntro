//
//  SwiftUIView.swift
//  Assignment2
//
//  Created by OM SHELKE on 9/18/21.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct SwiftUIView: View {
    
    @State var redTextField: String = ""
    @State var greenTextField: String = ""
    @State var blueTextField: String = ""
    let userDefaults = UserDefaults()
    
    func updateValues(changed: Bool){
        userDefaults.setValue(redTextField, forKey: "storedRedValue")
        userDefaults.setValue(greenTextField, forKey: "storedGreenValue")
        userDefaults.setValue(blueTextField, forKey: "storedBlueValue")
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 12){
            HStack(){
                Text("Red")
                    .frame(width: 80, height: 30)
                    .font(.system(size: 25))
                    .background(Color.red)
                    .padding(20)
                TextField("Red value (0-100)", text: $redTextField, onEditingChanged: self.updateValues)
                    .padding(20)
                    
                }
            HStack(){
                Text("Green")
                    .frame(width: 80, height: 30)
                    .font(.system(size: 25))
                    .background(Color.green)
                    .padding(20)
                TextField("Green value (0-100)", text: $greenTextField,  onEditingChanged: self.updateValues)
                    .padding(20)
            }
            HStack(){
                Text("Blue")
                    .frame(width: 80, height: 30)
                    .font(.system(size: 25))
                    .background(Color.blue)
                    .padding(20)
                TextField("Blue value (0-100)", text: $blueTextField,  onEditingChanged: self.updateValues)
                    .padding(20)
            }
            HStack(){
                Rectangle()
                    .fill(Color(red: (Double(redTextField) ?? 0) / 100, green: (Double(greenTextField) ?? 0) / 100, blue: (Double(blueTextField) ?? 0) / 100))
                    .frame(width: 240, height: 130, alignment: .center)
                    .padding(20)
            }
        }
        .onAppear{
            redTextField = userDefaults.value(forKey: "storedRedValue") as? String ?? ""
            greenTextField = userDefaults.value(forKey: "storedGreenValue") as? String ?? "" 
            blueTextField = userDefaults.value(forKey: "storedBlueValue") as? String ?? ""
        }
        .onTapGesture {
            updateValues(changed: true)
            hideKeyboard()
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
