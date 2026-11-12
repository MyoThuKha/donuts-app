/// Layout numbers used only by Product detail.
abstract final class ProductDimens {
  /// The product image's width as a share of the card's.
  static const double imageWidthFactor = 0.6;

  static const double stepperHeight = 52;

  /// The visible circle of a stepper button. Its tap area is larger.
  static const double stepperButton = 28;
  static const double stepperTapTarget = 44;
  static const double stepperIcon = 16;

  /// Wide enough for "99" in the title style, so the buttons don't shift.
  static const double stepperNumberWidth = 40;

  static const double whatsThisDot = 10;
  static const double whatsThisColumnWidth = 64;
  static const double dividerThickness = 1;
  static const double totalDividerHeight = 16;
}
