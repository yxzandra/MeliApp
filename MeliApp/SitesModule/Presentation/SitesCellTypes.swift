enum SitesCellTypes {
    case header
    case sites
    case error

    static let `default` = [header, sites, error]
}
extension SitesCellTypes {
    static func filteredCellTypes(viewModel: [SiteViewModel]?, showError: Bool) -> [SitesCellTypes] {
        var options = [header]
        if viewModel != nil {
            options.append(sites)
        } else if showError {
            options.append(error)
        }
        return options
    }
}
