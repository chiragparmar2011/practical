import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:practical/model/complaint_model.dart';
import 'package:practical/model/food_model.dart';

class ApiServices {
  static Future<bool> login(String mobile, String password) async {
    String url =
        'https://speedhostindia.com/projects/hostel/panel/get_app_data.php?tenant_mobile=$mobile&tenant_password=$password&app_action=Login_Check_Android_App';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Login successful');
        return true;
      } else {
        print('Login failed');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


  Future<bool> addComplaint({
    required String type,
    required String description,
    required String? image,
    required String tenantId,
  }) async {
    String url = 'https://speedhostindia.com/projects/hostel/panel/get_app_data.php';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['complaint_type'] = type;
      request.fields['complaint_desc'] = description;
      request.fields['complaint_tenant_id'] = tenantId;

      // if (image != null) {
      //   request.files.add(await http.MultipartFile.fromPath('image', image));
      // }

      var response = await request.send();
      if (response.statusCode == 200) {
        print('Complaint added successfully');
        return true;
      } else {
        print('Failed to add complaint');
        return false;
      }
    } catch (e) {
      print('Error adding complaint: $e');
      return false;
    }
  }



  static Future<List<ComplaintModel>> fetchComplaints(String? tenantId) async {
    final response = await http.get(
      Uri.parse(
          'https://speedhostindia.com/projects/hostel/panel/get_app_data.php?app_action=List_complaint_record&tenant_id=$tenantId'),
    );

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      if (responseData is List) {
        return responseData
            .map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Erroor');
      }
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  static Future<List<FoodModel>> fetchFoodList() async {
    final response = await http.get(Uri.parse(
        "https://speedhostindia.com/projects/hostel/panel/get_app_data.php?app_action=List_mess_record"));
    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      if (data is List) {
        return data
            .map((food) => FoodModel.fromJson(food as Map<String, dynamic>))
            .toList();
      }
    }
    throw Exception('Failed to load meals');
  }

  static Future<void> updateFoodConfirmationStatus(String tenantId, String foodDate,
      String foodItems, String newConfirmationType) async {
    final apiUrl =
        'https://speedhostindia.com/projects/hostel/panel/get_app_data.php?tenant_id=$tenantId&food_date=$foodDate&food_type=$foodItems&confirmation_id=$newConfirmationType&app_action=Add_Mess_confirmation';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);
      if (responseData.containsKey('confirmation_status')) {
        final confirmationStatus = responseData['confirmation_status'];
        return confirmationStatus;
      }
    } else {
      print('Field to update status: ${response.statusCode}');
    }
  }
}
