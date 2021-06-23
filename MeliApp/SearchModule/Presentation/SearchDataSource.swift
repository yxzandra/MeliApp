import UIKit

class SearchDataSource: NSObject {
    typealias Constants = SearchViewConstants.NibCell
    weak var viewController: SearchViewController?
    var cellTypes = SearchCellTypes.default
    
    private func prepareSearch(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibSearchCell, for: indexPath) as? SearchCell
        else { return UITableViewCell() }
        cell.backgroundColor = .backgroundColor
        cell.textChangeAction = { value in
            self.viewController?.presenter?.searchItem(item: value)
        }
        return cell
    }
    
    private func prepareItem(_ viewModel: [SearchViewModel], _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibItemSearchCell, for: indexPath) as? ItemSearchCell
        else { return UITableViewCell() }

        let itemViewModel = viewModel[indexPath.row]
        cell.titleLabel.text = itemViewModel.title
        cell.priceLabel.text = itemViewModel.price
        cell.mercadoPriceLabel.text = itemViewModel.mercadoPago
        cell.addressLabel.text = itemViewModel.address
        cell.itemImage.imageFromServerURL(urlString: itemViewModel.thumbnail, defaultImage: .placeholder)
        cell.backgroundColor = .white
        return cell
    }
    
    private func prepareError(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibErrorSearchCell, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
}

extension SearchDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cellTypes = SearchCellTypes.filteredCellTypes(
            viewModel: viewController?.viewModel,
            showError: viewController?.showError ?? false
        )
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let view = viewController else { return .zero }
        let cellType = cellTypes[section]

        switch cellType {
        case .search:
            return 1
        case .items:
            guard let viewModel = view.viewModel else { return .zero }
            tableView.separatorStyle = .singleLine
            tableView.separatorInset = .zero
            return viewModel.count
        case .error:
            guard view.showError else { return .zero }
            tableView.separatorStyle = .none
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewController != nil else { return UITableViewCell() }
        
        let cellSection = cellTypes[indexPath.section]
        let cell: UITableViewCell
        
        switch cellSection {
        case .search:
            cell = prepareSearch(tableView, indexPath)
        case .items:
            guard let viewModel = viewController?.viewModel else {
                tableView.separatorStyle = .none
                return UITableViewCell()
            }
            cell = prepareItem(viewModel, tableView, indexPath)
        case .error:
            cell = prepareError(tableView, indexPath)
        }
        cell.selectionStyle = .none
        return cell
    }
}

