import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_elevated_button.dart';
import 'package:frontend/utils/colors.dart';
import '../../data/dummy_data.dart';
import '../../../../common/widgets/cus_search_filter.dart';
import '../widgets/customer_card.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: AppColors.grey,
        title: cus_search_filter(
          searchText: 'Search customer by name,email...',
          button: CustomElevatedButton(text: 'Add Customer', onPressed: () {}),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Customer List
          Expanded(
            child: ListView.builder(
              itemCount: customers.length,
              itemBuilder: (context, index) {
                final customer = customers[index];
                return InkWell(
                  onTap: () => setState(() => selected = index),
                  child: CustomerCard(
                    customer: customer,
                    isSelected: selected == index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
