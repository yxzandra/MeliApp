import XCTest
@testable import MeliApp

class LayoutTests: TestCase {
    var view: UIView!
    var superview: UIView!

    override func setUp() {
        super.setUp()
        view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        superview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func tearDown() {
        for subview in superview.subviews.reversed() {
            subview.removeFromSuperview()
        }
        view = nil
        superview = nil
        super.tearDown()
    }

    func testPinView() {
        superview.addAutoLayout(subview: view)
        Layout.pin(view: view, to: superview)
        assert(pin: view, superview: superview)
    }

    func testCenterViewInSuperview() {
        superview.addAutoLayout(subview: view)
        Layout.center(view: view, in: superview)
        assert(center: view, superview: superview)
    }

    func testCenterViewInSuperviewRelativeWidth() {
        superview.addAutoLayout(subview: view)
        Layout.center(view: view, in: superview, relativeWidth: true)
        assert(center: view, superview: superview, relativeWidth: true)
    }

    func testCenterViewInSuperviewRelativeHeight() {
        superview.addAutoLayout(subview: view)
        Layout.center(view: view, in: superview, relativeHeight: true)
        assert(center: view, superview: superview, relativeHeight: true)
    }

    private func assert(pin view: UIView, superview: UIView) {
        assert(attributes: [.top, .bottom, .leading, .trailing], view: view, superview: superview)
    }

    private func assert(center view: UIView, superview: UIView, relativeWidth: Bool = false, relativeHeight: Bool = false) {
        assert(attributes: [.centerX, .centerY], view: view, superview: superview)
        if relativeWidth {
            guard let widthConstraint = view.constraints.filter({ $0.firstAttribute == .width }).first else {
                XCTFail("No width constraint")
                return
            }
            let width = superview.frame.width / 2
            XCTAssertEqual(width, widthConstraint.constant)
        } else if relativeHeight {
            guard let heightConstraint = view.constraints.filter({ $0.firstAttribute == .height }).first else {
                XCTFail("No height constraint")
                return
            }
            let height = superview.frame.height / 2
            XCTAssertEqual(height, heightConstraint.constant)
        }
    }

    private func assert(attributes: [NSLayoutConstraint.Attribute], view: UIView, superview: UIView) {
        let constraints = superview.constraints
        XCTAssertFalse(constraints.isEmpty)
        if #available(iOS 11.0, *) {
            for constraint in constraints {
                if
                    let firstItem = constraint.firstItem as? UIView,
                    let secondItem = constraint.secondItem as? UILayoutGuide {
                    for attribute in attributes {
                        switch constraint.firstAttribute {
                        case attribute:
                            XCTAssertEqual(secondItem, superview.safeAreaLayoutGuide)
                            if constraint.identifier != nil {
                                XCTAssertEqual(firstItem, superview)
                            } else {
                                XCTAssertEqual(firstItem, view)
                            }
                        default:
                            continue
                        }
                    }
                } else if
                    let firstItem = constraint.firstItem as? UILayoutGuide,
                    let secondItem = constraint.secondItem as? UIView {
                    for attribute in attributes {
                        switch constraint.firstAttribute {
                        case attribute:
                            XCTAssertEqual(firstItem, superview.safeAreaLayoutGuide)
                            if constraint.identifier != nil {
                                XCTAssertEqual(secondItem, superview)
                            } else {
                                XCTAssertEqual(secondItem, view)
                            }
                        default:
                            continue
                        }
                    }
                } else if
                    let firstItem = constraint.firstItem as? UIView,
                    let secondItem = constraint.secondItem as? UIView {
                    for attribute in attributes {
                        switch constraint.firstAttribute {
                        case attribute:
                            XCTAssertEqual(firstItem, view)
                            XCTAssertEqual(secondItem, superview)
                        default:
                            continue
                        }
                    }
                } else {
                    XCTFail("No items found")
                    return
                }
            }
        } else {
            for constraint in constraints {
                guard
                    let firstItem = constraint.firstItem as? UIView,
                    let secondItem = constraint.secondItem as? UIView
                else {
                    XCTFail("No items found")
                    return
                }
                for attribute in attributes {
                    switch constraint.firstAttribute {
                    case attribute:
                        XCTAssertEqual(secondItem, superview)
                        XCTAssertEqual(firstItem, view)
                    default:
                        continue
                    }
                }
            }
        }
    }
}

