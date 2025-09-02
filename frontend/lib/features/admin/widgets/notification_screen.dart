import 'package:flutter/material.dart';

class AdminNotificationScreen extends StatefulWidget {
  const AdminNotificationScreen({super.key});

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  int selectedChatIndex = 0;

  final List<String> users = [
    "John Doe",
    "Jane Smith",
    "Mike Johnson",
    "Alice Brown",
    "David Wilson",
  ];

  final Map<String, List<String>> messages = {
    "John Doe": ["Hello Admin!", "Can I book a service?"],
    "Jane Smith": ["Hi, I need help.", "My car is making noise."],
    "Mike Johnson": ["Good morning!", "Any update on my bike?"],
    "Alice Brown": ["Thanks for the service!", "You guys are awesome."],
    "David Wilson": ["Is there a discount?", "Planning a service soon."],
  };

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Row(
        children: [
          // LEFT PANEL - Users
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.search, color: Colors.black54),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: users.length,
                    separatorBuilder:
                        (_, __) =>
                            Divider(height: 1, color: Colors.grey.shade300),
                    itemBuilder: (context, index) {
                      return ListTile(
                        selected: selectedChatIndex == index,
                        selectedTileColor: Colors.blue.shade50,
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue.shade200,
                          child: Text(
                            users[index][0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          users[index],
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          setState(() {
                            selectedChatIndex = index;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // RIGHT PANEL - Chat
          Expanded(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade200,
                        child: Text(
                          users[selectedChatIndex][0],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        users[selectedChatIndex],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Messages
                Expanded(
                  child: Container(
                    color: Colors.grey.shade50,
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children:
                          messages[users[selectedChatIndex]]!
                              .map(
                                (msg) => Align(
                                  alignment:
                                      msg.startsWith("Admin")
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    constraints: const BoxConstraints(
                                      maxWidth: 400,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          msg.startsWith("Admin")
                                              ? Colors.blue.shade100
                                              : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 3,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      msg,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                ),

                // Input box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: () {
                            if (_messageController.text.isNotEmpty) {
                              setState(() {
                                messages[users[selectedChatIndex]]!.add(
                                  "Admin: ${_messageController.text}",
                                );
                                _messageController.clear();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
