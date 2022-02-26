//
//  Spacing.swift
//  TCA-Demo
//
//  Created by Shayan Ali on 24.02.22.
//

import SwiftUI

public enum Constants {
  // InputField dimensions.
  static let textFieldHeight: CGFloat = 47

  // Divider dimensions.
  static let verticalListDividerWidth: CGFloat = 0.5
  static let verticalListDividerHight: CGFloat = 40

  // Main interaction button size.
  static let mainInteractionButtonSize: CGFloat = 100
  static let mainInteractionButtonIconSize: CGFloat = 40

  // Employee collection dimensions.
  static let employeeCollectionMargin = Spacing.huge
  static let employeeCollectionMaxWidth: CGFloat = 100
  static let unavailabilityReasonImageSize: CGFloat = 30
  static let workingStateBackgroundLayoutSize: CGFloat = 27
  static let bubbleBorder: CGFloat = 2
  static let bubbleSize: CGFloat = 65
  static let employeeListBubbleSize: CGFloat = 40
  static let switchSize: CGFloat = 50

  // LazyVGrid rows size in each column.
  static let rowsInSearchablePicker: Int = 4

  // Auto leave screen dimensions.
  static let autoLeaveButtonsSize: CGFloat = 25
  static let autoLeaveButtonIconWidth: CGFloat = 18

  // Text minimum scale factor
  static let defaultMinScaleFactorTitles: CGFloat = 0.8
  static let defaultMinScaleFactorOtherTextStyles: CGFloat = 0.7

  // Hide the unused components in the iOS Terminal Alpha. Remove this check to show the components when needed.
  // https://app.asana.com/0/1198052775553214/1201235305119171/f
  static let showComponent: Bool = false

  // Default corner radius for rounded rectangle.
  static let roundedRectangleCornerRadius: CGFloat = 10.0
}

// Spacing used between layout elements using 4dp Grid.
public enum Spacing {
  static let tiny: CGFloat = 2
  static let extraSmall: CGFloat = 4
  static let small: CGFloat = 8
  static let medium: CGFloat = 12
  static let normal: CGFloat = 16
  static let large: CGFloat = 24
  static let extraLarge: CGFloat = 32
  static let huge: CGFloat = 64
}

// Parent layout padding (Safe area).
enum Padding {
  static let parentHorizontal: CGFloat = Spacing.normal
  static let parentVertical: CGFloat = Spacing.normal
  static let tiny: CGFloat = 4
  static let small: CGFloat = 6
  static let medium: CGFloat = 12
  static let normal: CGFloat = 20
  static let large: CGFloat = 30
}

// Components, buttons and texts default margin.
enum Margin {
  static let component: CGFloat = Spacing.normal
  static let text: CGFloat = Spacing.small
  static let button: CGFloat = Spacing.normal
}

// Radius.
enum Radius {
  static let small: CGFloat = 4
  static let medium: CGFloat = 6
  static let large: CGFloat = 8
  static let extraLarge: CGFloat = 16
  static let extraExtraLarge: CGFloat = 25
}

// Emphasis modifiers for "on" colors.
enum AlphaEmphasis {
  static let high: Double = 0.87
  static let medium: Double = 0.6
  static let disabled: Double = 0.38
  static let half: Double = 0.5
}

// Offset horizontal & vertical distance.
enum Offset {
  static let small: CGFloat = -2
  static let medium: CGFloat = -12
}

// Define the shadow size.
enum ShadowRadius {
  static let tiny: CGFloat = 2
  static let xSmall: CGFloat = 4
  static let small: CGFloat = 8
  static let medium: CGFloat = 16
  static let large: CGFloat = 24
}

