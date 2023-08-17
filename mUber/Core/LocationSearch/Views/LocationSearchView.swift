//
//  LocationSearchView.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/16/23.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var showLocationSearchView : Bool
    
    var body: some View {
        VStack{
            //Header View
            
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width : 6 , height : 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width : 1 , height : 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width : 6 , height : 6)
                }
                VStack{
                    TextField("Current location",text : $startLocationText)
                        .frame(height : 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?",text : $viewModel.queryfragment)
                        .frame(height : 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top,64)
            
            Divider()
                .padding(.vertical)
            
            //List View
            
            ScrollView(){
                VStack(alignment:.leading){
                    ForEach(viewModel.results , id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                viewModel.selectLocation(result)
                                showLocationSearchView.toggle()
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showLocationSearchView: .constant(false))
            .environmentObject(LocationSearchViewModel())
    }
}
