import 'dart:convert';
import 'package:test/test.dart';
import 'package:faker/faker.dart';
import '../test_setup.dart' as setup;
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

void main() {
  setup.main();
  late Projects projects;
  late oauth2.Client client;
  setup.cassettePath = "projects";

  setUp(() async {});

  group('Projects', () {
    test('should create a new project', () async {
      //prepare the cassette
      setup.clientVCR = setup.createVCRClient("projects_create");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      //prepare the projects client
      projects = Projects(client, setup.organizationId!);

      //create a new project
      final response = await createNewProject(projects);
      var projectId =
          json.decode(response.body)['project']['project_id'].toString();

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
      //prepare the cassette to record the interaction
      setup.clientVCR = setup.createVCRClient("projects_all");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      //prepare the projects client
      projects = Projects(client, setup.organizationId!);
      //create a new project
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
      //prepare the cassette to record the interaction
      setup.clientVCR = setup.createVCRClient("projects_update");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      projects = Projects(client, setup.organizationId!);
      //create a new project
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final project = ProjectDTO(
        projectId: projectId,
        customerId: projectCreated['project']['customer_id'].toString(),
        billingType: "fixed_cost_for_project",
        userId: "5529788000000088001",
        projectName: "New Project Name",
        description: "New Description",
      );

      final response = await projects.update(project);

      //THEN
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'],
          'The project information has been updated.');
      expect(decodeResponse['project']['project_name'], project.projectName);
      expect(decodeResponse['project']['description'], project.description);

      //delete the project
      await projects.destroy(projectId);
    });

    test('should find one project', () async {
      //GIVEN
      //prepare the cassette to record the interaction
      setup.clientVCR = setup.createVCRClient("projects_find");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      projects = Projects(client, setup.organizationId!);

      //create a new project
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.find(projectId);

      //THEN
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
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
      //prepare the cassette to record the interaction
      setup.clientVCR = setup.createVCRClient("projects_activate");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      projects = Projects(client, setup.organizationId!);

      //create a new project
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.activate(projectId);

      //THEN
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The Project has been marked as active.');

      //delete the project
      await projects.destroy(projectId);
    });
  });

  test('should inactivate a project', () async {
    //GIVEN
      //prepare the cassette to record the interaction
      setup.clientVCR = setup.createVCRClient("projects_inactivate");
      //authenticate
      client = await setup.oauthClientProvider
          .init(overrideHttpClient: setup.clientVCR);
      projects = Projects(client, setup.organizationId!);

      //create a new project
      var projectResponse = await createNewProject(projects);
      var projectCreated = json.decode(projectResponse.body);
      var projectId = projectCreated['project']['project_id'].toString();

      //WHEN
      final response = await projects.inactivate(projectId);

      //THEN
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The project has been marked as inactive.');

      //delete the project
      await projects.destroy(projectId);
  });

  test('should clone a project', () async {
    //GIVEN
    //prepare the cassette to record the interaction
    setup.clientVCR = setup.createVCRClient("projects_clone");
    //authenticate
    client = await setup.oauthClientProvider
        .init(overrideHttpClient: setup.clientVCR);
    projects = Projects(client, setup.organizationId!);

    //create a new project
    var projectResponse = await createNewProject(projects);
    var projectCreated = json.decode(projectResponse.body);
    var projectId = projectCreated['project']['project_id'].toString();

    //WHEN  
    final project = ProjectCloneDTO(
        projectId: projectId,
        projectName: 'Cloned project Name'
    );

    final response = await projects.clone(project);

    //THEN
    expect(response, isA<http.Response>());
    expect(response.statusCode, equals(201));

    var decodeResponse = json.decode(response.body);
    expect(decodeResponse['code'], 0);
    expect(decodeResponse['message'], 'Project has been cloned successfully.');
    expect(decodeResponse['project']['project_name'], project.projectName);
    expect(decodeResponse['project']['project_id'], isNot(projectId));

    //delete the project
    await projects.destroy(projectId);
  });

  test('should destroy a project', () async {
    //GIVEN
    //prepare the cassette to record the interaction
    setup.clientVCR = setup.createVCRClient("projects_destroy");
    //authenticate
    client = await setup.oauthClientProvider
        .init(overrideHttpClient: setup.clientVCR);
    projects = Projects(client, setup.organizationId!);

    //create a new project
    var projectResponse = await createNewProject(projects);
    var projectCreated = json.decode(projectResponse.body);
    var projectId = projectCreated['project']['project_id'].toString();

    //WHEN
    final response = await projects.destroy(projectId);
    expect(response, isA<http.Response>());
    expect(response.statusCode, equals(200));

    var decodeResponse = json.decode(response.body);
    expect(decodeResponse['code'], 0);
    expect(decodeResponse['message'], 'The project has been deleted');
  });
}

Future<http.Response> createNewProject(Projects projects) async {
  var project = ProjectDTO(
    projectName: "Project for ${faker.company.name()}",
    customerId: "5529788000000089879", //Test Contact ID
    currencyCode: "USD",
    description: faker.lorem.sentence(),
    billingType: "fixed_cost_for_project",
    rate: faker.randomGenerator.integer(5000).toString(),
    costBudgetAmount: faker.randomGenerator.decimal(scale: 2).toDouble(),
    userId: "5529788000000088001", //My Zoho Books user ID
    users: [
      ProjectUserDTO(
        userId: "5529788000000088001", //My Zoho Books user ID
        userRole: "admin",
      ),
    ],
  );

  return await projects.create(project);
}
