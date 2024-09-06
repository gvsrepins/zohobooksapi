//TODO: Add SubAttributes users and tasks
import 'package:zohobooks_api/zohoboks_api.dart';

class ProjectDTO {
  
  String projectName; // Required
  String customerId;  // Required
  String userId;      // Required
  String billingType; // Required

  String? projectId;
  String? currencyId;
  String? customerName;
  String? currencyCode;
  String? description;
  String? status;
  String? rate;
  String? budgetType;
  String? budgetHours;
  String? budgetAmount;
  double? costBudgetAmount;
  String? totalHours;
  double? totalAmount;
  String? billedHours;
  double? billedAmount;
  String? unBilledHours;
  double? unBilledAmount;
  String? billableHours;
  double? billableAmount;
  String? nonBillableHours;
  double? nonBillableAmount;
  bool? isRecurrenceAssociated;
  List<dynamic>? recurringInvoices;
  String? createdTime;
  bool? showInDashboard;
  List<ProjectUserDTO>? users = [];
  
  ProjectDTO({
    required this.projectName,
    required this.customerId,
    required this.userId,
    required this.billingType,
    this.projectId,
    this.currencyId,
    this.customerName,
    this.currencyCode,
    this.description,
    this.status,    
    this.rate,
    this.budgetType,
    this.budgetHours,
    this.budgetAmount,
    this.costBudgetAmount,
    this.totalHours,
    this.totalAmount,
    this.billedHours,
    this.billedAmount,
    this.unBilledHours,
    this.unBilledAmount,
    this.billableHours,
    this.billableAmount,
    this.nonBillableHours,
    this.nonBillableAmount,
    this.isRecurrenceAssociated,
    this.recurringInvoices,
    this.createdTime,
    this.showInDashboard,
    this.users,
  }) {
    // Add validation checks here
    _validateProjectNameLength(projectName);
    _validateDescriptionLength(description);

    _validateBillingType(billingType);
        
    _validateBudgetType(budgetType);
    _validateNonNegativeValue(costBudgetAmount, 'costBudgetAmount');
    _validateNonNegativeValue(totalAmount, 'totalAmount');
    _validateNonNegativeValue(billedAmount, 'billedAmount');
    _validateNonNegativeValue(unBilledAmount, 'unBilledAmount');
    _validateNonNegativeValue(billableAmount, 'billableAmount');
    _validateNonNegativeValue(nonBillableAmount, 'nonBillableAmount');
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

  void _validateNonNegativeValue(double? value, String fieldName) {
    if (value == null) return;
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
    if (projectId != null) data['project_id'] = projectId;
    if (currencyId != null) data['currency_id'] = currencyId;
    if (customerName != null) data['customer_name'] = customerName;
    if (currencyCode != null) data['currency_code'] = currencyCode;
    if (description != null) data['description'] = description;
    if (status != null) data['status'] = status;    
    if (rate != null) data['rate'] = rate;
    if (budgetType != null) data['budget_type'] = budgetType;
    if (budgetHours != null) data['budget_hours'] = budgetHours;
    if (budgetAmount != null) data['budget_amount'] = budgetAmount;
    if (costBudgetAmount != null) data['cost_budget_amount'] = costBudgetAmount;
    if (totalHours != null) data['total_hours'] = totalHours;
    if (totalAmount != null) data['total_amount'] = totalAmount;
    if (billedHours != null) data['billed_hours'] = billedHours;
    if (billedAmount != null) data['billed_amount'] = billedAmount;
    if (unBilledHours != null) data['un_billed_hours'] = unBilledHours;
    if (unBilledAmount != null) data['un_billed_amount'] = unBilledAmount;
    if (billableHours != null) data['billable_hours'] = billableHours;
    if (billableAmount != null) data['billable_amount'] = billableAmount;
    if (nonBillableHours != null) data['non_billable_hours'] = nonBillableHours;
    if (nonBillableAmount != null) data['non_billable_amount'] = nonBillableAmount;
    if (isRecurrenceAssociated != null) data['is_recurrence_associated'] = isRecurrenceAssociated;
    if (recurringInvoices != null) data['recurring_invoices'] = recurringInvoices;
    if (createdTime != null) data['created_time'] = createdTime;
    if (showInDashboard != null) data['show_in_dashboard'] = showInDashboard;
    if (users != null) data['users'] = users;
    
    return data;
  }

}