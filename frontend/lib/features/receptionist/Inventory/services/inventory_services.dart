import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_snack_bar.dart';
import 'package:frontend/features/receptionist/model/inventory_model.dart';
import 'package:frontend/utils/constant/api.dart';
import 'package:http/http.dart' as http;

class InventoryServices {
  Future<void> addProducts({
    required BuildContext context,
    required String productName,
    required int productQuantity,
    required int productPrice,
    required String productStatus,
    required Uint8List? productImageBytes,
    required String? productImageName,
  }) async {
    try {
      Inventory inventory = Inventory(
        productId: '',
        productName: productName,
        productQuantity: productQuantity,
        productPrice: productPrice,
        productStatus: productStatus,
        productImageBytes: productImageBytes, // pass bytes
        productImageName: productImageName, // pass filename
      );

      // sending a post request to the backend
      http.Response res = await http.post(
        Uri.parse('$uri/api/addNewProduct'),
        body: inventory.toJson(),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Inform backend we're sending JSON
        },
      );
      print("Response: ${res.statusCode} - ${res.body}");

      if (res.statusCode == 201) {
        final responseData = jsonDecode(res.body);
        print(responseData);
        CustomSnackBar.show(
          context,
          message: "Product added successfully!",
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        );
      } else {
        final error = jsonDecode(res.body);
        print(error);
        CustomSnackBar.show(
          context,
          message: 'Something went wrong ',
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: '$e',
        backgroundColor: Colors.redAccent,
      );
    }
  }

  Future<List<Inventory>> fetchAllProducts({
    required BuildContext context,
  }) async {
    try {
      final response = await http.get(Uri.parse('$uri/api/getProducts'));
      print("Raw API response: ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print("Decoded response: $response.body");
        return data.map((item) => Inventory.fromMap(item)).toList();
      } else {
        CustomSnackBar.show(
          context,
          message: 'Failed to fetch products',
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: '$e',
        backgroundColor: Colors.redAccent,
      );
    }
    return [];
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required String productId,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse('$uri/api/deleteProduct/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        CustomSnackBar.show(
          context,
          message: "Booking deleted successfully",
          backgroundColor: Colors.lightGreenAccent,
        );
      } else {
        CustomSnackBar.show(
          context,
          message: "Failed to delete product",
          backgroundColor: Colors.redAccent,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "Error: $e",
        backgroundColor: Colors.redAccent,
      );
    }
  }
}
