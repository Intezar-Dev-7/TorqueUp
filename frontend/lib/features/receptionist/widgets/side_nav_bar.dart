import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/constant.dart';

class SideNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  final List<Map<String, dynamic>> navItems;
  const SideNavBar({required this.onTap, required this.selectedIndex, required this.navItems});

  @override
  Widget build(BuildContext context) {


    return Container(
      color: AppColors.grey,
      child: Column(
        children: [
          Container(child: Image(image: AssetImage(GenIcons.appLogo))),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 20),
                ...navItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: selectedIndex == index ? BorderRadius.circular(10) : BorderRadius.circular(0),
                      color:
                          selectedIndex == index
                              ? AppColors.white
                              : Colors.transparent,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: Icon(
                        item['icon'] as IconData,
                        color:
                            selectedIndex == index ? Colors.black : Colors.grey,
                      ),
                      title: Text(
                        item['title'] as String,
                        style: TextStyle(
                          color:
                              selectedIndex == index ? Colors.black : Colors.grey,
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
