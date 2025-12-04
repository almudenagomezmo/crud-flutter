class Client {
  int id;
  String name;
  String email;

  Client({
    required this.id,
    required this.name,
    required this.email,
  });

  // getters y setters
  int getId()
  {
    return id;
  }
 
  String getName()
  {
    return name;
  }

  String getEmail()
  {
    return email;
  }

  void setName(String newName)
  {
    name = newName;
  }

  void setEmail(String newEmail)
  {
    email = newEmail;
  }
}