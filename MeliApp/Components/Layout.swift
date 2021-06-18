import UIKit

class Layout {

    class func pin(view: UIView, to superview: UIView, insets: UIEdgeInsets = .zero) {
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
                view.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
                view.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
                view.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
            ])
        }
    }
}
