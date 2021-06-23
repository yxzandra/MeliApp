import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : UIImage?) {
        if defaultImage != nil {
            self.image = defaultImage
            self.contentMode = .scaleAspectFit
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                self.contentMode = .scaleAspectFit
            })
            
        }).resume()
    }
}
