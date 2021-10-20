//
//  SportsView.swift
//  Assignment3
//
//  Created by OM SHELKE on 10/8/21.
//

import SwiftUI

struct SportsView: View {

    @State var selectedCountry: String = "India"
    @State var selectedSport: String = ""
    @State private var sliderSport: Float = 1
    let countries = ["India", "USA", "Taiwan"]
    let sports = [
        "India": [ "Cricket", "Chess", "Badminton", "Field Hockey", "Football", "Tennis", "Gilli-danda", "Golf" ],
        "USA": ["Baseball", "Football", "Curling", "Basketball", "Soccer", "Rock Climbing", "Skateboarding"],
        "Taiwan": ["Football", "Archery", "Baseball", "Table Tennis", "Cycling", "Taekwondo"]]
    
    var body: some View {

        let currentSports = sports[selectedCountry]
        
        VStack{
            VStack(alignment: .center, spacing: 0){
                
                Text("Select country from below list")
                    .underline()
                    .padding(.top, 100)
                
                Picker("Select Country", selection: $selectedCountry) {
                    ForEach(countries, id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 100, height: 140, alignment: .center)
                
                Text("Select sport from below list")
                    .underline()
                    .padding(.top,40)
                    
                Picker("Select Sport", selection: $selectedSport) {
                    ForEach(sports[selectedCountry]! , id: \.self) {
                        Text($0)
                    }
                }
                .frame(width: 100, height: 140, alignment: .center)
                .padding(.bottom, 60)
                
                VStack{
                    Slider(value: $sliderSport, in: 1...Float(currentSports!.count), step: 1, onEditingChanged: {_ in
                        selectedSport = currentSports![Int(sliderSport)-1]
                    })
                        .padding()
                        .accentColor(Color.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(Color.green)
                        )
                }
                Text("Country selected: \(selectedCountry)")
                    .padding(.top, 50)
                    .onChange(of: selectedCountry, perform: { selectedCountry in
                        sliderSport = 1
                    })
                
                Text("Sport selected: \(currentSports![Int(sliderSport)-1])")
                    .onChange(of: selectedSport, perform: {selectedSport in
                        sliderSport = Float((sports[selectedCountry]?.firstIndex(of: selectedSport))!)+1
                    })
            }
        .pickerStyle(.wheel)
        .frame(width:350, height: 115)
        .padding(.bottom, 150)
        }
    }
}

struct SportsView_Previews: PreviewProvider {
    static var previews: some View {
        SportsView()
    }
}
