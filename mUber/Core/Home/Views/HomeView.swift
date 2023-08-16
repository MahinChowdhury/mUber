//
//  HomeView.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/16/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationSearchView = false
    
    var body: some View {
        
        ZStack(alignment : .top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if(showLocationSearchView){
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            } else{
                LocationSearchActivationView()
                    .padding(.top,70)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(ShowLocationSearchView: $showLocationSearchView)
                .padding(.leading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
    }
}
