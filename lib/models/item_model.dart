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
  reservado('Reservado');

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
  final ItemStatus status;
  final IconData icon;
  final String? aiRecommendation;
  final DateTime publishedAt;

  const ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.originSector,
    required this.condition,
    required this.status,
    required this.icon,
    this.aiRecommendation,
    required this.publishedAt,
  });
}
