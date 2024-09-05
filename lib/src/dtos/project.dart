class ProjectDTO {
  
  String projectName; // Required
  String customerId;  // Required
  String userId;      // Required
  String billingType; // Required

  String projectId;
  String currencyId;
  String customerName;
  String currencyCode;
  String description;
  String status;
  String rate;
  String budgetType;
  String budgetHours;
  String budgetAmount;
  double costBudgetAmount;
  String totalHours;
  double totalAmount;
  String billedHours;
  double billedAmount;
  String unBilledHours;
  double unBilledAmount;
  String billableHours;
  double billableAmount;
  String nonBillableHours;
  double nonBillableAmount;
  bool isRecurrenceAssociated;
  List<dynamic> recurringInvoices;
  String createdTime;
  bool showInDashboard;
  
  ProjectDTO({
    required this.projectName,
    required this.customerId,
    required this.userId,
    required this.billingType,
    this.projectId = '',
    this.currencyId = '',
    this.customerName = '',
    this.currencyCode = '',
    this.description = '',
    this.status = '',    
    this.rate = '',
    this.budgetType = '',
    this.budgetHours = '',
    this.budgetAmount = '',
    this.costBudgetAmount = 0.0,
    this.totalHours = '',
    this.totalAmount = 0.0,
    this.billedHours = '',
    this.billedAmount = 0.0,
    this.unBilledHours = '',
    this.unBilledAmount = 0.0,
    this.billableHours = '',
    this.billableAmount = 0.0,
    this.nonBillableHours = '',
    this.nonBillableAmount = 0.0,
    this.isRecurrenceAssociated = false,
    this.recurringInvoices = const [],
    this.createdTime = '',
    this.showInDashboard = false,
  }) {
    // Add validation checks here
    _validateRequiredField(projectName, 'projectName');
    _validateProjectNameLength(projectName);
    _validateRequiredField(customerId, 'customerId');
    _validateRequiredField(userId, 'userId');
    _validateBillingType(billingType);
    _validateDescriptionLength(description);
    _validateBudgetType(budgetType);
    _validateNonNegativeValue(costBudgetAmount, 'costBudgetAmount');
    _validateNonNegativeValue(totalAmount, 'totalAmount');
    _validateNonNegativeValue(billedAmount, 'billedAmount');
    _validateNonNegativeValue(unBilledAmount, 'unBilledAmount');
    _validateNonNegativeValue(billableAmount, 'billableAmount');
    _validateNonNegativeValue(nonBillableAmount, 'nonBillableAmount');
  }

  // Validation methods
  void _validateRequiredField(String field, String fieldName) {
    if (field.isEmpty) {
      throw ArgumentError('$fieldName is required.');
    }
  }

  void _validateProjectNameLength(String name) {
    if (name.length > 100) {
      throw ArgumentError('Project name must be at most 100 characters long.');
    }
  }

  void _validateDescriptionLength(String desc) {
    if (desc.length > 500) {
      throw ArgumentError('Description must be at most 500 characters long.');
    }
  }

  void _validateBillingType(String type) {
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

  void _validateBudgetType(String type) {
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

  void _validateNonNegativeValue(double value, String fieldName) {
    if (value < 0) {
      throw ArgumentError('$fieldName must be a non-negative value.');
    }
  }

  // Convert a ProjectDTO instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['project_name'] = projectName;
    data['customer_id'] = customerId;
    data['user_id'] = userId;
    data['billing_type'] = billingType;

    // Add to map only if not default value
    if (projectId.isNotEmpty) data['project_id'] = projectId;
    if (currencyId.isNotEmpty) data['currency_id'] = currencyId;
    if (customerName.isNotEmpty) data['customer_name'] = customerName;
    if (currencyCode.isNotEmpty) data['currency_code'] = currencyCode;
    if (description.isNotEmpty) data['description'] = description;
    if (status.isNotEmpty) data['status'] = status;    
    if (rate.isNotEmpty) data['rate'] = rate;
    if (budgetType.isNotEmpty) data['budget_type'] = budgetType;
    if (budgetHours.isNotEmpty) data['budget_hours'] = budgetHours;
    if (budgetAmount.isNotEmpty) data['budget_amount'] = budgetAmount;
    if (costBudgetAmount != 0.0) data['cost_budget_amount'] = costBudgetAmount;
    if (totalHours.isNotEmpty) data['total_hours'] = totalHours;
    if (totalAmount != 0.0) data['total_amount'] = totalAmount;
    if (billedHours.isNotEmpty) data['billed_hours'] = billedHours;
    if (billedAmount != 0.0) data['billed_amount'] = billedAmount;
    if (unBilledHours.isNotEmpty) data['un_billed_hours'] = unBilledHours;
    if (unBilledAmount != 0.0) data['un_billed_amount'] = unBilledAmount;
    if (billableHours.isNotEmpty) data['billable_hours'] = billableHours;
    if (billableAmount != 0.0) data['billable_amount'] = billableAmount;
    if (nonBillableHours.isNotEmpty) data['non_billable_hours'] = nonBillableHours;
    if (nonBillableAmount != 0.0) data['non_billable_amount'] = nonBillableAmount;
    if (isRecurrenceAssociated) data['is_recurrence_associated'] = isRecurrenceAssociated;
    if (recurringInvoices.isNotEmpty) data['recurring_invoices'] = recurringInvoices;
    if (createdTime.isNotEmpty) data['created_time'] = createdTime;
    if (showInDashboard) data['show_in_dashboard'] = showInDashboard;
    
    return data;
  }

}