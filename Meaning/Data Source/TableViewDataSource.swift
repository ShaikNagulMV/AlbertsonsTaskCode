//
//  MeaningTableViewDataSource.swift
//  Meaning
//
//

import Foundation
import UIKit

final class TableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {

    private let cellIdentifier : String!
    private var items : [T]!
    private var configureCell : (CELL, T) -> () = {_,_ in }

    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CELL, indexPath.row < items.count else {
            return UITableViewCell(frame: .zero)
        }
        self.configureCell(cell, self.items[indexPath.row])
        return cell
    }
}
