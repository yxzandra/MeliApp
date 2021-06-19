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
    
    class func center(view: UIView, in superview: UIView, relativeWidth: Bool = false, relativeHeight: Bool = false) {
        centerYAnchor(of: view, in: superview, relativeHeight: relativeHeight)
        centerXAnchor(of: view, in: superview, relativeWidth: relativeWidth)
    }
    
    class func centerXAnchor(of view: UIView, in superview: UIView, relativeWidth: Bool = false) {
        var constraintsToActivate: [NSLayoutConstraint] = [
            view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ]
        if relativeWidth {
            let width = superview.frame.width / 2
            constraintsToActivate += [view.widthAnchor.constraint(equalToConstant: width)]
        }

        NSLayoutConstraint.activate(constraintsToActivate)
    }

    class func centerYAnchor(of view: UIView, in superview: UIView, relativeHeight: Bool = false) {
        var constraintsToActivate: [NSLayoutConstraint] = [
            view.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ]
        if relativeHeight {
            let height = superview.frame.height / 2
            constraintsToActivate += [view.heightAnchor.constraint(equalToConstant: height)]
        }

        NSLayoutConstraint.activate(constraintsToActivate)
    }
    
    class func marginPin(of view: UIView, in superview: UIView, constant: CGFloat = .zero ) {
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
    }
}
