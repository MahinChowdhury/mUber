//
//  HomeView.swift
//  mUber
//
//  Created by Shium Ishrak on 8/16/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        ZStack(alignment : .top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            LocationSearchActivationView()
                .padding(.top,70)
            MapViewActionButton()
                .padding(.leading)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
