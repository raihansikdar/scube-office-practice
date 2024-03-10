class EmployeeModel{
  final int id;
  final String name;
  final String designation;
  final int salary;

  EmployeeModel(this.id, this.name, this.designation, this.salary);

  static List<String> getFieldNames() {
    return ['id', 'name', 'designation', 'salary'];

    // return ['ID', 'Name', 'Designation', 'Salary'];
  }
}