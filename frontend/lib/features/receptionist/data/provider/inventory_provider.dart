import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/base_provider.dart';
import 'package:frontend/features/receptionist/data/repository/inventory_repo.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/service_locator.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';

class InventoryProvider extends BaseProvider {
  final InventoryRepository _repo = getIt<InventoryRepository>();

  List<Inventory> _inventoryList = [];
  List<Inventory> get inventoryList => _inventoryList;

  Future<void> loadAllProducts({required BuildContext context}) async {
    setLoading(true);
    setError(null);
    try {
      _inventoryList = await _repo.fetchAllProducts();
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }

  Future<bool> addProduct({
    required BuildContext context,
    required String productName,
    required int productQuantity,
    required int productPrice,
    required String productStatus,
    required Uint8List? productImageBytes,
    required String? productImageName,
  }) async {
    setLoading(true);
    setError(null);
    try {
      Inventory inventory = Inventory(
        productId: '',
        productName: productName,
        productQuantity: productQuantity,
        productPrice: productPrice,
        productStatus: productStatus,
        productImageBytes: productImageBytes,
        productImageName: productImageName,
      );

      await _repo.addProduct(inventory);
      CustomSnackBar.show(context, message: "Product added successfully!", backgroundColor: Colors.green);
      await loadAllProducts(context: context); // Refresh list
      return true; // Return true on success so forms can close
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "$e", backgroundColor: Colors.redAccent);
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> updateProduct({
    required BuildContext context,
    required String productId,
    required int productQuantity,
    required int productPrice,
    required String productStatus,
  }) async {
    setLoading(true);
    setError(null);
    try {
      final updatedProduct = await _repo.updateProduct(productId, productQuantity, productPrice, productStatus);

      // Update local list directly for fast UI feedback
      final index = _inventoryList.indexWhere((p) => p.productId == productId);
      if (index != -1) {
        _inventoryList[index] = updatedProduct;
      }
      CustomSnackBar.show(context, message: "Product Updated Successfully", backgroundColor: Colors.lightGreenAccent);
      return true;
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "$e", backgroundColor: Colors.redAccent);
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required String productId,
  }) async {
    setLoading(true);
    setError(null);
    try {
      await _repo.deleteProduct(productId);
      _inventoryList.removeWhere((item) => item.productId == productId);
      CustomSnackBar.show(context, message: "Product deleted successfully", backgroundColor: Colors.lightGreenAccent);
    } catch (e) {
      setError(e.toString());
      CustomSnackBar.show(context, message: "Error: $e", backgroundColor: Colors.redAccent);
    } finally {
      setLoading(false);
    }
  }
}