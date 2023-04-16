//
//  UIView+Layout.swift
//  NGUIKitHelpers
//
//  Created by Thierry on 2023/04/17.
//

import UIKit

extension UIView {
    func pinToSuperview(leading: CGFloat = 0, top: CGFloat = 0, trailing: CGFloat = 0, bottom: CGFloat = 0) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading).isActive = true
        topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -trailing).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
    }

    func pinToSuperview(padding: CGFloat) {
        pinToSuperview(leading: padding, top: padding, trailing: padding, bottom: padding)
    }

    enum UIViewEdge {
        case top
        case left
        case right
        case bottom
    }

    func pinToSuperview(excluding edges: [UIViewEdge], padding: CGFloat = 0) {
        guard let superview else { return }

        var allSet = Set<UIViewEdge>(arrayLiteral: .top, .bottom, .left, .right)
        allSet.subtract(edges)
        translatesAutoresizingMaskIntoConstraints = false
        for edge in allSet {
            switch edge {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
            case .left:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
            case .right:
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
            }
        }
    }

    func pinToSuperviewCenter(dx: CGFloat = 0, dy: CGFloat = 0, restrictEdges: Bool = true) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: dx).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: dy).isActive = true
        if restrictEdges {
            topAnchor.constraint(greaterThanOrEqualTo: superview.topAnchor).isActive = true
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor).isActive = true
        }
    }

    func pinToAnother(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor ~= topAnchor
        view.leadingAnchor ~= leadingAnchor
        view.trailingAnchor ~= trailingAnchor
        view.bottomAnchor ~= bottomAnchor
    }
}

public struct ConstraintAttribute<T: AnyObject> {
    let anchor: NSLayoutAnchor<T>
    let const: CGFloat
}

public struct LayoutGuideAttribute {
    let guide: UILayoutSupport
    let const: CGFloat
}

public func + <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs, const: rhs)
}

public func + (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    return LayoutGuideAttribute(guide: lhs, const: rhs)
}

public func - <T>(lhs: NSLayoutAnchor<T>, rhs: CGFloat) -> ConstraintAttribute<T> {
    return ConstraintAttribute(anchor: lhs, const: -rhs)
}

public func - (lhs: UILayoutSupport, rhs: CGFloat) -> LayoutGuideAttribute {
    return LayoutGuideAttribute(guide: lhs, const: -rhs)
}

@discardableResult
public func ~= (lhs: NSLayoutYAxisAnchor, rhs: UILayoutSupport) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.bottomAnchor)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func ~= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: NSLayoutAnchor<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func ~= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func ~= (lhs: NSLayoutYAxisAnchor, rhs: LayoutGuideAttribute) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalTo: rhs.guide.bottomAnchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func ~= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(equalToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func <= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func <= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(lessThanOrEqualToConstant: rhs)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func >= <T>(lhs: NSLayoutAnchor<T>, rhs: ConstraintAttribute<T>) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.const)
    constraint.isActive = true
    return constraint
}

@discardableResult
public func >= (lhs: NSLayoutDimension, rhs: CGFloat) -> NSLayoutConstraint {
    let constraint = lhs.constraint(greaterThanOrEqualToConstant: rhs)
    constraint.isActive = true
    return constraint
}
