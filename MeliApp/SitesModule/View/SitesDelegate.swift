import UIKit

class SitesDelegate: NSObject {
    weak var viewController: SitesView?
}

extension SitesDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let siteSelected = viewController?.viewModel?[indexPath.row] else { return }
        viewController?.presenter?.siteSelected(site: siteSelected)
    }
}
