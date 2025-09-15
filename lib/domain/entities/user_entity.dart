// lib/domain/entities/user_entity.dart
class UserEntity {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  final String telephone;

  UserEntity({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
  });

  // CopyWith pour faciliter les mises à jour
  UserEntity copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? email,
    String? telephone,
  }) {
    return UserEntity(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
    );
  }

  // Comparaison pour l'égalité
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is UserEntity &&
        other.id == id &&
        other.nom == nom &&
        other.prenom == prenom &&
        other.email == email &&
        other.telephone == telephone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nom.hashCode ^
        prenom.hashCode ^
        email.hashCode ^
        telephone.hashCode;
  }

  @override
  String toString() {
    return 'UserEntity(id: $id, nom: $nom, prenom: $prenom, email: $email, telephone: $telephone)';
  }
}