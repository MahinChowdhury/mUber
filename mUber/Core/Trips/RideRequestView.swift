//
//  RideRequestView.swift
//  mUber
//
//  Created by Mahin Chowdhury on 8/17/23.
//

import SwiftUI

struct RideRequestView: View {
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
                        
                        Text("1:30 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16,weight: .semibold))
                        
                        Spacer()
                        
                        Text("1:45 PM")
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
                    ForEach(0 ..< 3 , id: \.self){ _ in
                        VStack(alignment : .leading){
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            VStack(spacing:4){
                                Text("UberX")
                                    .font(.system(size: 14,weight: .semibold))
                                Text("$22.05")
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            .padding(8)
                        }
                        .frame(width:112, height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
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
        .background(.white)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
