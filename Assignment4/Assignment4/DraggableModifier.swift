//
//  DraggableModifier.swift
//  Assignment4
//
//  Created by OM SHELKE on 10/20/21.
//

import Foundation
import SwiftUI

extension View {
    func draggable(_ center: CGPoint, _ radius: CGFloat, _ width: CGFloat, _ height: CGFloat) -> some View {
        self
            .modifier(DraggableModifier(circlePosition: center, radius: radius, width: width, height: height))
    }
}


struct DraggableModifier: ViewModifier{
    @State var offset: CGPoint? = .zero
    @State var circlePosition: CGPoint?
    @State private var previousTranslation: CGSize?
    @State var lastDragPosition: DragGesture.Value?
    @State var radius: CGFloat?
    @State var width: CGFloat?
    @State var height: CGFloat?
    
    func body(content: Content) -> some View {
        content
            .offset(x: offset!.x, y: offset!.y)
            .gesture(DragGesture()
                        .onChanged{ value in
                                self.lastDragPosition = value
                                if let translation = previousTranslation {
                                    let delta = CGSize(width: value.translation.width - translation.width,
                                                       height: value.translation.height - translation.height)
                                    offset!.x += delta.width
                                    offset!.y += delta.height
                                    previousTranslation = value.translation
                                }
                                else {
                                    previousTranslation = value.translation
                                }
                        }
                        .onEnded{ value in
                                previousTranslation = nil
                                let timeDiff = value.time.timeIntervalSince(self.lastDragPosition!.time)
                                var speed:CGFloat = CGPointDistance(from: value.startLocation, to: value.location) / CGFloat(timeDiff)
                let a = value.startLocation.x - value.location.x
                let b = value.startLocation.y - value.location.y
                                while(speed>0) {
                                    speed -= 100
                                    if(a<0){
                                        if( (circlePosition!.x + offset!.x + radius!) >= width!){
                                            offset!.x = width! - circlePosition!.x - radius!
                                            speed -= 100
                                        }
                                        else{
                                            offset!.x += 1
                                        }
                                    }
                                    if(a>0){
                                        if( (circlePosition!.x + offset!.x + radius!) <= width!){
                                            offset!.x = radius! - circlePosition!.x
                                            speed -= 100
                                        }
                                        else{
                                            offset!.x -= 1
                                        }
                                    }
                                    if(b<0){
                                        if( (circlePosition!.y + offset!.y + radius!) >= height!){
                                            offset!.y = height! - circlePosition!.y - radius!
                                            speed -= 100
                                        }
                                        else{
                                            offset!.y += 1
                                        }
                                    }
                                    if(b>0){
                                        if( (circlePosition!.y + offset!.y + radius!) <= width!){
                                            offset!.y = radius! - circlePosition!.y
                                            speed -= 100
                                        }
                                        else{
                                            offset!.y -= 1
                                        }
                                    }
                                }
                        }
                    )
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
}
