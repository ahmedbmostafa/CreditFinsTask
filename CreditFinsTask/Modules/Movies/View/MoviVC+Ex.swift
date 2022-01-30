//
//  MoviVC + Ex.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit

extension MovieVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let cellViewModel = viewModel.getMovieListCellViewModel(index: indexPath.row)
        cell.populateWithViewModel(cellViewModel: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cellViewModel = self.viewModel.getMovieListCellViewModel(index: indexPath.row)
        if segmentedContol.selectedSegmentIndex == 0 {
            return UISwipeActionsConfiguration(actions: [
                makeFavorite(cellViewModel: cellViewModel, indexPath: indexPath)])
        }else {
            return UISwipeActionsConfiguration(actions: [
                makeDelete(cellViewModel: cellViewModel, indexPath: indexPath)])
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.row)
    }
}

extension MovieVC : UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtBottom() {
            viewModel.tableViewDidReachToEnd()
        }
    }
}
