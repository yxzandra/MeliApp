class SiteMapper {
    
    func reverseMap(value: Site) -> SiteViewModel {
        let viewModel = SiteViewModel(id: value.id, name: value.name)
        return viewModel
    }
    
    func reverseMap(values: [Site]) -> [SiteViewModel] {
        var newValues = [SiteViewModel]()
        values.forEach { value in
            newValues.append(reverseMap(value: value))
        }
        return newValues
    }
}
