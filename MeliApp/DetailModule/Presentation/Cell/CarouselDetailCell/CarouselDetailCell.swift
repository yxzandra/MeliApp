import UIKit

class CarouselDetailCell: UITableViewCell {
    @IBOutlet weak var carouselScroll: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageBackground: UIImageView!
    
    private let withScreen = UIScreen.main.bounds.size.width
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselScroll.delegate = self
        prepareCarouselScroll()
        preparePageControl()
        prepareContentView()
    }
    
    func loadData(imageList: [String]) {
        imageBackground.isHidden = true
        loadImages(imageList)
        
        pageControl.numberOfPages = imageList.count
        pageControl.currentPage = .zero
        pageControl.currentPageIndicatorTintColor = .titleColor
        pageControl.tintColor = .gray
        pageControl.pageIndicatorTintColor = .lightGray
    }
    
    func loadPlaceholderBackground() {
        imageBackground.isHidden = false
        Layout.center(view: imageBackground, in: contentView)
    }
    
    private func loadImages(_ imageList: [String]) {
        for (index, image) in imageList.enumerated() {
            let imgView = UIImageView()
            imgView.imageFromServerURL(urlString: image, defaultImage: .placeholder)
            imgView.clipsToBounds = true
            carouselScroll.addAutoLayout(subview: imgView)
            imgView.adjustsImageSizeForAccessibilityContentSizeCategory = true
            
            NSLayoutConstraint.activate([
                imgView.heightAnchor.constraint(equalTo: carouselScroll.heightAnchor),
                imgView.widthAnchor.constraint(equalTo: carouselScroll.widthAnchor),
                imgView.leadingAnchor.constraint(equalTo: carouselScroll.leadingAnchor, constant: withScreen * CGFloat(index))
            ])
        }
        carouselScroll.contentSize = CGSize(width: CGFloat(imageList.count) * withScreen, height: carouselScroll.frame.height)
    }

    private func prepareCarouselScroll(){
        carouselScroll.isPagingEnabled = true
        carouselScroll.alwaysBounceHorizontal = true
        carouselScroll.showsHorizontalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            carouselScroll.heightAnchor.constraint(equalToConstant: 160),
            carouselScroll.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
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
