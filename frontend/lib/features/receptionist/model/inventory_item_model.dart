class InventoryItem {
  final String serialNo;
  final String productName;
  final String productCode;
  final int availableQuantity;
  int addQuantity;
  final String productImage;
  final ProductType productType;

  InventoryItem({
    required this.serialNo,
    required this.productName,
    required this.productCode,
    required this.availableQuantity,
    required this.addQuantity,
    required this.productImage,
    required this.productType,
  });
}

enum ProductType {
  oil,
  tyre,
}