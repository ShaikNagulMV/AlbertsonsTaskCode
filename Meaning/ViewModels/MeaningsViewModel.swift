//
//  MeaningsViewModel.swift
//  Meaning
//
//

import Foundation
import UIKit.UIImage

public class MeaningsViewModel {
    let acromine = Dynamic("")
    private let apiService = APIService()
    private(set) var errorMessage: Dynamic<String>? = nil
    private(set) var meanings : MeaningData? = nil {
        didSet {
            self.bindMeaningsViewModelToController()
        }
    }

    var bindMeaningsViewModelToController : (() -> ()) = {}

    init() {
    }

    func getMeanings(_ shortForm: String) {
        self.acromine.value = shortForm
        apiService.getMeanings(shortForm) { meanings, errorString   in
            self.meanings = !meanings.isEmpty ? meanings.first : nil
            self.errorMessage?.value = errorString ?? ""
        }
    }
}
