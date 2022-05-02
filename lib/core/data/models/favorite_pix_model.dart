// ignore_for_file: overridden_fields, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favoritospix/core/domain/entities/favorite_pix.dart';

class FavoritePixModel extends FavoritePix {
  String? id;
  String? name;
  late String pixKey;
  String? bankBranch;
  String? bankName;
  String? bankNumber;
  String? cpfCnpj;
  DateTime? lastUpdate;
  DateTime? registerDate;
  FavoritePixModel({
    this.id,
    required this.pixKey,
    this.name,
    this.bankBranch,
    this.bankName,
    this.bankNumber,
    this.cpfCnpj,
    this.lastUpdate,
    this.registerDate,
  });

  factory FavoritePixModel.fromJson(DocumentSnapshot<Object?> doc) {
    return FavoritePixModel(
      id: doc.id,
      pixKey: doc['chave'],
      name: doc['nome'],
      bankBranch: doc['agencia'],
      bankName: doc['banco'],
      bankNumber: doc['conta'],
      cpfCnpj: doc['cpfCnpj'],
      lastUpdate: (doc['updatedAt'] as Timestamp).toDate(),
      registerDate: (doc['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chave": pixKey,
      "nome": name ?? '',
      'agencia': bankBranch ?? '',
      'banco': bankName ?? '',
      'conta': bankNumber ?? '',
      'cpfCnpj': cpfCnpj ?? '',
      'updatedAt': Timestamp.fromDate(lastUpdate ?? DateTime.now()),
      'createdAt': Timestamp.fromDate(registerDate ?? DateTime.now()),
    };
  }
}
