//
//  TripSummaryViewModel.swift
//  testApplictionTests
//
//  Created by Gennady Kaminsky on 8/18/25.
//

import SwiftUI

class PassDetailsViewModel: ObservableObject {
    @Published var boardPasses: [TripsModel.TripDetailModel.BoardingPass] = []
    @Published var date: String = ""
    @Published var toFrom: String = ""
    @Published var lastName: String = ""
    
    @MainActor
    func loadPasses() async {
        let passesData: Data =
        """
        {
          "tripDetails": {
              "date": "Aug 15, 2025",
              "from": "San Francisco",
              "to": "Chicago",
              "pnr": "ABC123",
              "lastName": "Mara",
              "boardingPasses": [
                  {
                      "origin": "SFO",
                      "destination": "LAX",
                      "departure": "1:00 PM",
                      "arrival": "2:00",
                      "status": "On time",
                      "passes": 1,
                      "gate": "F17",
                      "boardingGroup": 4,
                      "seat": "52D",
                      "flightNumber": "UA 2667"
                  },
                  {
                      "origin": "LAX",
                      "destination": "OHR",
                      "departure": "3:00 PM",
                      "arrival": "10:00 PM",
                      "status": "Delayed",
                      "passes": 1,
                      "gate": "A17",
                      "boardingGroup": 2,
                      "seat": "52D",
                      "flightNumber": "UA 2667"
                  }
                  ]
          }
        }
        """.data(using:  .utf8) ?? Data()
        let decoder = JSONDecoder()
        let model = try? decoder.decode(TripsModel.self, from: passesData)
       
        date = model?.tripDetails.date ??  ""
        if let model = model {
            boardPasses = model.tripDetails.boardingPasses
            toFrom =  "\(model.tripDetails.from) to \(model.tripDetails.to)"
            lastName = "\(model.tripDetails.pnr) | \(model.tripDetails.lastName)"
        }
    }
    
    func flightCities(pass: TripsModel.TripDetailModel.BoardingPass) -> String {
        return "\(pass.origin) to \(pass.destination)"
    }
    
    func departureArrivalTimes(pass: TripsModel.TripDetailModel.BoardingPass) -> String {
        return "\(pass.departure) -  \(pass.arrival)"
    }
    
    func statusView(pass: TripsModel.TripDetailModel.BoardingPass) -> String {
        return "\(pass.status) | View  \(pass.passes) pass"
    }
}
