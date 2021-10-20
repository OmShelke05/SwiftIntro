//
//  MapView.swift
//  Assignment3
//
//  Created by OM SHELKE on 10/8/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    var body: some View {
        mapView()
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct mapView : UIViewRepresentable {
        
    func makeCoordinator() -> Coordinator {
        return mapView.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        let sourceCoordinate = CLLocationCoordinate2D(latitude: 32.7948, longitude: -116.9625)
        let destinationCoordinate = CLLocationCoordinate2D(latitude: 33.1192, longitude: -117.0864)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611), span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7))
        
        let sourcePin = MKPointAnnotation()
        sourcePin.coordinate = sourceCoordinate
        sourcePin.title = "El Cajon"
        map.addAnnotation(sourcePin)

        let destinationPin = MKPointAnnotation()
        destinationPin.coordinate = destinationCoordinate
        destinationPin.title = "Escondido"
        map.addAnnotation(destinationPin)

        map.region = region
        map.delegate = context.coordinator
        
        
        let req = MKDirections.Request()
        req.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        req.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        
        let directions = MKDirections(request: req)
        
        directions.calculate {(direct, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let polyline = direct?.routes.first?.polyline
            map.addOverlay(polyline!)
            map.setRegion(MKCoordinateRegion(polyline!.boundingMapRect), animated: true)
        }
        
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }

    class Coordinator: NSObject, MKMapViewDelegate{

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = .blue
            render.lineWidth = 2
            return render
        }
    }
}
