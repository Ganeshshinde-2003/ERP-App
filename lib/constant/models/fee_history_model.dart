class FeeHistory {
  final bool success;
  final String message;
  final List<FeeDetails> data;

  FeeHistory(
      {required this.success, required this.message, required this.data});

  factory FeeHistory.fromJson(Map<String, dynamic> json) {
    return FeeHistory(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => FeeDetails.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class FeeDetails {
  final String id;
  final String studentID;
  final String year;
  final String month;
  final int prevBalance;
  final int feeDue;
  final int feeCollected;
  final int balance;
  final String status;
  final String statusDate;
  final String createdAt;
  final String updatedAt;

  FeeDetails({
    required this.id,
    required this.studentID,
    required this.year,
    required this.month,
    required this.prevBalance,
    required this.feeDue,
    required this.feeCollected,
    required this.balance,
    required this.status,
    required this.statusDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeeDetails.fromJson(Map<String, dynamic> json) {
    return FeeDetails(
      id: json['_id'] ?? "",
      studentID: json['studentID'] ?? "",
      year: json['year'] ?? "",
      month: json['month'] ?? "",
      prevBalance: json['prevBalance'] ?? 0,
      feeDue: json['feeDue'] ?? 0,
      feeCollected: json['feeCollected'] ?? 0,
      balance: json['balance'] ?? 0,
      status: json['status'] ?? "",
      statusDate: json['statusDate'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'studentID': studentID,
      'year': year,
      'month': month,
      'prevBalance': prevBalance,
      'feeDue': feeDue,
      'feeCollected': feeCollected,
      'balance': balance,
      'status': status,
      'statusDate': statusDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
