enum SearchCellTypes {
    case search
    case items
    case error

    static let `default` = [search, items, error]
}

extension SearchCellTypes {
    static func filteredCellTypes(viewModel: [SearchViewModel]?, showError: Bool) -> [SearchCellTypes] {
        var options = [search]
        if viewModel != nil {
            options.append(items)
        } else if showError {
            options.append(error)
        }
        return options
    }
}
