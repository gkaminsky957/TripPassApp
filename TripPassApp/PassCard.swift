//
//  PassCard.swift
//  testAppliction
//
//  Created by Gennady Kaminsky on 8/18/25.
//

import SwiftUI

struct PassCard: View {
    private var flightCities: String
    private var times: String
    private var statusViews: String
    
    init(flightCities: String,
         times: String,
         statusViews: String) {
        self.flightCities = flightCities
        self.times = times
        self.statusViews = statusViews
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "qrcode.viewfinder")
                .resizable()
                .frame(width: 40)
                .frame(height: 40)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Text(flightCities)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                Text(times)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.white)
                Text(statusViews)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                Divider()
                    .frame(height: 2)
                    .background(.white)
                    .padding(.top, -15)
            }
        }
        .padding(20)
        .background(.blue)
        .cornerRadius(20)
    }
}

#Preview {
    PassCard(flightCities: "SFO to IAD",
             times: "1:00 PM - 9:01 AM",
             statusViews: "ON time | View 1 pass")
}
