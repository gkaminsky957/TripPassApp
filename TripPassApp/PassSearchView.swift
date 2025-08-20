//
//  TripDetailsView.swift
//  testAppliction
//
//  Created by Gennady Kaminsky on 8/18/25.
//

import SwiftUI

struct PassSearchView: View {
    enum FocusedField {
        case confirmationNumberField
        case lastNameField
    }
    
    @State var confirmationNumber: String = ""
    @State var lastName: String = ""
    @State var shuoldGoToDetailView = false
    @FocusState private var focusField: FocusedField?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Enter trip details")
                    .font(.system(size: 20, weight: .bold))
                Text("Confirmation or ticket number")
                
                TextField("Confirmation or ticket number", text: $confirmationNumber)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .lastNameField
                    }
                    .focused($focusField, equals: .confirmationNumberField)
                Text("Last Name")
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .focused($focusField, equals: .lastNameField)
                
                Spacer()
                
                Button(action: {
                    shuoldGoToDetailView = true
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 10)
                .frame(height: 40)
                .background(.blue)
                .cornerRadius(10)
                .disabled(isContinueBtnDisabled())
                .opacity(isContinueBtnDisabled() ? 0.5 : 1)
                GetFullApplicationView()
                    .padding(.top, 20)
            }
            .padding()
            .navigationDestination(isPresented: $shuoldGoToDetailView) {
                PassDetailsView()
                    .padding()
            }
            .navigationTitle("Terminal Guide")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .onAppear {
                focusField = .confirmationNumberField
            }
        }
    }
    
    func isContinueBtnDisabled() -> Bool {
        return confirmationNumber.isEmpty || lastName.isEmpty
    }
}

#Preview {
    PassSearchView()
}
