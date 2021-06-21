import UIKit

class SearchDelegate: NSObject {
    weak var viewController: SearchViewController?
}

extension SearchDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSection = SearchCellTypes.default[indexPath.section]
        switch cellSection {
        case .search, .error:
            break
        case .items:
            guard let itemSelected = viewController?.viewModel?[indexPath.row] else { return }
            print("item Seleccionado", itemSelected.title)
            //viewController?.presenter?.itemSelected(site: siteSelected)
        }
    }
}
