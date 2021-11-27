//
//  ViewController.swift
//  Meaning
//
//

import UIKit

final class ViewController: UIViewController {

    private let meaningsViewModel = MeaningsViewModel()
    private var searchMeaningViewModel = SearchMeaningViewModel()
    
    @IBOutlet weak var meaningsTableView: UITableView!
    @IBOutlet weak var searchBar: BindingSearchBar! {
        didSet {
            searchBar.bind { self.searchMeaningViewModel.searchText = $0 }
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!

    private var dataSource : TableViewDataSource<MeaningTableViewCell, MeaningData.LongForm>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        meaningsTableView.estimatedRowHeight = CGFloat(Constants.rowHeight)
        meaningsTableView.rowHeight = UITableView.automaticDimension
        meaningsTableView.isHidden = true
        activityIndicator.isHidden = true
        messageLabel.isHidden = true
    }

    func callViewModelForData() {
        meaningsViewModel.getMeanings(searchMeaningViewModel.searchText)
        meaningsViewModel.bindMeaningsViewModelToController = {
            self.updateTableView()
        }
    }

    func updateTableView() {
        let longForms = meaningsViewModel.meanings?.longForms ?? []
        dataSource = TableViewDataSource(cellIdentifier: Constants.meaningTableViewCell, items: longForms, configureCell: { (cell, longForm) in
            cell.meaningLabel.text = longForm.meaning
        })
        DispatchQueue.main.async { [self] in
            self.activityIndicator.isHidden = true
            self.meaningsTableView.isHidden = longForms.isEmpty
            self.messageLabel.isHidden = !longForms.isEmpty
            self.messageLabel.text = longForms.isEmpty ? "\(Constants.notFoundMessage) \(self.searchMeaningViewModel.searchText)" : ""
            self.meaningsTableView.dataSource = self.dataSource
            self.meaningsTableView.reloadData()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        self.searchBar.showsCancelButton = false
        self.searchBar.resignFirstResponder()
        self.meaningsTableView.isHidden = true
        self.messageLabel.isHidden = true
        self.activityIndicator.isHidden = false
        callViewModelForData()
    }
}
