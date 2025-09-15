// lib/data/models/user_model.dart
import 'dart:convert';

import 'package:rvsapp/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.telephone,
  });

  // Factory method pour créer un UserModel à partir d'un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
      telephone: json['telephone'] as String,
    );
  }

  // Conversion en JSON pour l'envoi à l'API
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    if (id != null) {
      data['id'] = id;
    }
    
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['email'] = email;
    data['telephone'] = telephone;
    
    return data;
  }

  // Conversion d'une string JSON (utile pour le cache)
  factory UserModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UserModel.fromJson(json);
  }

  // Conversion en string JSON (utile pour le cache)
  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Conversion depuis l'Entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      nom: entity.nom,
      prenom: entity.prenom,
      email: entity.email,
      telephone: entity.telephone,
    );
  }

  // Conversion vers l'Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      nom: nom,
      prenom: prenom,
      email: email,
      telephone: telephone,
    );
  }

  // CopyWith spécifique au Model
  @override
  UserModel copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
  }) {
    return UserModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
    );
  }

  // Méthode pour créer un modèle vide (utile pour les formulaires)
  factory UserModel.empty() {
    return UserModel(
      nom: '',
      prenom: '',
      email: '',
      telephone: '',
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, nom: $nom, prenom: $prenom, email: $email, telephone: $telephone)';
  }
}