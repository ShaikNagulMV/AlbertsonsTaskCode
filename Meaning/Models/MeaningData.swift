//
//  Meaning.swift
//  Meaning
//
//

import Foundation

struct MeaningData: Decodable {
    let shortForm: String
    let longForms: [LongForm]

    enum CodingKeys: String, CodingKey {
        case shortForm = "sf"
        case longForms = "lfs"
    }
    
    struct LongForm: Decodable {
        let meaning: String
        let frequency, since : Int
        let variations: [Variation]

        enum CodingKeys: String, CodingKey {
            case meaning = "lf"
            case frequency = "freq"
            case since
            case variations = "vars"
        }
        
        struct Variation: Decodable {
            let meaning: String
            let frequency, since : Int

            enum CodingKeys: String, CodingKey {
                case meaning = "lf"
                case frequency = "freq"
                case since
            }
        }
    }
   
    var meaning: String {
        longForms[0].meaning
    }
}



