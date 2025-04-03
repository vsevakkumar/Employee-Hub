class RoleModel {
  int id;
  String name;

  RoleModel({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory RoleModel.fromMap(Map<String, dynamic> map) {
    return RoleModel(
      id: map['id'],
      name: map['name'],
    );
  }
}

List<RoleModel> roles = [
  RoleModel(id: 1, name: 'Product Designer'),
  RoleModel(id: 2, name: 'Flutter Developer'),
  RoleModel(id: 3, name: 'QA Tester'),
  RoleModel(id: 4, name: 'Product Owner'),
];
