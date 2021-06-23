import UIKit

class SitesDelegate: NSObject {
    weak var viewController: SitesViewController?
}

extension SitesDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewController?.viewModel
        let isShowError = viewController?.showError ?? false
        let cellTypes = SitesCellTypes.filteredCellTypes(viewModel: viewModel, showError: isShowError)
        let cellSection = cellTypes[indexPath.section]

        switch cellSection {
        case .header:
            break
        case .sites:
            guard let siteSelected = viewModel?[indexPath.row] else { return }
            viewController?.presenter?.siteSelected(site: siteSelected)
        case .error:
            viewController?.presenter?.viewDidLoad()
        }
    }
}
