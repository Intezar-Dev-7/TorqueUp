import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant.dart';

class SideNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  final List<Map<String, dynamic>> navItems;

  const SideNavBar({
    required this.onTap,
    required this.selectedIndex,
    required this.navItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.grey,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Image(image: AssetImage(GenIcons.appLogoTrans), width: 200),
          Expanded(
            child: ListView(
              children: [
                ...navItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius:
                          selectedIndex == index
                              ? BorderRadius.circular(10)
                              : BorderRadius.circular(0),
                      boxShadow: selectedIndex == index ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ] : [],
                      color:
                          selectedIndex == index
                              ? AppColors.white
                              : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: Image.asset(
                        item['icon'] as String,
                        width: selectedIndex == index ? 30 : 20,
                        color:
                            selectedIndex == index ? Colors.black : Colors.grey,
                      ),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(
                          color:
                              selectedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                          fontWeight:
                              selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.w300,
                        ),
                      ),
                      selected: selectedIndex == index,
                      onTap: () {
                        // Navigator.of(context).pop(); // Close drawer if mobile
                        onTap(index);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
