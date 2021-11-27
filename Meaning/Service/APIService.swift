//
//  APIService.swift
//  Meaning
//
//

import Foundation
import Alamofire

final class APIService {
    
    func getMeanings(_ shortFormat: String, completion : @escaping (_ meanings: [MeaningData], _ errorMessage: String?) -> ()) {
        
        AF.request(Constants.baseUrl, parameters: [Constants.abbreviationKey: shortFormat, Constants.fullformsKey: shortFormat]).responseDecodable(of: [MeaningData].self) { response in
            switch response.result {
            case .success(let meanings):
                completion(meanings, nil)
            case .failure( let error):
                completion([], error.errorDescription)
            }
        }
    }
}
