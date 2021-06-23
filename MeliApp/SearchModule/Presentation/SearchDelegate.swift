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
            viewController?.presenter?.itemSelected(idItem: itemSelected.id)
        }
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }
}
