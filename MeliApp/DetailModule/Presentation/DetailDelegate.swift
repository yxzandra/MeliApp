import UIKit

class DetailDelegate: NSObject {
    weak var viewController: DetailViewController?
}

extension DetailDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let view = viewController else { return }
        let viewModel = view.viewModel
        
        let cellTypes = DetailCellTypes.filteredCellTypes(viewModel: viewModel, showError: view.showError)
        let cellSection = cellTypes[indexPath.row]
        
        switch cellSection {
        case .carousel, .header:
            break
        case .description:
            viewController?.validateDescription()
        case .error:
            viewController?.presenter?.viewDidLoad(idItem: view.idItem)
        }
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }
}
