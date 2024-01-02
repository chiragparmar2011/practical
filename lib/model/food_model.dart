class FoodModel {
  final String foodItems;
  final String foodDate;
  int? confirmationStatus;
  final String confirmationType;

  FoodModel({
    required this.foodItems,
    required this.foodDate,
    required this.confirmationStatus,
    required this.confirmationType,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodDate: json['food_date'] ?? '',
      foodItems: json['food_items'] ?? '',
      confirmationType: json['confirmation_type'] ?? '',
      confirmationStatus: json['confirmation_status'] != null
          ? json['confirmation_status'] as int
          : null,
    );
  }
}
