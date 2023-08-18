//
//  RideRequestView.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/17/23.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType : RideType = .uberX
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    var body: some View {
                
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width:48 , height: 6)
                .padding(.top,8)
            
            //Trip info Section
            
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width : 8 , height : 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width : 1 , height : 32)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width : 8 , height : 8)
                }
                VStack(alignment: .leading , spacing: 24){
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        if let location = locationViewModel.selectedUberLocation{
                            Text(location.title)
                                .font(.system(size: 16,weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading,8)
            }
            .padding()
            
            Divider()

            //Ride Type Section
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity , alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing:12){
                    ForEach(RideType.allCases){ridetype in
                        VStack(alignment : .leading){
                            Image(ridetype.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment:.leading,spacing:4){
                                Text(ridetype.description)
                                    .font(.system(size: 14,weight: .semibold))
                                Text("$\(locationViewModel.computeRiderPrice(forType: ridetype),specifier: "%.2f")")
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width:112, height: 140)
                        .background(Color(selectedRideType == ridetype ? .systemBlue : Color.theme.secondaryBackgroundColor))
                        .foregroundColor(selectedRideType == ridetype ? .white : Color.theme.primaryTextColor)
                        .scaleEffect(selectedRideType == ridetype ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = ridetype
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical,8)
            
            //Payment Section
            
            //Request Ride Button Section
            
            Button{
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width:UIScreen.main.bounds.width-32,height: 50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            
        }
        .padding(.bottom,24)
        .cornerRadius(16)
        .background(Color.theme.backgroundColor)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
