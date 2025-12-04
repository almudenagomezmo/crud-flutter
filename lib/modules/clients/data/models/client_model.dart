import 'package:crud/modules/clients/domain/entities/client.dart';

class ClientModel extends Client {

  ClientModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  Client toEntity() {
    return Client(
      id: id,
      name: name,
      email: email,
    );
  }
}