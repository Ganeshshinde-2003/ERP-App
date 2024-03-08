class User {
  bool success;
  String message;
  ApiData data;

  User({required this.success, required this.message, required this.data});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      success: json['success'],
      message: json['message'],
      data: ApiData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ApiData {
  String token;
  ApiUser user;
  ApiEmployee employee;

  ApiData({required this.token, required this.user, required this.employee});

  factory ApiData.fromJson(Map<String, dynamic> json) {
    return ApiData(
      token: json['token'],
      user: ApiUser.fromJson(json['user']),
      employee: ApiEmployee.fromJson(json['employee']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
      'employee': employee.toJson(),
    };
  }
}

class ApiUser {
  String userId;
  String email;
  String fullName;
  String role;

  ApiUser({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.role,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    return ApiUser(
      userId: json['userId'],
      email: json['email'],
      fullName: json['fullName'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'role': role,
    };
  }
}

class ApiEmployee {
  String id;
  int empNumber;
  String designation;

  ApiEmployee({
    required this.id,
    required this.empNumber,
    required this.designation,
  });

  factory ApiEmployee.fromJson(Map<String, dynamic> json) {
    return ApiEmployee(
      id: json['_id'],
      empNumber: json['empNumber'],
      designation: json['designation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'empNumber': empNumber,
      'designation': designation,
    };
  }
}
