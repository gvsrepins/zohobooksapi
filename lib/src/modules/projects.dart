import 'dart:convert';
import 'dart:io';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time, 
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview
class Projects {
  final oauth2.Client httpClient;
  final String baseUrl;
  final String organizationId;

  Projects(
    this.httpClient,
    this.organizationId,
    {this.baseUrl = 'https://www.zohoapis.com/books/v3'}
  );

  Uri prepareUrl(String path) {
    return Uri.parse('$baseUrl/$path?organization_id=$organizationId');
  }

  dynamic create({
    required String projectName,
    required String customerId,
    required String userId,
    required String billingType,
    String? currencyCode,
    String? description,
    String? rate,
    String? budgetType,
    String? budgetHours,
    String? budgetAmount,
    double? costBudgetAmount,
    List<Map<String, dynamic>>? tasks,
    List<Map<String, dynamic>>? users,
  }) async {

  // Basic validations
  if (projectName.isEmpty || projectName.length > 100) {
    throw ArgumentError('Project name is required and must be less than 100 characters.');
  }
  if (customerId.isEmpty) {
    throw ArgumentError('Customer ID is required.');
  }
  if (billingType.isEmpty || !['fixed_cost_for_project', 'based_on_project_hours', 'based_on_staff_hours', 'based_on_task_hours'].contains(billingType)) {
    throw ArgumentError('Billing type is required and must be one of the allowed values.');
  }
  if (userId.isEmpty) {
    throw ArgumentError('User ID is required.');
  }

  // Prepare the data to be sent
  final Map<String, dynamic> data = {
    'project_name': projectName,
    'customer_id': customerId,
    if (currencyCode != null) 'currency_code': currencyCode,
    if (description != null && description.length <= 500) 'description': description,
    'billing_type': billingType,
    if (rate != null) 'rate': rate,
    if (budgetType != null) 'budget_type': budgetType,
    if (budgetHours != null) 'budget_hours': budgetHours,
    if (budgetAmount != null) 'budget_amount': budgetAmount,
    if (costBudgetAmount != null) 'cost_budget_amount': costBudgetAmount.toString(),
    'user_id': userId,
    if (tasks != null) 'tasks': tasks,
    if (users != null) 'users': users,
  };

  final uri = prepareUrl('projects');
  print(json.encoder.convert(data));

  final response = await _post(uri, data);

  if (response.statusCode == 201) {
    // Decodding the response body
    var responseBody = json.decode(response.body);

    // Verifies if the response is successful
    if (responseBody['code'] == 0) {
      return responseBody['project'] as Map<String, dynamic>;
    } else {
      throw HttpException('API Error: ${responseBody['message']}', uri: uri);
    }
  } else {
    print(response.body);
    throw HttpException('Failed to create project', uri: uri);
  }
}

  Future<http.Response> update(Map<String, dynamic> data) async {
    final uri = prepareUrl('projects');
    return await _put(uri, data);
  }

  Future<http.Response> getProjects() async {
    final uri = prepareUrl('projects');
    return await _get(uri);
  }

  Future<http.Response> updateById(String projectId, Map<String, dynamic> data) async {
    final uri = prepareUrl('projects/$projectId');
    return await _put(uri, data);
  }

  Future<http.Response> getById(String projectId) async {
    final uri = prepareUrl('projects/$projectId');
    return await _get(uri);
  }

  Future<http.Response> deleteById(String projectId) async {
    final uri = prepareUrl('projects/$projectId');
    return await _delete(uri);
  }

  Future<http.Response> activate(String projectId) async {
    final uri = prepareUrl('projects/$projectId/active');
    return await _post(uri, {});
  }

  Future<http.Response> deactivate(String projectId) async {
    final uri = prepareUrl('projects/$projectId/inactive');
    return await _post(uri, {});
  }

  Future<http.Response> clone(String projectId) async {
    final uri = prepareUrl('projects/$projectId/clone');
    return await _post(uri, {});
  }

  Future<http.Response> addUser(String projectId, Map<String, dynamic> data) async {
    final uri = prepareUrl('projects/$projectId/users');
    return await _post(uri, data);
  }

  Future<http.Response> getUsers(String projectId) async {
    final uri = prepareUrl('projects/$projectId/users');
    return await _get(uri);
  }

  Future<http.Response> inviteUser(String projectId, Map<String, dynamic> data) async {
    final uri = prepareUrl('projects/$projectId/users/invite');
    return await _post(uri, data);
  }

  Future<http.Response> updateUser(String projectId, String userId, Map<String, dynamic> data) async {    
    final uri = prepareUrl('projects/$projectId/users/invite/$userId');
    return await _put(uri, data);
  }

  Future<http.Response> getUser(String projectId, String userId) async {
    final uri = prepareUrl('projects/$projectId/users/invite/$userId');
    return await _get(uri);
  }

  Future<http.Response> deleteUser(String projectId, String userId) async {
    final uri = prepareUrl('projects/$projectId/users/invite/$userId');
    return await _delete(uri);
  }

  Future<http.Response> addComment(String projectId, Map<String, dynamic> data) async {
    final uri = prepareUrl('projects/$projectId/comments');
    return await _post(uri, data);
  }

  Future<http.Response> getComments(String projectId) async {
    final uri = prepareUrl('projects/$projectId/comments');
    return await _get(uri);
  }

  Future<http.Response> deleteComment(String projectId, String commentId) async {
    final uri = prepareUrl('projects/$projectId/comments/$commentId');
    return await _delete(uri);
  }

  Future<http.Response> getInvoices(String projectId) async {
    final uri = prepareUrl('projects/$projectId/invoices');
    return await _get(uri);
  }

  // Helper methods for HTTP requests
  Future<http.Response> _post(Uri uri, Map<String, dynamic> data) async {
    return await httpClient.post(uri, body: json.encoder.convert(data));
  }

  Future<http.Response> _put(Uri uri, Map<String, dynamic> data) async {
    return await httpClient.put(uri);    
  }

  Future<http.Response> _get(Uri uri) async {
    return await httpClient.get(uri);
  }

  Future<http.Response> _delete(Uri uri) async {
    return await httpClient.delete(uri);    
  }
}