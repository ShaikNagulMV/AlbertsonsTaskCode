//
//  BindingSearchBar.swift
//  Meaning
//
//  Created by 1212199 on 25/11/21.
//

import Foundation
import UIKit.UIImage

class BindingSearchBar: UISearchBar {
    
    var textChangeClosure: (String) -> () = {_ in}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func bind(callback: @escaping(String) -> ()) {
        self.textChangeClosure = callback
    }
    private func commonInit() {
        self.searchTextField.addTarget(self, action: #selector(searchBarSearchButtonClicked), for: .editingDidEnd)
    }
    
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.textChangeClosure(text)
        }
    }
}
