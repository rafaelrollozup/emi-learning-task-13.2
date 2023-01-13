//
//  ConstraintHelpers+UIView.swift
//  LearningTask-13.2
//
//

import UIKit

extension UIView {

    // MARK: - SafeArea Anchors
    private var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    private var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leadingAnchor
    }

    private var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.trailingAnchor
    }

    private var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    // MARK: - Containing Helpers
    
    /// Constrains the bounds of your view code component to the bounds of its superview
    /// from the given components.
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - verticalMargin: The margin to apply as the constant of the top and bottom anchor constraints
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor constraints
    ///
    func constrainTo(edgesOf view: UIView,
                     verticalMargins verticalMargin: CGFloat = .zero,
                     horizontalMargins horizontalMargin: CGFloat = .zero) {
        let constraints = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: verticalMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the bounds of your view code component to the bounds of the
    /// safeAreaLayoutGuide of its superview
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to `safeAreaLayoutGuide`
    ///     - verticalMargin: The margin to apply as the constant of the top and bottom anchor constraints
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchors constraints
    ///
    func constrainTo(safeEdgesOf view: UIView,
                     verticalMargins verticalMargin: CGFloat = 0,
                     horizontalMargins horizontalMargin: CGFloat = 0) {
        let constraints = [
            topAnchor.constraint(equalTo: view.safeTopAnchor, constant: verticalMargin),
            leadingAnchor.constraint(equalTo: view.safeLeadingAnchor, constant: horizontalMargin),
            bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -verticalMargin),
            trailingAnchor.constraint(equalTo: view.safeTrailingAnchor, constant: -horizontalMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the top of your view code component to the top of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to the topAnchor
    ///     - margin: The margin to apply as the constant of the top anchor constraint
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s topAnchor
    ///     instead of the default one
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainToTop(of view: UIView,
                        withMargin margin: CGFloat = 0,
                        notchSafe: Bool = false) -> NSLayoutConstraint {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor
        let constraint = self.topAnchor.constraint(equalTo: topAnchor, constant: margin)

        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    /// Constrains the top and leading of your view code component to the
    /// same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - topMargin: The margin to apply as the constant of the top anchor constraint
    ///     - leadingMargin: The margin to apply as the constant of the leading anchor constraint
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     topAnchor instead of the default one
    ///
    func constrainToTopAndLeading(of view: UIView,
                                  topMargin: CGFloat = 0,
                                  leadingMargin: CGFloat = 0,
                                  notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor

        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the top and trailing of your view code component to the
    /// same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - topMargin: The margin to apply as the constant of the top anchor constraint
    ///     - trailingMargin: The margin to apply as the constant of the trailing anchor constraint
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     topAnchor instead of the default one
    ///
    func constrainToTopAndTrailing(of view: UIView,
                                  topMargin: CGFloat = 0,
                                  trailingMargin: CGFloat = 0,
                                  notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor

        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: trailingMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the top, leading, and trailing of your view code component to
    /// the same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - topMargin: The margin to apply as the constant of the top anchor constraint
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor contraints
    ///     - notchSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s topAnchor
    ///     instead of the default one
    ///
    func constrainToTopAndSides(of view: UIView,
                                topMargin: CGFloat = 0,
                                horizontalMargins horizontalMargin: CGFloat = 0,
                                notchSafe: Bool = false) {
        let topAnchor = notchSafe ? view.safeTopAnchor : view.topAnchor

        let constraints = [
            self.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the leading of your view code component to the leading of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to the leading anchor
    ///     - margin: The margin to apply as the constant of the leading anchor constraint
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainToLeading(of view: UIView,
                            withMargin margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }

    /// Constrains the trailing of your view code component to the trailing of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to the trailing anchor
    ///     - margin: The margin to apply as the constant of the trailing anchor constraint
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainToTrailing(of view: UIView,
                            withMargin margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    /// Constrains the bottom of your view code component to the bottom of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to the bottom anchor
    ///     - margin: The margin to apply as the constant of the bottom anchor constraint
    ///     - footerSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s bottom
    ///     anchor instead of the default one
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainToBottom(of view: UIView,
                           withMargin margin: CGFloat = 0,
                           footerSafe: Bool = false) -> NSLayoutConstraint {
        let bottomAnchor = footerSafe ? view.safeBottomAnchor : view.bottomAnchor
        let constraint = self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin)

        constraint.isActive = true
        return constraint
    }

    /// Constrains the bottom, leading, and trailing of your view code component to
    /// the same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - bottomMargin: The margin to apply as the constant of the bottom anchor constraint
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor contraints
    ///     - footerSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     bottom anchor instead of the default one
    ///
    func constrainToBottomAndSides(of view: UIView,
                                   bottomMargin: CGFloat = 0,
                                   horizontalMargins horizontalMargin: CGFloat = 0,
                                   footerSafe: Bool = false) {
        let bottomAnchor = footerSafe ? view.safeBottomAnchor : view.bottomAnchor

        let constraints = [
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the bottom and leading of your view code component to the
    /// same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - bottomMargin: The margin to apply as the constant of the bottom anchor constraint
    ///     - leadingMargin: The margin to apply as the constant of the leading anchor constraint
    ///     - footerSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     bottom anchor instead of the default one
    ///
    func constrainToBottomAndLeading(of view: UIView,
                                  bottomMargin: CGFloat = 0,
                                  leadingMargin: CGFloat = 0,
                                  footerSafe: Bool = false) {
        let bottomAnchor = footerSafe ? view.safeBottomAnchor : view.bottomAnchor

        let constraints = [
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomMargin),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the bottom and trailing of your view code component to the
    /// same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - bottomMargin: The margin to apply as the constant of the bottom anchor constraint
    ///     - trailingMargin: The margin to apply as the constant of the trailing anchor constraint
    ///     - footerSafe: A boolean that flags whether it should use the `safeAreaLayoutGuide`'s
    ///     bottom anchor instead of the default one
    ///
    func constrainToBottomAndTrailing(of view: UIView,
                                  bottomMargin: CGFloat = 0,
                                  trailingMargin: CGFloat = 0,
                                  footerSafe: Bool = false) {
        let bottomAnchor = footerSafe ? view.safeBottomAnchor : view.bottomAnchor

        let constraints = [
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the leading and trailing of your view code component to the same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - horizontalMargin: The margin to apply as the constant of the leading and trailing anchor contraints
    ///
    func constrainHorizontally(to view: UIView,
                               withMargins horizontalMargin: CGFloat = 0) {
        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    /// Constrains the top and bottom of your view code component to the same edges of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to constrain to
    ///     - horizontalMargin: The margin to apply as the constant of the top and bottom anchor contraints
    ///
    func constrainVertically(to view: UIView,
                             withMargins verticalMargin: CGFloat = 0) {
        let constraints = [
            topAnchor.constraint(equalTo: view.topAnchor, constant: verticalMargin),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalMargin),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Positioning Helpers
    
    /// Positions your view code component above the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor above
    ///     - margin: The margin to apply as the constant of the constraint that adds some spacing
    ///     between the view bottom anchor and the target view's top anchor
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func anchorAbove(of view: UIView, withMargin margin: CGFloat) -> NSLayoutConstraint {
        let constraint = self.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -margin)
        constraint.isActive = true
        return constraint
    }
    
    /// Positions your view code component below the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor below
    ///     - margin: The margin to apply as the constant of the constraint that adds some spacing
    ///     between the view top anchor and the target view's bottom anchor
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func anchorBelow(of view: UIView, withMargin margin: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: margin)
        constraint.isActive = true
        return constraint
    }
    
    /// Positions your view code component on leading of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor on leading
    ///     - margin: The margin to apply as the constant of the constraint that adds some spacing between the view leading anchor and the target view's trailing anchor
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func anchorTo(leadingOf view: UIView, withMargin margin: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = self.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -margin)
        constraint.isActive = true
        return constraint
    }
    
    /// Positions your view code component on trailing of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor on trailing
    ///     - margin: The margin to apply as the constant of the constraint that adds some spacing between the view trailing anchor and the target view's leading anchor
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func anchorOn(trailingOf view: UIView, withMargin margin: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = self.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin)
        constraint.isActive = true
        return constraint
    }
    
    /// Positions your view code component centering on the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor centering
    ///     - point: The point containing the x and y axis offset to apply as the constant of the
    ///     centerX and centerY anchor constraints
    ///
    func anchorToCenter(of view: UIView, withOffset point: CGPoint = .zero) {
        let constraints = [
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: point.x),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: point.y)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    /// Positions your view code component centering on the X axis of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor center horizontally
    ///     - offset: A float representing the offset to apply as the constant of the
    ///     centerX anchor constraint
    ///
    @discardableResult
    func anchorToCenterX(of view: UIView, withOffset offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = self.centerXAnchor
            .constraint(equalTo: view.centerXAnchor, constant: offset)

        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    /// Positions your view code component centering on the Y axis of the target view
    ///
    /// - Parameters:
    ///     - view: The target view to anchor center vertically
    ///     - offset: A float representing the offset to apply as the constant of the
    ///     centerY anchor constraint
    ///
    @discardableResult
    func anchorToCenterY(of view: UIView, withOffset offset: CGFloat = .zero) -> NSLayoutConstraint {
        let constraint = self.centerYAnchor
            .constraint(equalTo: view.centerYAnchor, constant: offset)

        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    
    // MARK: - Sizing Helpers
    
    /// Constrains the size of your view code component
    ///
    /// - Parameters:
    ///     - size: The `CGSize` representing the desired size to the view.
    ///     Define the constants of the widthAnchor and heightAnchor constraints
    ///
    func constrainSize(to size: CGSize) {
        let constraints = [
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    /// Constrains the width of your view code component
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the desired width to the view.
    ///     Define the constant of the widthAnchor constraint
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainWidth(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    /// Constrains the width of your view code component by the width of the target view
    ///
    /// - Parameters:
    ///     - view: The target view that have the referenced width anchor
    ///     - ratio: The `CGFloat` representing the ratio to apply as a multiplier of the width anchor's value
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainWidth(referencedBy view: UIView, withRatio ratio: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the width of your view code component with the `lessThanOrEqual` relation
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the maximum desired width to the view.
    ///     Define the constant of the widthAnchor constraint with the `lessThanOrEqual` relation
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainWidth(lessThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the width of your view code component with the `greaterThanOrEqual` relation
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the minimum desired height to the view.
    ///     Define the constant of the widthAnchor constraint with the `greaterThanOrEqual` relation
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainWidth(greaterThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the width of your view code component by calculating proportionally from the height value
    ///
    /// - Parameters:
    ///     - ratio: The `CGFloat` representing the ratio to apply as a multiplier of the width anchor's value
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainWidthProportionally(byApplying ratio: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the height of your view code component
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the desired height to the view.
    ///     Define the constant of the heightAnchor constraint
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeight(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the height of your view code component by the height of the target view
    ///
    /// - Parameters:
    ///     - view: The target view that have the referenced height anchor
    ///     - ratio: The `CGFloat` representing the ratio to apply as a multiplier of the height anchor's value
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeight(referencedBy view: UIView, withRatio ratio: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the height of your view code component with the `lessThanOrEqual` relation
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the maximum desired height to the view.
    ///     Define the constant of the heightAnchor constraint with the `lessThanOrEqual` relation
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeight(lessThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the height of your view code component with the `greaterThanOrEqual` relation
    ///
    /// - Parameters:
    ///     - constant: The `CGFloat` representing the minimum desired height to the view.
    ///     Define the constant of the heightAnchor constraint with the `greaterThanOrEqual` relation
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeight(greaterThanOrEqualTo constant: CGFloat) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    /// Constrains the height of your view code component by calculating proportionally from the width value
    ///
    /// - Parameters:
    ///     - ratio: The `CGFloat` representing the ratio to apply as a multiplier of the height anchor's value
    ///
    /// - Returns: The activated layout constraint's reference
    ///
    @discardableResult
    func constrainHeightProportionally(byApplying ratio: CGFloat = 1) -> NSLayoutConstraint {
        let constraint = self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ratio)
        constraint.isActive = true
        return constraint
    }

}

