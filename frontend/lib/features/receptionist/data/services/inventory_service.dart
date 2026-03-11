import 'dart:convert';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class InventoryServices {
  Future<http.Response> addProduct(Inventory inventory) async {
    return await http.post(
      Uri.parse('${ApiConfig.baseUrl}/api/addNewProduct'),
      body: inventory.toJson(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<http.Response> fetchAllProducts() async {
    return await http.get(Uri.parse('${ApiConfig.baseUrl}/api/getProducts'));
  }

  Future<http.Response> updateInventoryProduct(
    String productId,
    int productQuantity,
    int productPrice,
    String productStatus,
  ) async {
    return await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/api/updateInventoryProduct/$productId'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        "productQuantity": productQuantity,
        "productPrice": productPrice,
        "productStatus": productStatus,
      }),
    );
  }

  Future<http.Response> deleteProduct(String productId) async {
    return await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/api/deleteProduct/$productId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
