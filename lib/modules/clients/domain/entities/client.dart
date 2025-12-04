class Client {
  int id;
  String name;
  String email;

  Client({required this.id, required this.name, required this.email});

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  int getId() {
    return id;
  }

  void setName(String newName) {
    // name = newName; // Descomenta si name no es final
  }
  void setEmail(String newEmail) {
    email = newEmail; // Descomenta si email no es final
  }
}
