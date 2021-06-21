import UIKit

class SitesDataSource: NSObject {
    typealias Constants = SitesViewConstants
    weak var viewController: SitesViewController?
    var cellTypes = SitesCellTypes.default
    
    private func prepareTitle(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibTitleSiteCell, for: indexPath)
        return cell
    }
    
    private func prepareItem(_ viewModel: [SiteViewModel], _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibItemSiteCell, for: indexPath) as? ItemSiteCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel[indexPath.item].name
        return cell
    }
    
    private func prepareError(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibErrorSiteCell, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
}

extension SitesDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cellTypes = SitesCellTypes.filteredCellTypes(
            viewModel: viewController?.viewModel,
            showError: viewController?.showError ?? false
        )
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let view = viewController else { return .zero }
        let cellType = cellTypes[section]

        switch cellType {
        case .header:
            return 1
        case .sites:
            guard let viewModel = view.viewModel else { return .zero }
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
        case .header:
            cell = prepareTitle(tableView, indexPath)
        case .sites:
            guard let viewModel = viewController?.viewModel else {
                tableView.separatorStyle = .none
                return UITableViewCell()
            }
            cell = prepareItem(viewModel, tableView, indexPath)
        case .error:
            cell = prepareError(tableView, indexPath)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
