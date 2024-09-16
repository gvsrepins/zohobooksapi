class ProjectCloneDTO {

  String projectId; // Required
  String projectName; // Required
  String description;
  
  ProjectCloneDTO({
    required this.projectId,
    required this.projectName,
    this.description = ''
  }) {
    // Add validation checks here
    _validateRequiredField(projectName, 'projectName');
    _validateProjectNameLength(projectName);
    _validateDescriptionLength(description);
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

  // Convert a ProjectDTO instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['project_name'] = projectName;
    if (description.isNotEmpty) data['description'] = description;

    return data;
    
  }

}