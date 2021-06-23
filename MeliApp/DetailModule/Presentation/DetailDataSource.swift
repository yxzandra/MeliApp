import UIKit

class DetailDataSource: NSObject {
    typealias Constants = DetailViewConstants
    weak var viewController: DetailViewController?
    var cellTypes = DetailCellTypes.default
    
    private func prepareCarousel(_ viewModel: DetailViewModel?, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibCarouselDetailCell, for: indexPath) as? CarouselDetailCell
        else { return UITableViewCell() }

        if let imageList = viewModel?.pictures {
            cell.loadData(imageList: imageList)
        } else {
            cell.loadPlaceholderBackground()
        }
        return cell
    }
    
    private func prepareHeader(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibHeaderDetailCell, for: indexPath) as? HeaderDetailCell
        else { return UITableViewCell() }
        cell.titleLabel.text = viewModel.title
        cell.priceLabel.text = viewModel.price
        cell.warantyLabel.text = viewModel.warranty
        cell.soldQuantityLabel.text = String(format: Constants.soldFormat, viewModel.soldQuantity)
        cell.avalilableQuantityLabel.text = String(format: Constants.availableFormat, viewModel.availableQuantity)
        
        return cell
    }
    
    private func prepareDescription(_ viewModel: DetailViewModel, _ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibDescriptionDetailCell, for: indexPath) as? DescriptionDetailCell
        else { return UITableViewCell() }
        
        cell.setDescription(
            description: viewModel.description ?? "",
            isShow: viewController?.showDescription ?? false
        )
        
        return cell
    }
    
    private func prepareError(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NibCell.nibErrorDetailCell, for: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
}
extension DetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTypes = DetailCellTypes.filteredCellTypes(
            viewModel: viewController?.viewModel,
            showError: viewController?.showError ?? false
        )
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let view = viewController else { return UITableViewCell() }
        
        let cellSection = cellTypes[indexPath.row]
        let cell: UITableViewCell
        
        switch cellSection {
        case .carousel:
            cell = prepareCarousel(viewController?.viewModel, tableView, indexPath)
        case .header:
            guard let viewModel = view.viewModel else {
                tableView.separatorStyle = .none
                return UITableViewCell()
            }
            cell = prepareHeader(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        case .description:
            guard let viewModel = view.viewModel else {
                tableView.separatorStyle = .none
                return UITableViewCell()
            }
            cell = prepareDescription(viewModel, tableView, indexPath)
            cell.backgroundColor = .clear
        case .error:
            cell = prepareError(tableView, indexPath)
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
