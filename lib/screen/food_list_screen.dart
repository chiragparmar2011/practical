import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical/model/food_model.dart';
import 'package:practical/service/api_services.dart';
import 'package:practical/utilities/app_colors.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({required this.tenantId, super.key});
  final String? tenantId;

  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<FoodModel> foodList = [];

  @override
  void initState() {
    fetchFoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Meal Attendance'),
        backgroundColor: AppColors.color2,
      ),
      body: _buildMain(),
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
      itemCount: foodList.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                color: AppColors.color1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(foodList[index].foodItems),
                      Text(foodList[index].foodDate),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color2,
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () {
                        _updateFoodConfirmationStatus(
                            index, foodList[index].confirmationType);
                      },
                      child: Text(
                        foodList[index].confirmationStatus == 1
                            ? 'You are coming'
                            : 'Yes',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color2,
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () {
                        _updateFoodConfirmationStatus(
                            index, foodList[index].confirmationType);
                      },
                      child: Text(
                        foodList[index].confirmationStatus == 1
                            ? 'Cancel'
                            : 'No',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchFoodList() async {
    try {
      final food = await ApiServices.fetchFoodList();
      setState(() {
        foodList = food;
      });
    } catch (e) {
      print('Failed to fetch food list: $e');
    }
  }

  void _updateFoodConfirmationStatus(int index, String newConfirmationType) async {
    final foodItem = foodList[index];
    try {
      await ApiServices.updateFoodConfirmationStatus(
        widget.tenantId!,
        foodItem.foodDate,
        foodItem.foodItems,
        newConfirmationType,
      );
    } catch (e) {
      print('Failed to update status: $e');
    }
  }
}
