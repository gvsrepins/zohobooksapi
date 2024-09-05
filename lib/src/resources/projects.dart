import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time,
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview
class Projects extends BaseResource {

  Projects(
    super.httpClient,
    super.organizationId,
    {super.baseUrl = 'https://www.zohoapis.com/books/v3'}
    );

  @override
  String get resourceName => 'projects';

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> create(ProjectDTO project) async {
    return post(project.toJson());
  }
  
  //OAuth Scope : ZohoBooks.projects.UPDATE
  Future<http.Response> update(ProjectDTO project) async {
    return updateById(project.projectId, project);
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> read() async {
    return await get();
  }
  
  //OAuth Scope : ZohoBooks.projects.UPDATE
  Future<http.Response> updateById(String projectId, ProjectDTO project) async {
    return await put(project.toJson(), pathSegments: projectId);
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> readById(String projectId) async {
    return await get(pathSegments: projectId);
  }

  //OAuth Scope : ZohoBooks.projects.DELETE
  Future<http.Response> deleteById(String projectId) async {
    return await delete(pathSegments: projectId);
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> activate(String projectId) async {
    return await post({}, pathSegments: '$projectId/active');
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> inactivate(String projectId) async {
    return await post({}, pathSegments: '$projectId/inactive');
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> clone(String projectId, ProjectCloneDTO project) async {
    return await post(project.toJson(), pathSegments: '$projectId/clone');
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
