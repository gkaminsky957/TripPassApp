//
//  ContentView.swift
//  testAppliction
//
//  Created by Gennady Kaminsky on 8/18/25.
//

import SwiftUI

struct PassDetailsView: View {
    @StateObject private var viewModel = PassDetailsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.date)
                    Text(viewModel.toFrom)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.bottom, 10)
                    Text(viewModel.lastName)
                        .padding(.bottom, 30)
                    Text("Boarding passes")
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                }
                Spacer()
            }
            .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.boardPasses) { pass in
                        PassCard(flightCities: viewModel.flightCities(pass: pass),
                                 times: viewModel.departureArrivalTimes(pass: pass),
                                 statusViews: viewModel.statusView(pass: pass))
                        .frame(width: 300)
                    }
                }
            }
            Spacer()
            GetFullApplicationView()
        }
        .task {
            await viewModel.loadPasses()
        }
        .navigationTitle("Trip Details")
        .toolbarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview {
    PassDetailsView()
}
