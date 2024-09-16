import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time,
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview

class Projects extends BaseResource {
  Map<String, dynamic> queryParameters = {
    'sort_column': 'created_time',
    'sort_order': 'D',
    'filter_by': 'Status.All',
  };

  Projects(super.httpClient, super.organizationId);

  @override
  String get resourceName => 'projects';

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> create(ProjectDTO project) async {

    if(project.projectId != null) {
      throw ArgumentError('Project ID cannot be set while creating a project');
    }
    
    var uri = super.prepareUrl();
    return post(uri, project.toJson());
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> all(
      {Map<String, dynamic> queryParameters = const {}}) async {
    //merge new queryParameters with the default ones
    queryParameters = this.queryParameters..addAll(queryParameters);
    var uri = super.prepareUrl(queryParameters: queryParameters);

    return await get(uri);
  }

  //OAuth Scope : ZohoBooks.projects.UPDATE
  Future<http.Response> update(ProjectDTO project) async {
    
    if(project.projectId == null) {
      throw ArgumentError('Project ID is required');
    }

    var uri = super.prepareUrl(pathSegment: project.projectId);
    return await put(uri, project.toJson());
  }

  //OAuth Scope : ZohoBooks.projects.READ
  Future<http.Response> find(String projectId) async {
    var uri = super.prepareUrl(pathSegment: projectId);
    return await get(uri);
  }

  //OAuth Scope : ZohoBooks.projects.DELETE
  Future<http.Response> destroy(String projectId) async {
    var uri = super.prepareUrl(pathSegment: projectId);
    return await delete(uri);
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> activate(String projectId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/active');
    return await post(uri, {});
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> inactivate(String projectId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/inactive');
    return await post(uri, {});
  }

  //OAuth Scope : ZohoBooks.projects.CREATE
  Future<http.Response> clone(ProjectCloneDTO project) async {
    var uri = super.prepareUrl(pathSegment: '${project.projectId}/clone');
    return await post(uri, project.toJson());
  }

  //TODO: test the methods bellow
  Future<http.Response> addUser(String projectId, ProjectUserDTO user) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users');
    return await post(uri, user.toJson());
  }

  Future<http.Response> getUsers(String projectId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users');
    return await get(uri);
  }

  Future<http.Response> inviteUser(
      String projectId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users/invite');
    return await post(uri, data);
  }

  Future<http.Response> updateUser(
      String projectId, String userId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users/invite/$userId');
    return await put(uri, data);
  }

  Future<http.Response> getUser(String projectId, String userId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users/invite/$userId');
    return await get(uri);
  }

  Future<http.Response> deleteUser(String projectId, String userId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/users/invite/$userId');
    return await delete(uri);
  }

  Future<http.Response> addComment(
      String projectId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/comments');
    return await post(uri, data);
  }

  Future<http.Response> getComments(String projectId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/comments');
    return await get(uri);
  }

  Future<http.Response> deleteComment(
      String projectId, String commentId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/comments/$commentId');
    return await delete(uri);
  }

  Future<http.Response> getInvoices(String projectId) async {
    var uri = super.prepareUrl(pathSegment: '$projectId/invoices');
    return await get(uri);
  }
}
