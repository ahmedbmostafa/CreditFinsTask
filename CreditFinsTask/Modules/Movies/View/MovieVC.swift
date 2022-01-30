//
//  ViewController.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var segmentedContol: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    var viewModel: MoviesViewModelProtocol!
    var activityIndicator: ActivityIndicatorStates!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator = ActivityIndicator()
        setUpSegment()
        setUpTableView()
        bindViewModelOutput()
        viewModel.didLoad()
    }

    func setUpSegment(){
        segmentedContol.setTitle("Coming Movies", forSegmentAt: 0)
        segmentedContol.setTitle("Favourite Movies", forSegmentAt: 1)
    }

    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(identifier: "MovieTableViewCell")
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            guard let self = self else {return}
            switch output {
            case .reloadMovies:
                self.tableView.reloadData()
            case .showActivityIndicator(let show):
                show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
            case .showError(let error):
                UIAlertController.showAlert(withMessage: error.localizedDescription)
            }
        }
    }
    
    @objc func refreshTableData() {
        viewModel.output = { [weak self] output in
            guard let self = self else {return}
            switch output {
            case .reloadMovies:
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            default:
                break
            }
        }
        viewModel.didLoad()
    }

    func updateTableView() {
        viewModel.didSelectFavorite { [weak self] isEmpty in
            guard let self = self else {return}
            if isEmpty {
                self.tableView.alpha = 0
            } else {
                self.tableView.alpha = 1
            }
        }
    }

    func makeFavorite(cellViewModel: MovieTableViewCellViewModel, indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Favorite") { (_, _, completion) in
            cellViewModel.saveMovie(movieId: String(cellViewModel.movie?.id ?? 0))
            completion(true)
        }
    }

    func makeDelete(cellViewModel: MovieTableViewCellViewModel, indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (_, _, completion) in
            cellViewModel.deleteMovie(movieId: String(cellViewModel.movie?.id ?? 0)) { [weak self] in
                guard let self = self else {return}
                if self.viewModel.numberOfMovies > 1 {
                    self.viewModel.clearFilter()
                }
                self.updateTableView()
            }
            completion(true)
        }
    }

    @IBAction func segmentedControllTapped(_ sender: Any) {
        let index = segmentedContol.selectedSegmentIndex
        switch index {
        case 0:
            viewModel.clearFilter()
            self.tableView.alpha = 1
        case 1:
            updateTableView()
        default:
            break
        }
    }
}

