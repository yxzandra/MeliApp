import UIKit

class SitesDataSource: NSObject {
    weak var viewController: SitesView?
    let cellTypes = SitesCellTypes.default
    
    private func prepareTitle(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    private func prepareItem(_ viewModel: [SitesViewModel], _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        cell.backgroundColor = .white
        return cell
    }
}
