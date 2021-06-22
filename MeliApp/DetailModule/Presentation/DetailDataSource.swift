import UIKit

class DetailDataSource: NSObject {
    typealias Constants = DetailViewConstants.NibCell
    weak var viewController: DetailViewController?
    var cellTypes = DetailCellTypes.default
    
    private func prepareCarousel(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.nibCarouselDetailCell, for: indexPath) as? CarouselDetailCell
        else { return UITableViewCell() }
        cell.loadData(imageList: viewModel.pictures)
        cell.contentView.layoutIfNeeded()
        return cell
    }
    
    private func prepareHeader(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    private func prepareDescription(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
extension DetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewController?.viewModel else { return UITableViewCell() }
        
        let cellSection = cellTypes[indexPath.row]
        let cell: UITableViewCell
        
        switch cellSection {
        case .carousel:
            cell = prepareCarousel(viewModel, tableView, indexPath)
        case .header:
            cell = prepareHeader(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        case .description:
            cell = prepareDescription(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
