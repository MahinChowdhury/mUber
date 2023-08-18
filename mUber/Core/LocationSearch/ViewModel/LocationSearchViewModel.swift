//
//  LocationSearchViewModel.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/16/23.
//

import Foundation
import MapKit

class LocationSearchViewModel : NSObject , ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation : UberLocation?
    @Published var pickupTime : String?
    @Published var dropOffTime : String?
    private let searchCompleter = MKLocalSearchCompleter()

    var queryfragment:String = ""{
        didSet{
            searchCompleter.queryFragment = queryfragment
        }
    }
    
    var userLocation : CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryfragment
        
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch){response,error in
            if let error = error{
                print("DEBUG : Location Search Failed with error : \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else {return}
            let coordinate = item.placemark.coordinate
            
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            
            print("DEBUG : Location coordinates : \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion, completion : @escaping MKLocalSearch.CompletionHandler){
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRiderPrice(forType type : RideType) -> Double {
        guard let coordinate = selectedUberLocation?.coordinate else {return 0.0}
        guard let userLocation = self.userLocation else {return 0.0}
        
        let userLoc  = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let tripDistanceInMeter = userLoc.distance(from: destination)
        
        return type.calculatePrice(for: tripDistanceInMeter)
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
            self.configurePickAndDropTime(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickAndDropTime(with expectedTravelTime : Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm: a"
        
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
        
    }
    
}
