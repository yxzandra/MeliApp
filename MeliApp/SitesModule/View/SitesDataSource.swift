import UIKit

class SitesDataSource: NSObject {
    typealias Constants = SitesViewConstants
    weak var viewController: SitesViewController?
    let cellTypes = SitesCellTypes.default
    
    private func prepareTitle(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibTitleSiteCell, for: indexPath)
        return cell
    }
    
    private func prepareItem(_ viewModel: [SiteViewModel], _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibItemSiteCell, for: indexPath) as? ItemSiteCell else { return UITableViewCell() }
        cell.nameLabel.text = viewModel[indexPath.item].name
        return cell
    }
}

extension SitesDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard viewController?.viewModel != nil else { return .zero }
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewController?.viewModel else { return .zero }
        let cellType = cellTypes[section]

        switch cellType {
        case .header:
            return 1
        case .sites:
            return viewModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewController?.viewModel else { return UITableViewCell() }
        
        let cellSection = cellTypes[indexPath.section]
        let cell: UITableViewCell
        
        switch cellSection {
        case .header:
            cell = prepareTitle(tableView, indexPath)
        case .sites:
            cell = prepareItem(viewModel, tableView, indexPath)
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
