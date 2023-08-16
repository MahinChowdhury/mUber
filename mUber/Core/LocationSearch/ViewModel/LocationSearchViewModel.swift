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
    @Published var selectedLocation : String?
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
    
    func selectedLocation(_ location: String){
        self.selectedLocation = location
    }
}
