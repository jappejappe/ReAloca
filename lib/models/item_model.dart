import 'package:flutter/material.dart';

enum ItemCategory {
  ti('TI', Icons.computer),
  laboratorio('Laboratório', Icons.science),
  escritorio('Escritório', Icons.desk),
  didatico('Didático', Icons.school);

  final String label;
  final IconData icon;
  const ItemCategory(this.label, this.icon);
}

enum ItemCondition {
  novo('Novo'),
  usado('Usado'),
  precisaReparo('Precisa de Reparo');

  final String label;
  const ItemCondition(this.label);
}

enum ItemStatus {
  disponivel('Disponível'),
  reservado('Reservado'),
  transferido('Transferido');

  final String label;
  const ItemStatus(this.label);
}

class ItemModel {
  final String id;
  final String title;
  final String description;
  final ItemCategory category;
  final String originSector;
  final ItemCondition condition;
  ItemStatus status;
  final int quantity;
  final String? imagePath;
  final DateTime publishedAt;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.originSector,
    required this.condition,
    required this.status,
    required this.quantity,
    this.imagePath,
    required this.publishedAt,
  });

  /// Calcula quantos dias o item está parado desde a publicação
  int get daysIdle => DateTime.now().difference(publishedAt).inDays;

  /// Retorna o ícone da categoria como fallback visual quando não há foto
  IconData get categoryIcon => category.icon;
}
