//
//  UberMapViewRepresentable.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/16/23.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        
        mapView.delegate = context.coordinator
        
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocation{
            print("Selected Location is : \(coordinate)")
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable{
    
    class MapCoordinator : NSObject , MKMapViewDelegate {
        
        let parent : UberMapViewRepresentable
        var userLocationCoordinate : CLLocationCoordinate2D?
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            self.userLocationCoordinate = userLocation.coordinate
            
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span : MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            parent.mapView.setRegion(region, animated: true)
            
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            
            return polyline
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate : CLLocationCoordinate2D){
            
            self.parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno,animated:true)
            self.parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate : CLLocationCoordinate2D){
            
            guard let userLocationCoordinate = self.userLocationCoordinate else{return}
            
            //print("UserLocation : \(userLocationCoordinate) and DestLocation : \(coordinate)")
            
            getDestinationRoute(from: userLocationCoordinate, to: coordinate){ route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destinationLocation : CLLocationCoordinate2D,completion : @escaping(MKRoute) -> Void){
            
            //print("UserLocation : \(userLocation) and DestLocation : \(destinationLocation)")

            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destinationLocation)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            
            print(directions)
            
            directions.calculate{ response , error in
                if let error = error{
                    print("Failed to get directions with error \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else {return}
                completion(route)
            }
        }
        
    }
    
}
