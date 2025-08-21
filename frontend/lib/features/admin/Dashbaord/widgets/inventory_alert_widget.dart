import 'package:flutter/material.dart';
import 'package:frontend/features/admin/data/dummy_data.dart';
import 'package:frontend/features/receptionist/model/inventory_item_model.dart';

class InventoryAlertWidget extends StatefulWidget {
  const InventoryAlertWidget({super.key});

  @override
  _InventoryAlertWidgetState createState() => _InventoryAlertWidgetState();
}

class _InventoryAlertWidgetState extends State<InventoryAlertWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTableHeader(),
            _buildInventoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.warning, color: Colors.red, size: 18),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Inventory status alert",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle see all action
            },
            child: TextButton(
              onPressed: () {},
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isCompact = constraints.maxWidth < 600;

          if (isCompact) {
            return Row(
              children: [
                Expanded(flex: 1, child: _headerText("S. No")),
                Expanded(flex: 3, child: _headerText("Product")),
                Expanded(flex: 2, child: _headerText("Available Q.")),
                Expanded(flex: 2, child: _headerText("Add Q.")),
                Expanded(flex: 2, child: _headerText("Cart")),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(flex: 1, child: _headerText("S. No")),
                Expanded(flex: 4, child: _headerText("Product")),
                Expanded(flex: 2, child: _headerText("Available Q.")),
                Expanded(flex: 2, child: _headerText("Add Q.")),
                Expanded(flex: 1, child: _headerText("Cart")),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildInventoryList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        return _buildInventoryRow(inventoryItems[index], index);
      },
    );
  }

  Widget _buildInventoryRow(InventoryItem item, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!, width: 1)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isCompact = constraints.maxWidth < 600;

          if (isCompact) {
            return _buildCompactRow(item);
          } else {
            return _buildExpandedRow(item);
          }
        },
      ),
    );
  }

  Widget _buildExpandedRow(InventoryItem item) {
    return Row(
      children: [
        // Serial Number
        Expanded(
          flex: 1,
          child: Text(
            item.serialNo,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Product Info
        Expanded(
          flex: 4,
          child: Row(
            children: [
              _buildProductIcon(item.productType),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    item.productCode,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Available Quantity
        Expanded(
          flex: 2,
          child: Text(
            item.availableQuantity.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // Add Quantity Controls
        Expanded(flex: 2, child: _buildQuantityControls(item)),

        // Add to Cart Button
        Expanded(flex: 2, child: _buildAddButton()),
      ],
    );
  }

  Widget _buildCompactRow(InventoryItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Serial Number
        Text(
          item.serialNo,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        // Product Info
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProductIcon(item.productType),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.productCode,
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Available Quantity
        Text(
          item.availableQuantity.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Column(
            children: [
              // Add Quantity Controls
              _buildQuantityControls(item),
              SizedBox(height: 6),
              // Add to Cart Button
              _buildAddButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductIcon(ProductType type) {
    IconData iconData;
    Color iconColor;
    Color backgroundColor;

    switch (type) {
      case ProductType.oil:
        iconData = Icons.local_gas_station;
        iconColor = Colors.orange;
        backgroundColor = Colors.orange[50]!;
        break;
      case ProductType.tyre:
        iconData = Icons.trip_origin;
        iconColor = Colors.grey[700]!;
        backgroundColor = Colors.grey[100]!;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 20),
    );
  }

  Widget _buildQuantityControls(InventoryItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildQuantityButton(
          icon: Icons.remove,
          color: Colors.red,
          onPressed: () {
            setState(() {
              if (item.addQuantity > 0) {
                item.addQuantity--;
              }
            });
          },
        ),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            item.addQuantity.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        SizedBox(width: 8),
        _buildQuantityButton(
          icon: Icons.add,
          color: Colors.green,
          onPressed: () {
            setState(() {
              item.addQuantity++;
            });
          },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, color: Colors.white, size: 16),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "Add",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
