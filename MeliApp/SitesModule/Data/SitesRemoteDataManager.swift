import Alamofire

class SitesRemoteDataManager: SitesRemoteDataManagerInputProtocol {
    private let url = Endpoint.site
    var remoteRequestHandler: SitesRemoteDataManagerOutputProtocol?
    
    convenience init(remoteRequestHandler: SitesRemoteDataManagerOutputProtocol) {
        self.init()
        self.remoteRequestHandler = remoteRequestHandler
    }
    
    func externalGetData() {
        AF.request(url, method: .get).responseJSON { response in
            if response.response?.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let getUrl =  try decoder.decode([Site].self, from: response.data!)
                    self.remoteRequestHandler?.returnData(sites: getUrl)
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
