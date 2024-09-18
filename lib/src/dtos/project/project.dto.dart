import 'project_user.dto.dart';

//TODO: Add SubAttributes users and tasks

class ProjectDTO {
  Map<String, dynamic> _attributes = {
    'project_name': '',
    'customer_id': '',
    'user_id': '',
    'billing_type': '',
    'project_id': '',
    'currency_id': '',
    'customer_name': '',
    'currency_code': '',
    'description': '',
    'status': '',
    'rate': '',
    'budget_type': '',
    'budget_hours': '',
    'budget_amount': '',
    'cost_budget_amount': '',
    'total_hours': '',
    'total_amount': '',
    'billed_hours': '',
    'billed_amount': '',
    'un_billed_hours': '',
    'un_billed_amount': '',
    'billable_hours': '',
    'billable_amount': '',
    'non_billable_hours': '',
    'non_billable_amount': '',
    'is_recurrence_associated': '',
    'created_time': '',
    'show_in_dashboard': '',
    'recurring_invoices': [],
    'users': List<ProjectUserDTO>.empty(),
  };

  List<ProjectUserDTO> _userDTOs = [];

  ProjectDTO(Map<String, dynamic> json) {
    //merge attributes with json
    _attributes = {..._attributes, ...json};

    // Convert users to ProjectUserDTO objects
    if (json['users'] != null && json['users'] is List) {
      _userDTOs = (json['users'] as List).map((user) {
        return ProjectUserDTO(user);
      }).toList();
      _attributes['users'] = _userDTOs;
    } 

    //validate required fields
    _validateRequiredAttributes(json);

    //validate attributes
    _validateProjectNameLength(json['project_name']);
    _validateDescriptionLength(json['description']);
    _validateBillingType(json['billing_type']);
    _validateBudgetType(json['budget_type']);
    _validateNonNegativeValue(json['cost_budget_amount'], 'cost_budget_amount');
    _validateNonNegativeValue(json['total_amount'], 'total_amount');
    _validateNonNegativeValue(json['billed_amount'], 'billed_amount');
    _validateNonNegativeValue(json['un_billed_amount'], 'un_billed_amount');
    _validateNonNegativeValue(json['billable_amount'], 'billable_amount');
    _validateNonNegativeValue(
        json['non_billable_amount'], 'non_billable_amount');
  }

  List<ProjectUserDTO> get users => _userDTOs;
  
  void _validateRequiredAttributes(Map<String, dynamic> json) {
    if (json['project_name'] == null) {
      throw ArgumentError('Project name is required.');
    }
    if (json['customer_id'] == null) {
      throw ArgumentError('Customer ID is required.');
    }
    if (json['user_id'] == null) {
      throw ArgumentError('User ID is required.');
    }
    if (json['billing_type'] == null) {
      throw ArgumentError('Billing type is required.');
    }
  }

  void _validateProjectNameLength(String name) {
    if (name.length > 100) {
      throw ArgumentError('Project name must be at most 100 characters long.');
    }
  }

  void _validateDescriptionLength(String? desc) {
    if (desc == null) return;

    if (desc.length > 500) {
      throw ArgumentError('Description must be at most 500 characters long.');
    }
  }

  void _validateBillingType(String? type) {
    if (type == null) return;

    const allowedValues = [
      'fixed_cost_for_project',
      'based_on_project_hours',
      'based_on_staff_hours',
      'based_on_task_hours'
    ];
    if (!allowedValues.contains(type)) {
      throw ArgumentError(
          'Billing type must be one of the following: $allowedValues.');
    }
  }

  void _validateBudgetType(String? type) {
    if (type == null) return;

    const allowedValues = [
      'total_project_cost',
      'total_project_hours',
      'hours_per_task',
      'hours_per_staff'
    ];
    if (type.isNotEmpty && !allowedValues.contains(type)) {
      throw ArgumentError(
          'Budget type must be one of the following: $allowedValues.');
    }
  }

  void _validateNonNegativeValue(String? value, String fieldName) {
    if (value == null) return;
    if (value.isEmpty) return;

    if (double.parse(value) < 0) {
      throw ArgumentError('$fieldName must be a non-negative value.');
    }
  }

  // Convert a ProjectDTO instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    _attributes.forEach((key, value) {
      if (value is! List && value != null && value != '') {
        data[key] = value;
      }
    });

    return data;
  }

  dynamic getAttribute(name) {
    if (_attributes[name] == null || _attributes[name] == '') {
      return null;
    }

    if (name == 'users') {
      return _userDTOs;
    }

    if (_attributes[name] is List && _attributes[name] != []) {
      return _attributes[name].map((obj) => obj.toJson()).toList();
    }
 
    return _attributes[name];
  }
}
