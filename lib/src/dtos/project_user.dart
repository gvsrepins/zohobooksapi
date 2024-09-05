class ProjectUserDTO {
  
  String userId; // Required

  bool isCurrentUser;
  String userName;
  String email;
  String userRole;
  String status;
  String rate;
  String budgetHours;
  String totalHours;
  String billedHours;
  String unBilledHours;
  double costRate;

  ProjectUserDTO({
    required this.userId,
    this.isCurrentUser = false,
    this.userName = '',
    this.email = '',
    this.userRole = '',
    this.status = '',
    this.rate = '',
    this.budgetHours = '',
    this.totalHours = '',
    this.billedHours = '',
    this.unBilledHours = '',
    this.costRate = 0.0,
  }) {
    // Add validation checks here
    _validateRequiredField(userId, 'userId');
    _validateUserNameLength(userName);
    _validateEmailLength(email);
    _validateUserRole(userRole);
    _validateNonNegativeValue(costRate, 'costRate');
  }

  // Validation methods
  void _validateRequiredField(String field, String fieldName) {
    if (field.isEmpty) {
      throw ArgumentError('$fieldName is required.');
    }
  }

  void _validateUserNameLength(String name) {
    if (name.length > 200) {
      throw ArgumentError('User name must be at most 200 characters long.');
    }
  }

  void _validateEmailLength(String email) {
    if (email.length > 100) {
      throw ArgumentError('Email must be at most 100 characters long.');
    }
  }

  void _validateUserRole(String role) {
    const allowedValues = ['staff', 'admin', 'timesheetstaff'];
    if (role.isNotEmpty && !allowedValues.contains(role)) {
      throw ArgumentError(
          'User role must be one of the following: $allowedValues.');
    }
  }

  void _validateNonNegativeValue(double value, String fieldName) {
    if (value < 0) {
      throw ArgumentError('$fieldName must be a non-negative value.');
    }
  }

  // Method to convert a ProjectUser instance to a JSON object, only including defined fields
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['user_id'] = userId;
    if (isCurrentUser) data['is_current_user'] = isCurrentUser;
    if (userName.isNotEmpty) data['user_name'] = userName;
    if (email.isNotEmpty) data['email'] = email;
    if (userRole.isNotEmpty) data['user_role'] = userRole;
    if (status.isNotEmpty) data['status'] = status;
    if (rate.isNotEmpty) data['rate'] = rate;
    if (budgetHours.isNotEmpty) data['budget_hours'] = budgetHours;
    if (totalHours.isNotEmpty) data['total_hours'] = totalHours;
    if (billedHours.isNotEmpty) data['billed_hours'] = billedHours;
    if (unBilledHours.isNotEmpty) data['un_billed_hours'] = unBilledHours;
    if (costRate != 0.0) data['cost_rate'] = costRate;

    return data;
  }
}