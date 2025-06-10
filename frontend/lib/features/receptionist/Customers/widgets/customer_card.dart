import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class CustomerCard extends StatefulWidget {
  final Map<String, String> customer;
  final bool isSelected;

  const CustomerCard({
    super.key,
    required this.customer,
    this.isSelected = false,
  });

  @override
  State<CustomerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<CustomerCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

        if (isMobile) return _buildMobileCard();
        if (isTablet) return _buildTabletCard();
        return _buildDesktopCard();
      },
    );
  }

  Widget _buildMobileCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: widget.isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        boxShadow: widget.isSelected
            ? []
            : [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('image'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: widget.customer['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    children: [
                      TextSpan(
                        text: '\n${widget.customer['phone']}',
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                  icon : Icon(isExpanded ? Icons.expand_less : Icons.expand_more)),
            ],
          ),
          if (isExpanded) const SizedBox(height: 12),
          if (isExpanded)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 2,color: AppColors.grey,),
                Text(widget.customer['email']!, style: const TextStyle(color: Colors.grey)),
                Text(widget.customer['address']!, style: const TextStyle(color: Colors.grey)),
                Divider(thickness: 2,color: AppColors.grey,),
                Text("Vehicles :- ${widget.customer['vehicles']!}", style: const TextStyle(fontSize: 14)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTabletCard() {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: widget.isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        boxShadow: widget.isSelected
            ? []
            : [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, offset: Offset(0, 3))],
      ),
      duration: Duration(milliseconds: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.customer['id']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 16),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('image'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: widget.customer['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    children: [
                      TextSpan(
                        text: '\n${widget.customer['phone']}',
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.customer['email']!, style: const TextStyle(color: Colors.grey)),
                  Text(widget.customer['address']!, style: const TextStyle(color: Colors.grey)),
                  Text("Vehicles :- ${widget.customer['vehicles']!}", style: const TextStyle(fontSize: 14)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: widget.isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        boxShadow: widget.isSelected
            ? []
            : [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(widget.customer['id']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('image'),
                ),
                Text.rich(
                  TextSpan(
                    text: widget.customer['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    children: [
                      TextSpan(
                        text: '\n${widget.customer['phone']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.customer['email']!, style: const TextStyle(color: Colors.grey)),
                    Text(widget.customer['address']!, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                Text("Vehicles :- ${widget.customer['vehicles']!}", style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
