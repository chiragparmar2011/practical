import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical/model/complaint_model.dart';
import 'package:practical/service/api_services.dart';
import 'package:practical/utilities/app_colors.dart';

class ComplaintListScreen extends StatefulWidget {
  const ComplaintListScreen({required this.tenantId, super.key});

  final String? tenantId;

  @override
  State<ComplaintListScreen> createState() => _ComplaintListScreenState();
}

class _ComplaintListScreenState extends State<ComplaintListScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<ComplaintModel> complaints = [];

  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  Future<void> fetchComplaints() async {
    try {
      final fetchedComplaints = await ApiServices.fetchComplaints(widget.tenantId);
      setState(() {
        complaints = fetchedComplaints;
      });
    } catch (e) {
      print('Failed to fetch complaints: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Complaint List'),
          backgroundColor: AppColors.color2,
        ),
        body: _buildMain(),
      ),
    );
  }

  Widget _buildMain() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: _buildList(),
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          color: AppColors.color1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(complaints[index].type),
                Text(complaints[index].description),
                Text(complaints[index].id),
              ],
            ),
          ),
        );
      },
    );
  }
}
