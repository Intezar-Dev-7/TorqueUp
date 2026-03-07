import 'dart:convert';
import 'package:frontend/features/receptionist/data/services/inventory_service.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/service_locator.dart';

class InventoryRepository {
  final InventoryServices _service = getIt<InventoryServices>();

  Future<void> addProduct(Inventory inventory) async {
    final res = await _service.addProduct(inventory);
    if (res.statusCode != 201) {
      throw jsonDecode(res.body)['error'] ?? 'Failed to add product';
    }
  }

  Future<List<Inventory>> fetchAllProducts() async {
    final res = await _service.fetchAllProducts();
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((item) => Inventory.fromMap(item)).toList();
    } else {
      throw jsonDecode(res.body)['error'] ?? 'Failed to load inventory';
    }
  }

  Future<Inventory> updateProduct(
      String productId,
      int productQuantity,
      int productPrice,
      String productStatus,
      ) async {
    final res = await _service.updateInventoryProduct(
      productId,
      productQuantity,
      productPrice,
      productStatus,
    );
    if (res.statusCode == 200) {
      return Inventory.fromMap(jsonDecode(res.body));
    } else {
      throw jsonDecode(res.body)['error'] ?? 'Failed to update product';
    }
  }

  Future<void> deleteProduct(String productId) async {
    final res = await _service.deleteProduct(productId);
    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['error'] ?? 'Failed to delete product';
    }
  }
}