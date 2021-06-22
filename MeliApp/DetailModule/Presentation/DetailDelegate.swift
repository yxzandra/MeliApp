import UIKit

class DetailDelegate: NSObject {
    weak var viewController: DetailViewController?
}

extension DetailDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellSection = DetailCellTypes.default[indexPath.row]
        switch cellSection {
        case .carousel, .header:
            break
        case .description:
            viewController?.validateDescription()
        }
    }

    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }
}
