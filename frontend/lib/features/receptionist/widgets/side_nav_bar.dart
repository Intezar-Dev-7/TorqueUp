import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant/constant.dart';

class SideNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  final List<Map<String, dynamic>> navItems;
  final bool isCollapsed;
  final bool showTooltips;

  const SideNavBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
    required this.navItems,
    required this.isCollapsed,
    this.showTooltips = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child:
                isCollapsed
                    ? Image.asset(
                      GenIcons.appLogo,
                      // width: 40,
                      // height: 40,
                    )
                    : Image.asset(
                      GenIcons.appLogo,
                      // width: 60,
                      // height: 60,
                    ),
          ),

          // Navigation Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              children: [
                const SizedBox(height: 10),
                ...navItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  bool isSelected = selectedIndex == index;

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child:
                        isCollapsed
                            ? _buildCollapsedItem(item, index, isSelected)
                            : _buildExpandedItem(item, index, isSelected),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Collapsed version (icon only)
  Widget _buildCollapsedItem(
    Map<String, dynamic> item,
    int index,
    bool isSelected,
  ) {
    Widget iconWidget = Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? AppColors.white : Colors.transparent,
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
                : [],
      ),
      child: Image.asset(
        item['icon'],
        width: 24,
        height: 24,
        color: isSelected ? Colors.black : Colors.grey,
      ),
    );

    // Wrap with tooltip if enabled
    if (showTooltips) {
      iconWidget = Tooltip(
        message: item['title'] as String,
        preferBelow: false,
        child: iconWidget,
      );
    }

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(10),
      child: iconWidget,
    );
  }

  // Expanded version (icon + text)
  Widget _buildExpandedItem(
    Map<String, dynamic> item,
    int index,
    bool isSelected,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? AppColors.white : Colors.transparent,
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
                : [],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Image.asset(
          item['icon'],
          width: 24,
          height: 24,
          color: isSelected ? Colors.black : Colors.grey,
        ),
        title: Text(
          item['title'] as String,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        onTap: () => onTap(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
