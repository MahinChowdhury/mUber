//
//  HomeView.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/16/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        
        ZStack(alignment:.bottom){
            ZStack(alignment : .top){
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                if mapState == .SearchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top,70)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .SearchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top,4)
            }
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
    }
}
