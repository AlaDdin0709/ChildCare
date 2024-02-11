import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart'; // Add for state management (optional)

// Define a model for child data (optional)
class ChildData {
  final String name;
  final String photoUrl;
  // ... other fields

  ChildData({required this.name, required this.photoUrl});
}

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  String childId;
  ChildData? childData; // Using a model for structured data

  @override
  void initState() {
    super.initState();
    // Fetch child ID and data
    childId = // Get child ID from Firebase based on logged-in parent
    _fetchChildData();
  }

  Future<void> _fetchChildData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('children') // Replace with your child collection
          .doc(childId)
          .get();
      childData = ChildData(
        name: snapshot.get('name'),
        photoUrl: snapshot.get('photoUrl'),
        // ... other fields
      );
      setState(() {}); // Update UI
    } catch (e) {
      // Handle errors gracefully
      print('Error fetching child data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (childData == null) {
      return Center(child: CircularProgressIndicator()); // Loading state
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Dashboard'),
      ),
      body: ListView(
        children: [
          // Child information
          CircleAvatar(
            backgroundImage: NetworkImage(childData!.photoUrl),
            radius: 50.0,
          ),
          Text(childData!.name, style: TextStyle(fontSize: 24.0)),
          SizedBox(height: 20.0),

          
        ],
      ),
    );
  }
}
