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
    @Published var selectedLocation : CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()

    var queryfragment:String = ""{
        didSet{
            searchCompleter.queryFragment = queryfragment
        }
    }
    
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
            
            self.selectedLocation = coordinate
            
            print("DEBUG : Location coordinates : \(coordinate)")
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch : MKLocalSearchCompletion, completion : @escaping MKLocalSearch.CompletionHandler){
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
}
