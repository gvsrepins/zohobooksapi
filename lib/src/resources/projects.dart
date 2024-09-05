import 'dart:convert';
import 'dart:io';
import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time,
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview
class Projects extends BaseResource {
  Projects(super.httpClient, super.organizationId,
      {super.baseUrl = 'https://www.zohoapis.com/books/v3'});

  @override
  String get resourceName => 'projects';

  dynamic create(ProjectDTO project) async {
   
    print(project.toJson());

    final response = await post(project.toJson());

    // Decodding the response body
    var responseBody = json.decode(response.body);
    var code = responseBody['code'];
    var message = responseBody['message'];

    if (response.statusCode == 201) {
      // Verifies if the response is successful
      if (code == 0) {
        return responseBody['project'] as Map<String, dynamic>;
      }

      throw HttpException('Error: ${responseBody['message']}',
          uri: response.request!.url);
    }

    throw HttpException('Failed to create project. Code $code: $message',
        uri: response.request!.url);
  }

  Future<http.Response> update(Map<String, dynamic> data) async {
    return await put(data);
  }

  Future<http.Response> retrieve() async {
    return await get();
  }

  Future<http.Response> updateById(
      String projectId, Map<String, dynamic> data) async {
    return await put(data, pathSegments: projectId);
  }

  Future<http.Response> getById(String projectId) async {
    return await get(pathSegments: projectId);
  }

  Future<http.Response> deleteById(String projectId) async {
    return await delete(pathSegments: projectId);
  }

  Future<http.Response> activate(String projectId) async {
    return await post({}, pathSegments: '$projectId/active');
  }

  Future<http.Response> deactivate(String projectId) async {
    return await post({}, pathSegments: '$projectId/inactive');
  }

  Future<http.Response> clone(String projectId) async {
    return await post({}, pathSegments: '$projectId/clone');
  }

  Future<http.Response> addUser(
      String projectId, Map<String, dynamic> data) async {
    return await post(data, pathSegments: '$projectId/users');
  }

  Future<http.Response> getUsers(String projectId) async {
    return await get(pathSegments: '$projectId/users');
  }

  Future<http.Response> inviteUser(
      String projectId, Map<String, dynamic> data) async {
    return await post(data, pathSegments: '$projectId/users/invite');
  }

  Future<http.Response> updateUser(
      String projectId, String userId, Map<String, dynamic> data) async {
    return await put(data, pathSegments: '$projectId/users/invite/$userId');
  }

  Future<http.Response> getUser(String projectId, String userId) async {
    return await get(pathSegments: '$projectId/users/invite/$userId');
  }

  Future<http.Response> deleteUser(String projectId, String userId) async {
    return await delete(pathSegments: '$projectId/users/invite/$userId');
  }

  Future<http.Response> addComment(
      String projectId, Map<String, dynamic> data) async {
    return await post(data, pathSegments: '$projectId/comments');
  }

  Future<http.Response> getComments(String projectId) async {
    return await get(pathSegments: '$projectId/comments');
  }

  Future<http.Response> deleteComment(
      String projectId, String commentId) async {
    return await delete(pathSegments: '$projectId/comments/$commentId');
  }

  Future<http.Response> getInvoices(String projectId) async {
    return await get(pathSegments: '$projectId/invoices');
  }
}
