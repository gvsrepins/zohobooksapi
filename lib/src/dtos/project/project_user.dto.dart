class ProjectUserDTO {
  Map<String, dynamic> attributes = {
    'user_id': '',
    'is_current_user': false,
    'user_name': '',
    'email': '',
    'user_role': '',
    'status': '',
    'rate': '',
    'budget_hours': '',
    'total_hours': '',
    'billed_hours': '',
    'un_billed_hours': '',
    'cost_rate': 0.0,
  };

  ProjectUserDTO(Map<String, dynamic> json) {
    attributes = {...attributes, ...json};
    _validateRequiredAttributes(json);
    _validateNonNegativeValues();
  }

  void _validateRequiredAttributes(Map<String, dynamic> json) {
    if (json['user_id'] == null) {
      throw ArgumentError('User ID is required.');
    }
  }

  void _validateNonNegativeValues() {
    _validateNonNegativeValue(attributes['rate'], 'rate');
    _validateNonNegativeValue(attributes['budget_hours'], 'budget_hours');
    _validateNonNegativeValue(attributes['total_hours'], 'total_hours');
    _validateNonNegativeValue(attributes['billed_hours'], 'billed_hours');
    _validateNonNegativeValue(attributes['un_billed_hours'], 'un_billed_hours');
    _validateNonNegativeValue(attributes['cost_rate'], 'cost_rate');
  }

  void _validateNonNegativeValue(dynamic value, String fieldName) {
    if (value != null && value is String && value.isNotEmpty) {
      if (double.parse(value) < 0) {
        throw ArgumentError('$fieldName must be a non-negative value.');
      }
    } else if (value != null && value is num && value < 0) {
      throw ArgumentError('$fieldName must be a non-negative value.');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    attributes.forEach((key, value) {
      if (value != null && value != '') {
        data[key] = value;
      }
    });
    return data;
  }

  getAttribute(String name) {
    if (attributes[name] == null || attributes[name] == '') {
      return null;
    }
    return attributes[name];
  }
}