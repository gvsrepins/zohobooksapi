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
      //ARRANGE
      var projectsVCRClient = await prepareProjectsVCRClient('projects_create');

      //ACT
      var response = await createNewProject(projectsVCRClient);
      var projectCreated = json.decode(response.body);
      var projectId = projectCreated['project']['project_id'];

      //ASSERT
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The project has been created.');

      //delete the project
      await projectsVCRClient.destroy(projectId);
    });

    test('should get a list of projects', () async {
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_all');
      var projectResponse = await createNewProject(projects);
      var projectId =
          json.decode(projectResponse.body)['project']['project_id'].toString();

      //ACT
      //get all projects with filters
      final response = await projects.all(queryParameters: {
        'sort_column': 'project_name',
        'sort_order': 'A',
        'filter_by': 'Status.All',
      });

      //ASSERT
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
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_update');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final project = ProjectDTO({
        'project_id': projectId,
        'customer_id': projectCreated['project']['customer_id'].toString(),
        'billing_type': 'fixed_cost_for_project',
        'user_id': '5529788000000088001',
        'project_name': 'New Project Name',
        'description': 'New Description',
      });
      final response = await projects.update(project);

      //ASSERT
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
      //ARRANGE
      //create a new project
      var projects = await prepareProjectsVCRClient('projects_find');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final response = await projects.find(projectId);

      //ASSERT
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
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_activate');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final response = await projects.activate(projectId);

      //ASSERT
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
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_inactivate');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final response = await projects.inactivate(projectId);

      //ASSERT
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
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_clone');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final project = ProjectCloneDTO(
          projectId: projectId, projectName: 'Cloned project Name');
      final response = await projects.clone(project);

      //ASSERT
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
      //ARRANGE
      var projects = await prepareProjectsVCRClient('projects_destroy');
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //ACT
      final response = await projects.destroy(projectId);

      //ASSERT
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The project has been deleted');
    });
  });

  // test('should assign users to a project', () async {
  //   //ARRANGE
  //   var projects = await prepareProjectsVCRClient('projects_assign_users');
  //   var projectResponse = await createNewProject(projects);
  //   var projectCreated = json.decode(projectResponse.body);
  //   var projectId = projectCreated['project']['project_id'].toString();

  //   //ACT
  //   var userProject = ProjectUserDTO({      
  //     'user_id': '5529788000000088001',
  //     'rate': '100',
  //   });

  //   final response = await projects.assignUser(projectId, userProject);

  //   //ASSERT
  //   var decodeResponse = json.decode(response.body);
  //   expect(response, isA<http.Response>());
  //   expect(response.statusCode, equals(200));
  //   expect(decodeResponse['code'], 0);
  //   //expect(decodeResponse['message'], 'The project has been updated.');
  // });
}

Future<http.Response> createNewContact(contacts) async {
    var contact = ContactDTO({
      'contact_name': 'Contact for ${faker.company.name()}',
      'company_name': faker.company.name(),
      'contact_type': 'customer',
      'payment_terms': 15,
      'language_code': 'en',
    });

    return await contacts.create(contact);
  }

  Future<Contacts> prepareContactsVCRClient(cassetteName) async {
    setup.clientVCR = setup.createVCRClient(cassetteName);
    //authenticate
    var client =
        await setup.oauthClientProvider.init(overrideHttpClient: setup.clientVCR);
    return Contacts(client, setup.organizationId!);
  }

  Future<http.Response> createNewProject(projectsVCRClient) async {

    var contactsVCRClient = await prepareContactsVCRClient('contacts_create');
    var contactResponse = await createNewContact(contactsVCRClient);
    var contact = json.decode(contactResponse.body)['contact'];

    var userId = '5529788000000088001'; //TODO: Needs to be set on a config file
    var customerId = contact['contact_id'];

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

    return await projectsVCRClient.create(project);
  }

  Future<Projects> prepareProjectsVCRClient(cassetteName) async {
    setup.clientVCR = setup.createVCRClient(cassetteName);
    //authenticate
    var client =
        await setup.oauthClientProvider.init(overrideHttpClient: setup.clientVCR);
    return Projects(client, setup.organizationId!);
  }