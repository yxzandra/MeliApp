import UIKit

class SitesDelegate: NSObject {
    weak var viewController: SitesViewController?
}

extension SitesDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSection = SitesCellTypes.default[indexPath.section]
        switch cellSection {
        case .header:
            break
        case .sites:
            guard let siteSelected = viewController?.viewModel?[indexPath.row] else { return }
            viewController?.presenter?.siteSelected(site: siteSelected)
        }
    }
}
