import UIKit

class DetailDelegate: NSObject {
    weak var viewController: DetailViewController?
}

extension DetailDelegate: UITableViewDelegate {
    func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, estimatedHeightForRowAt: indexPath)
    }
}

