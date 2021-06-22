import UIKit

class CarouselDetailCell: UITableViewCell {
    @IBOutlet weak var carouselScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageList = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselScroll.delegate = self
        prepareCarouselScroll()
        preparePageControl()
        prepareContentView()
    }
    
    func loadData(imageList: [String]) {
        let bounds = UIScreen.main.bounds.size.width
        
        for (index, image) in imageList.enumerated() {
            let imgView = UIImageView()
            imgView.imageFromServerURL(urlString: image, defaultImage: "placeholder")
            imgView.clipsToBounds = true
            carouselScroll.addAutoLayout(subview: imgView)
            imgView.heightAnchor.constraint(equalTo: carouselScroll.heightAnchor).isActive = true
            imgView.widthAnchor.constraint(equalTo: carouselScroll.widthAnchor).isActive = true
            imgView.adjustsImageSizeForAccessibilityContentSizeCategory = true
            
            imgView.leadingAnchor.constraint(equalTo: carouselScroll.leadingAnchor, constant: bounds * CGFloat(index)).isActive = true
        }
        carouselScroll.contentSize = CGSize(width: CGFloat(imageList.count) * bounds, height: carouselScroll.frame.height)
        
        pageControl.numberOfPages = imageList.count
        pageControl.currentPage = .zero
        pageControl.currentPageIndicatorTintColor = .titleColor
        pageControl.tintColor = .gray
        pageControl.pageIndicatorTintColor = .lightGray
    }
    
    private func prepareCarouselScroll(){
        carouselScroll.isPagingEnabled = true
        carouselScroll.alwaysBounceHorizontal = true
        carouselScroll.showsHorizontalScrollIndicator = false
        carouselScroll.heightAnchor.constraint(equalToConstant: 160).isActive = true
        carouselScroll?.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        Layout.pin(view: carouselScroll, to: contentView)
    }
    
    private func preparePageControl(){
        pageControl.topAnchor.constraint(
            equalTo: carouselScroll.bottomAnchor
        ).isActive = true
        Layout.marginPin(of: pageControl, in: contentView, constant: CGFloat(30))
    }
    
    private func prepareContentView() {
        contentView.bottomAnchor.constraint(
            equalTo: pageControl.bottomAnchor,
            constant: CGFloat(20)
        ).isActive = true
    }
}

extension CarouselDetailCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(carouselScroll.contentOffset.x/contentView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
}
