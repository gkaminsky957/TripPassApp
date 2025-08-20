//
//  GetFullApplicationView.swift
//  testAppliction
//
//  Created by Gennady Kaminsky on 8/19/25.
//

import SwiftUI

struct GetFullApplicationView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Get the full app")
            Divider()
              .frame(height: 3)
              .foregroundColor(.gray)
              .padding(.top, -10)
            HStack(spacing: 15) {
                Image("unitedAirlineIcon")
                    .resizable()
                    .frame(width: 60)
                    .frame(height: 60)
                VStack(alignment: .leading) {
                    Text("United Airlines")
                        .font(.system(size: 10, weight: .bold))
                    Text("From plannng, to booking, to day of travel, we've got you covered")
                        .font(.system(size: 10))
                }
                Spacer()
                Button(action: {
                    let uiApplication = UIApplication.shared
                    guard let url = URL(string: "itms-apps://itunes.apple.com/app/id449945214"),
                          uiApplication.canOpenURL(url) else { return }
                    uiApplication.open(url)
                }) {
                    Text("Get")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 40)
                .background(.blue)
                .cornerRadius(10)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    GetFullApplicationView()
}
