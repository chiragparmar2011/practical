import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practical/screen/complaint_list_screen.dart';
import 'package:practical/screen/food_list_screen.dart';
import 'package:practical/service/api_services.dart';
import 'package:practical/utilities/app_colors.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  TextEditingController typeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController tenantController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // File? imageFile;
  // final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Complaint Form'),
        backgroundColor: AppColors.color2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildComplaintTypeField(),
                  const SizedBox(height: 20),
                  _buildComplaintDescriptionField(),
                  const SizedBox(height: 20),
                  _buildUploadImage(),
                  const SizedBox(height: 24),
                  _buildComplaintButton(),
                  const SizedBox(height: 24),
                  _buildOpenFoodListScreen()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      "Complaint Form",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildComplaintTypeField() {
    return TextFormField(
      controller: typeController,
      decoration: InputDecoration(
        labelText: "Complaint Type",
        labelStyle: TextStyle(color: AppColors.color2, fontSize: 18),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.color2,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (typeController.text.isEmpty) {
          return "Please Enter Complaint Type";
        }
        return null;
      },
    );
  }

  Widget _buildComplaintDescriptionField() {
    return TextFormField(
      controller: descController,
      decoration: InputDecoration(
        labelText: "Complaint Description",
        labelStyle: TextStyle(color: AppColors.color2, fontSize: 18),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.color2,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        errorStyle: TextStyle(
          color: AppColors.red,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
      ),
      validator: (value) {
        if (descController.text.isEmpty) {
          return "Please Enter Description";
        }
        return null;
      },
    );
  }

  Widget _buildUploadImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "File Name",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.color2,
          ),
          onPressed: () {},
          child: const Text(
            "Upload Image",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        )
      ],
    );
  }

  Widget _buildComplaintButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.color2,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: addComplaint,
      child: const Text(
        "Add Complain",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Future<void> getImageFromGallery() async {
    // final XFile? image = await picker.pickImage(
    //   source: ImageSource.gallery,
    // );

    // if (image != null) {
    //   setState(() {
    //     imageFile = File(image.path);
    //   });
    // }
  }

  Future<void> addComplaint() async {
    if (_formKey.currentState!.validate()) {
      final apiServices = ApiServices();
      // String? base64Image;
      // if (imageFile != null) {
      //   List<int> imageBytes = await imageFile!.readAsBytes();
      //   base64Image = base64Encode(imageBytes);
      // }
      bool complaintAdded = await apiServices.addComplaint(
        type: typeController.text,
        description: descController.text,
        image: '',
        tenantId: tenantController.text,
      );
      if (complaintAdded) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ComplaintListScreen(tenantId: tenantController.text),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add complaints failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Widget _buildOpenFoodListScreen() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.color2,
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FoodListScreen(tenantId: tenantController.text),
          ),
        );
      },
      child: const Text(
        "Open Food",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
