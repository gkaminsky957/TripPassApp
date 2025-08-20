//
//  TripModel.swift
//  testApplictionTests
//
//  Created by Gennady Kaminsky on 8/18/25.
//
import Foundation

struct TripsModel: Decodable {
    var tripDetails: TripDetailModel
    struct TripDetailModel: Decodable {
        var date:  String
        var from:  String
        var to:  String
        var pnr:  String
        var lastName: String
        
        var boardingPasses: [BoardingPass]
        
        struct BoardingPass: Decodable, Identifiable, Hashable {
            var origin: String
            var destination: String
            var  departure: String
            var  arrival: String
            var  status: String
            var  passes: Int
            var  gate: String
            var  boardingGroup: Int
            var  seat: String
            var  flightNumber: String
            var id: String? {
                return UUID().uuidString
            }
        }
    }
}
