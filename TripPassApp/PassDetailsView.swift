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
    private var confirmationNumber: String
    private var lastName: String
    
    init(confirmationNumber: String,
         lastName: String) {
        self.confirmationNumber = confirmationNumber
        self.lastName = lastName
    }
    
    var body: some View {
        createView()
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

private extension PassDetailsView {
    func createView() -> some View {
        if viewModel.shouldShowProgressView {
            AnyView(ProgressView("Please wait...")
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                }
                .padding(.horizontal, 100)
                .task {
                    await viewModel.loadPasses(confirmationNumebr: confirmationNumber,
                                               name: lastName)
                })
        } else {
            AnyView(VStack {
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
            })
        }
    }
}

#Preview {
    PassDetailsView(confirmationNumber: "SomeTestConfirmationNumber",
                    lastName: "TestLastName")
}
