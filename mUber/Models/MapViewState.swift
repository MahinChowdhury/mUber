//
//  MapViewState.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/17/23.
// This is much more scalable solution of different states rather than using multiple boolean variable.

import Foundation

enum MapViewState{
    case noInput
    case SearchingForLocation
    case locationSelected
}
