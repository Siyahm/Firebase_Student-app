class StudentModel {
  String? name;
  String? std;
  String? age;
  String? domain;
  String? studentId;

  StudentModel({
    required this.name,
    required this.std,
    required this.age,
    required this.domain,
    required this.studentId,
  });

  Map<String, dynamic> studentDataToMap() {
    return {
      'name': name,
      'std': std,
      'age': age,
      'domain': domain,
      'studentId': studentId,
    };
  }

  factory StudentModel.studentDataformMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map['name'],
      std: map['std'],
      age: map['age'],
      domain: map['domain'],
      studentId: map['studentId'],
    );
  }
}
