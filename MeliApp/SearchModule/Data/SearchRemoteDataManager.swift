import Alamofire

class SearchRemoteDataManager:SearchRemoteDataManagerInputProtocol {
    private let url = Endpoint.search
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    convenience init(remoteRequestHandler: SearchRemoteDataManagerOutputProtocol) {
        self.init()
        self.remoteRequestHandler = remoteRequestHandler
    }
    
    func externalSearchItem(item: String, idSite: String) {
        let urlParameter = url.replacingOccurrences(of: "{idSite}", with: idSite)
        let parameters: Parameters = ["q": item]
        AF.request(urlParameter, method: .get, parameters: parameters, encoding: URLEncoding(destination: .queryString)).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode(Search.self, from: response.data!)
                    self.remoteRequestHandler?.returnData(data: getUrl)
                } catch {
                    print(" \(error.localizedDescription)")
                    self.remoteRequestHandler?.errorData()
                }
            } else {
                let statusCode = response.response?.statusCode ?? .zero
                print("Ha ocurrido un error: \(statusCode)")
                self.remoteRequestHandler?.errorData()
            }
        }
    }
}
