// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

/// This file defines the `Inventory` model class which represents a
/// single product in the inventory system.
///
/// Purpose:
/// - To provide a structured way to store and manage inventory data.
/// - To facilitate converting inventory data to/from JSON or Map, which
///   is essential for API calls and local storage.
/// - To allow easy copying and modification of inventory objects.

class Inventory {
  final String productId;
  final String productName;
  final int productQuantity;
  final int productPrice;

  /// Status of the product (e.g., 'In Stock', 'Low Stock', 'Out of Stock').
  final String productStatus;

  // field for image
  final Uint8List? productImageBytes;
  final String? productImageName;

  /// Constructor for creating an Inventory object.
  Inventory({
    required this.productId,
    required this.productName,
    required this.productQuantity,
    required this.productPrice,
    required this.productStatus,
    required this.productImageBytes,
    required this.productImageName,
  });

  /// Converts the Inventory object to a Map.
  /// Useful for storing in databases or sending to APIs.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': productId,
      'productName': productName,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'productStatus': productStatus,
      'productImageBase64':
          productImageBytes != null ? base64Encode(productImageBytes!) : null,
      'productImageName': productImageName,
    };
  }

  /// Factory constructor to create an Inventory object from a Map.
  /// Useful for parsing data from APIs or databases.
  factory Inventory.fromMap(Map<String, dynamic> map) {
    return Inventory(
      productId: map['_id'] as String,
      productName: map['productName'] as String,
      productQuantity: map['productQuantity'] as int,
      productPrice: map['productPrice'] as int,
      productStatus: map['productStatus'] as String,
      productImageBytes:
          map['productImageBase64'] != null
              ? base64Decode(map['productImageBase64'] as String)
              : null,
      productImageName: map['productImageName'] as String?,
    );
  }

  /// Converts the Inventory object to a JSON string.
  /// Useful for sending data to APIs.
  String toJson() => json.encode(toMap());

  /// Factory constructor to create an Inventory object from a JSON string.
  /// Useful for parsing JSON responses from APIs.
  factory Inventory.fromJson(String source) =>
      Inventory.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Creates a copy of the current Inventory object with optional updated fields.
  /// Useful when updating a single field without modifying the original object.
  Inventory copyWith({
    String? productId,
    String? productName,
    int? productQuantity,
    int? productPrice,
    String? productStatus,
    Uint8List? productImageBytes,
    String? productImageName,
  }) {
    return Inventory(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productQuantity: productQuantity ?? this.productQuantity,
      productPrice: productPrice ?? this.productPrice,
      productStatus: productStatus ?? this.productStatus,
      productImageBytes: productImageBytes ?? this.productImageBytes,
      productImageName: productImageName ?? this.productImageName,
    );
  }
}
