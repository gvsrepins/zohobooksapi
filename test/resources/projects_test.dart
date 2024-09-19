import 'dart:convert';

import 'package:test/test.dart';
import 'package:faker/faker.dart';
import '../test_setup.dart' as setup;
import 'package:http/http.dart' as http;
import 'package:zohobooks_api/zoho_books_api.dart';

void main() {
  setup.main();
  setup.cassettePath = 'projects';

  group('Projects resource', () {
    test('should create a new project', () async {
      //WHEN
      var projects = await prepareProjectsVCRClient('projects_create');
      var response = await createNewProject(projects);
      var projectCreated = json.decode(response.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The project has been created.');

      //delete the project
      await projects.destroy(projectId);
    });

    test('should get a list of projects', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_all');
      var projectResponse = await createNewProject(projects);
      var projectId =
          json.decode(projectResponse.body)['project']['project_id'].toString();

      //WHEN
      //get all projects with filters
      final response = await projects.all(queryParameters: {
        'sort_column': 'project_name',
        'sort_order': 'A',
        'filter_by': 'Status.All',
      });

      //THEN
      //check the response
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'success');
      expect(decodeResponse['projects'].length, greaterThan(0));
      expect(decodeResponse['page_context']['applied_filter'], 'Status.All');
      expect(decodeResponse['page_context']['sort_column'], 'project_name');
      expect(decodeResponse['page_context']['sort_order'], 'A');

      //delete the project
      await projects.destroy(projectId);
    });

    test('should update a project', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_update');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final project = ProjectDTO({
        'project_id': projectId,
        'customer_id': projectCreated['project']['customer_id'].toString(),
        'billing_type': 'fixed_cost_for_project',
        'user_id': '5529788000000088001',
        'project_name': 'New Project Name',
        'description': 'New Description',
      });
      final response = await projects.update(project);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'],
          'The project information has been updated.');
      expect(decodeResponse['project']['project_name'],
          project.getAttribute('project_name'));
      expect(decodeResponse['project']['description'],
          project.getAttribute('description'));

      //delete the project
      await projects.destroy(projectId);
    });

    test('should find one project', () async {
      //GIVEN
      //create a new project
      var projects = await prepareProjectsVCRClient('projects_find');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.find(projectId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'success');
      expect(decodeResponse['project']['project_id'], projectId);
      expect(decodeResponse['project']['project_name'],
          projectCreated['project']['project_name']);

      //delete the project
      await projects.destroy(projectId);
    });

    test('should activate a project', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_activate');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.activate(projectId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(
          decodeResponse['message'], 'The Project has been marked as active.');

      //delete the project
      await projects.destroy(projectId);
    });

    test('should inactivate a project', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_inactivate');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.inactivate(projectId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'],
          'The project has been marked as inactive.');

      //delete the project
      await projects.destroy(projectId);
    });

    test('should clone a project', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_clone');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final project = ProjectCloneDTO(
          projectId: projectId, projectName: 'Cloned project Name');
      final response = await projects.clone(project);

      //THEN
      var decodeResponse = json.decode(response.body);
      var projectClonedId = decodeResponse['project']['project_id'].toString();

      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
      expect(decodeResponse['code'], 0);
      expect(
          decodeResponse['message'], 'Project has been cloned successfully.');
      expect(decodeResponse['project']['project_name'], project.projectName);
      expect(projectClonedId, isNot(projectId));

      //Revert the clone
      await projects.destroy(projectClonedId);
      await projects.destroy(projectId);
    });

    test('should destroy a project', () async {
      //GIVEN
      var projects = await prepareProjectsVCRClient('projects_destroy');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.destroy(projectId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The project has been deleted');
    });
  });

  // test('should assign users to a project', () async {
  //   //GIVEN
  //   var projects = await prepareProjectsVCRClient('projects_assign_users');
  //   var projectResponse = await createNewProject(projects);
  //   var projectCreated = json.decode(projectResponse.body);
  //   var projectId = projectCreated['project']['project_id'].toString();

  //   //WHEN
  //   var userProject = ProjectUserDTO({      
  //     'user_id': '5529788000000088001',
  //     'rate': '100',
  //   });

  //   final response = await projects.assignUser(projectId, userProject);

  //   //THEN
  //   var decodeResponse = json.decode(response.body);
  //   expect(response, isA<http.Response>());
  //   expect(response.statusCode, equals(200));
  //   expect(decodeResponse['code'], 0);
  //   //expect(decodeResponse['message'], 'The project has been updated.');
  // });
}

Future<http.Response> createNewProject(projects) async {
  //TODO: This needs to be set on a config file
  var userId = '5529788000000088001';
  var customerId = '5529788000000089879';

  var project = ProjectDTO({
    'project_name': 'Project for ${faker.company.name()}',
    'customer_id': customerId,
    'currency_code': 'USD',
    'description': faker.lorem.sentence(),
    'billing_type': 'fixed_cost_for_project',
    'rate': faker.randomGenerator.integer(5000).toString(),
    'cost_budget_amount': faker.randomGenerator.decimal(scale: 2).toString(),
    'user_id': userId,
    'users': [
      {
        'user_id': userId,
        'user_role': 'admin',
      },
    ],
  });

  return await projects.create(project);
}

Future<Projects> prepareProjectsVCRClient(cassetteName) async {
  setup.clientVCR = setup.createVCRClient(cassetteName);
  //authenticate
  var client =
      await setup.oauthClientProvider.init(overrideHttpClient: setup.clientVCR);
  return Projects(client, setup.organizationId!);
}
