import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  final TextEditingController _controller = TextEditingController();
  List<User> users = [
    User(
      name: 'samah',
      email: 'samah@gmail.com',
      phoneNumber: '0598523232',
    ),
    User(
      name: 'sara',
      email: 'sara@gmail.com',
      phoneNumber: '0598745262',
    ),
  ];

  List<User> displayedUsers = [];

  @override
  void initState() {
    super.initState();
    displayedUsers = []; // Initially empty
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchUser,
                ),
              ),
            ),
          ),
          Expanded(
            child: displayedUsers.isEmpty
                ? Center(child: Text('No users found'))
                : ListView.builder(
                    itemCount: displayedUsers.length,
                    itemBuilder: (context, index) =>
                        _buildUserCard(displayedUsers[index]),
                  ),
          ),
        ],
      ),
    );
  }

  void _searchUser() {
    String searchText = _controller.text.toLowerCase();
    setState(() {
      displayedUsers = users
          .where((user) => user.name.toLowerCase().contains(searchText))
          .toList();
    });
  }

  Widget _buildUserCard(User user) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Color(0xFFDEDBDB), Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kourcolor1,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.grey[800]),
                      SizedBox(width: 8),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: kourcolor1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.grey[800]),
                      SizedBox(width: 8),
                      Text(
                        user.phoneNumber,
                        style: TextStyle(
                          fontSize: 16,
                          color: kourcolor1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  setState(() {
                    displayedUsers.remove(user);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  String email;
  String phoneNumber;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}
