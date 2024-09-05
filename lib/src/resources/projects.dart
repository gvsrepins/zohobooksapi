import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time,
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview
class Projects extends BaseResource {
  //QueryString
  final String sortColumn = 'created_time';
  final String sortOrder = 'D';
  final filterBy = 'Status.All,';

  Projects(super.httpClient, super.organizationId);

  @override
  String get resourceName => 'projects';

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> create(ProjectDTO project) async {
    var uri = super.prepareUrl();
    return post(uri, project.toJson());
  }

  //OAuth Scope : ZohoBooks.projects.UPDATE
  Future<http.Response> update(ProjectDTO project) async {
    return updateById(project.projectId, project);
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> read() async {
    var uri = super.prepareUrl();
    return await get(uri);
  }

  //OAuth Scope : ZohoBooks.projects.UPDATE
  Future<http.Response> updateById(String projectId, ProjectDTO project) async {
    var uri = super.prepareUrl(resourcePath: projectId);
    return await put(uri, project.toJson());
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> readById(String projectId) async {
    var uri = super.prepareUrl(resourcePath: projectId);
    return await get(uri);
  }

  //OAuth Scope : ZohoBooks.projects.DELETE
  Future<http.Response> deleteById(String projectId) async {
    var uri = super.prepareUrl(resourcePath: projectId);
    return await delete(uri);
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> activate(String projectId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/active');
    return await post(uri, {});
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> inactivate(String projectId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/inactive');
    return await post(uri, {});
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> clone(String projectId, ProjectCloneDTO project) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/clone');
    return await post(uri, project.toJson());
  }

  //TODO: test the methods bellow
  Future<http.Response> addUser(
      String projectId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/users');
    return await post(uri, data);
  }

  Future<http.Response> getUsers(String projectId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/users');
    return await get(uri);
  }

  Future<http.Response> inviteUser(
      String projectId, Map<String, dynamic> data) async {    
    var uri = super.prepareUrl(resourcePath: '$projectId/users/invite');
    return await post(uri, data);    
  }

  Future<http.Response> updateUser(
      String projectId, String userId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/users/invite/$userId');
    return await put(uri, data);
  }

  Future<http.Response> getUser(String projectId, String userId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/users/invite/$userId');
    return await get(uri);
  }

  Future<http.Response> deleteUser(String projectId, String userId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/users/invite/$userId');
    return await delete(uri);
  }

  Future<http.Response> addComment(
      String projectId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/comments');
    return await post(uri, data);
  }

  Future<http.Response> getComments(String projectId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/comments');
    return await get(uri);
  }

  Future<http.Response> deleteComment(
      String projectId, String commentId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/comments/$commentId');
    return await delete(uri);
  }

  Future<http.Response> getInvoices(String projectId) async {
    var uri = super.prepareUrl(resourcePath: '$projectId/invoices');
    return await get(uri);
  }

  set filterBy(String value) {
    const allowedValues = [
      'Status.All',
      'Status.Active',
      'Status.Inactive',
    ];

    if (!allowedValues.contains(value)) {
      throw ArgumentError(
          'Billing type must be one of the following: $allowedValues.');
    }

    filterBy = value;
  }
}
