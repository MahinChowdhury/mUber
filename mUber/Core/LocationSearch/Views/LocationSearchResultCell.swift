//
//  LocationSearchResultCell.swift
//  mUber
//
//  Created by Shium Ishrak on 8/16/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40 , height: 40)
            
            VStack(alignment:.leading , spacing: 4){
                Text("Starbucks Coffee")
                    .font(.body)
                Text("123 Main St,California CA")
                    .font(.system(size:15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading,8)
        }
        .padding(.leading)
        .padding(.vertical,6)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
