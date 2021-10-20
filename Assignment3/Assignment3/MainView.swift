//
//  ContentView.swift
//  Assignment3
//
//  Created by OM SHELKE on 10/8/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SportsView()
                .tabItem {
                    Label("Sports", systemImage: "sportscourt")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            SegmentView()
                .tabItem {
                    Label("Segment", systemImage: "switch.2")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
