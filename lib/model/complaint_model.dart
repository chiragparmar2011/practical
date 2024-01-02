class ComplaintModel {
  final String id;
  final String type;
  final String date;
  final String description;
  final String photo;
  final String status;
  final String tenantId;
  final String tenantName;
  final String roomNo;

  ComplaintModel({
    required this.id,
    required this.type,
    required this.date,
    required this.description,
    required this.photo,
    required this.status,
    required this.tenantId,
    required this.tenantName,
    required this.roomNo,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['complaint_id'] as String,
      type: json['complaint_type'] as String,
      date: json['complaint_date'] as String,
      description: json['complaint_desc'] as String,
      photo: json['complaint_photo'] as String,
      status: json['complaint_status'] as String,
      tenantId: json['complaint_tenant_id'] as String,
      tenantName: json['complaint_tenant_name'] as String,
      roomNo: json['complaint_room_no'] as String,
    );
  }
}
