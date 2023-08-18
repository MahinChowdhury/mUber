//
//  RideType.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/18/23.
//

import Foundation

enum RideType : Int , CaseIterable, Identifiable {
    
    case uberX
    case uberBlack
    case uberXL
    
    var id : Int {return rawValue}
    
    var description:String {
        switch self{
        case .uberX : return "UberX"
        case .uberBlack : return "UberBlack"
        case .uberXL : return "UberXL"
        }
    }
    
    var imageName : String {
        switch self{
        case .uberX : return "uber-x"
        case .uberBlack : return "uber-black"
        case .uberXL : return "uber-x"
        }
    }
    
    var baseFair : Double {
        switch self{
        case .uberX : return 5
        case .uberBlack : return 10
        case .uberXL : return 8
        }
    }
    
    func calculatePrice(for distanceInMeters : Double) -> Double {
        
        let distanceInKm = distanceInMeters/1600
        
        switch self{
        case .uberX : return distanceInKm * 1.5 + baseFair
        case .uberBlack : return distanceInKm * 2.0 + baseFair
        case .uberXL : return distanceInKm * 1.75 + baseFair
        }
        
    }
    
}
