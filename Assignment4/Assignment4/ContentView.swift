//
//  ContentView.swift
//  Assignment4
//
//  Created by OM SHELKE on 10/10/21.
//

import SwiftUI


struct ContentView: View {
    @State var selectedOption: String = "Draw"
    let options = ["Draw", "Delete", "Play"]
    
    @State private var circles: [AnyView] = []
    @State private var circleCenters: [CGPoint] = []
    @State private var circleRadius: [CGFloat] = []
    @State private var tempCircles: [AnyView] = []
    @State private var selectedColor: Color = .black
    @State private var location: CGPoint = CGPoint()
    
    @State private var showingUIView = true
    @State private var image: Image?
    
    
    
    var body: some View {
        ZStack{
            VStack{
                Picker("Select option", selection: $selectedOption) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(10)
            }
        }
        
        if selectedOption == "Draw" {
                GeometryReader{ geometry in
                    
                    Rectangle()
                        .fill(Color.clear)
        
                        //For dynamically displaying the circles as we drag finger
                        ForEach(tempCircles.indices, id: \.self){
                        tempCircles[$0]
                        }
                    
                
                }
                .contentShape(Rectangle())
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                        .onChanged({ value in
                                            let radius = CGPointDistance(from: value.startLocation, to: value.location)
                                            tempCircles.append(AnyView(
                                                Circle()
                                                    .fill(selectedColor)
                                                    .frame(width: 2 * radius)
                                                    .position(x: value.startLocation.x, y: value.startLocation.y)
                                                
                                            ))
                                        })
                            .onEnded({ value in
                    circles.append(tempCircles.last!)
                    circleCenters.append(value.startLocation)
                    circleRadius.append(CGPointDistance(from: value.startLocation, to: value.location))
                    
                })
                )
            if #available(iOS 15.0, *) {
                ColorPicker("", selection: $selectedColor)
                    .padding(5)
            } else {
                // Fallback on earlier versions
            }
                Spacer()
        }
        
        else if selectedOption == "Delete" {
            GeometryReader{ geometry in
                Rectangle()
                    .fill(Color.clear)
                ForEach(circles.indices, id: \.self){
                    circles[$0]
                }
            }
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0).onEnded({ (value) in
                deleteCircles(touchPoint: value.location)
                }))
        }
        
        else if selectedOption == "Play" {
            GeometryReader{ geometry in
                Rectangle()
                    .fill(Color.clear)
                ForEach(circles.indices, id: \.self){
                    circles[$0]
                        .draggable( circleCenters[$0], circleRadius[$0], geometry.size.width, geometry.size.height)
                        .animation(.default)
            }
            }
            .contentShape(Rectangle())
        }
        Spacer()
    }
    
    
    
    func deleteCircles(touchPoint: CGPoint){
        var removeArrayIndex: [Int] = []
        for (index,item) in circleCenters.enumerated() {
            let radius = circleRadius[index]
            let distanceFromCenter = CGPointDistance(from: touchPoint, to: item)
            if distanceFromCenter <= radius {
                removeArrayIndex.append(index)
            }
        }
        for i in removeArrayIndex.reversed() {
            circles.remove(at: i)
            circleRadius.remove(at: i)
            circleCenters.remove(at: i)
        }
        tempCircles.removeAll()
        tempCircles = circles
        
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
