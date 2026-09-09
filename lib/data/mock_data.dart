import 'package:flutter/material.dart';
import '../models/item_model.dart';

class MockData {
  static final List<ItemModel> items = [
    ItemModel(
      id: '1',
      title: 'Monitor Dell 23"',
      description:
          'Monitor LED Full HD Dell de 23 polegadas. Funcionando perfeitamente, com cabo de energia e cabo HDMI inclusos. Possui pequeno arranhão na base, mas não afeta o uso.',
      category: ItemCategory.ti,
      originSector: 'Laboratório de Informática 1',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      icon: Icons.monitor,
      aiRecommendation:
          'Este item atende à necessidade da Sala de Informática 2, que reportou déficit de monitores.',
      publishedAt: DateTime(2026, 9, 5),
    ),
    ItemModel(
      id: '2',
      title: 'Projetor HD Epson',
      description:
          'Projetor Epson PowerLite HD com 3.300 lumens. Lâmpada com 70% de vida útil restante. Acompanha controle remoto e cabo VGA.',
      category: ItemCategory.didatico,
      originSector: 'Auditório Principal',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      icon: Icons.videocam,
      aiRecommendation:
          'A Sala de Aula 12 solicitou projetor para aulas de multimídia. Este modelo é compatível.',
      publishedAt: DateTime(2026, 9, 3),
    ),
    ItemModel(
      id: '3',
      title: 'Caixa de Cabos HDMI (20 un.)',
      description:
          'Caixa com 20 cabos HDMI 2.0, cada um com 1,8m de comprimento. Novos, ainda embalados individualmente. Comprados em excesso para o laboratório.',
      category: ItemCategory.ti,
      originSector: 'Almoxarifado Central',
      condition: ItemCondition.novo,
      status: ItemStatus.disponivel,
      icon: Icons.cable,
      publishedAt: DateTime(2026, 9, 7),
    ),
    ItemModel(
      id: '4',
      title: 'Cadeiras Giratórias (5 un.)',
      description:
          'Conjunto de 5 cadeiras giratórias com estofamento em tecido preto. Em bom estado de conservação, com regulagem de altura funcional.',
      category: ItemCategory.escritorio,
      originSector: 'Sala dos Professores - Bloco B',
      condition: ItemCondition.usado,
      status: ItemStatus.reservado,
      icon: Icons.chair,
      publishedAt: DateTime(2026, 9, 1),
    ),
    ItemModel(
      id: '5',
      title: 'Microscópio Binocular',
      description:
          'Microscópio binocular com aumento de até 1000x. Necessita calibração e limpeza das lentes. Ideal para aulas de Biologia e Ciências.',
      category: ItemCategory.laboratorio,
      originSector: 'Laboratório de Biologia',
      condition: ItemCondition.precisaReparo,
      status: ItemStatus.disponivel,
      icon: Icons.biotech,
      aiRecommendation:
          'O Curso Técnico em Enfermagem precisa de microscópios para o próximo semestre.',
      publishedAt: DateTime(2026, 9, 6),
    ),
    ItemModel(
      id: '6',
      title: 'Teclados USB (12 un.)',
      description:
          'Lote com 12 teclados USB padrão ABNT2. Todos funcionando. Alguns com marcas de uso, mas em condições de utilização.',
      category: ItemCategory.ti,
      originSector: 'Laboratório de Informática 3',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      icon: Icons.keyboard,
      publishedAt: DateTime(2026, 9, 8),
    ),
    ItemModel(
      id: '7',
      title: 'Quadro Branco 2x1m',
      description:
          'Quadro branco de vidro temperado com moldura em alumínio. Dimensões: 2m x 1m. Em excelente estado.',
      category: ItemCategory.didatico,
      originSector: 'Sala de Reuniões - Bloco A',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      icon: Icons.dashboard,
      publishedAt: DateTime(2026, 9, 4),
    ),
    ItemModel(
      id: '8',
      title: 'Béquer e Erlenmeyer (Kit)',
      description:
          'Kit com 10 béqueres (250ml) e 10 Erlenmeyers (500ml) de vidro borossilicato. Novos, nunca utilizados.',
      category: ItemCategory.laboratorio,
      originSector: 'Laboratório de Química',
      condition: ItemCondition.novo,
      status: ItemStatus.disponivel,
      icon: Icons.science,
      publishedAt: DateTime(2026, 9, 2),
    ),
    ItemModel(
      id: '9',
      title: 'Impressora Laser HP',
      description:
          'Impressora HP LaserJet Pro monocromática. Possui toner com 40% de capacidade restante. Funciona via rede e USB.',
      category: ItemCategory.escritorio,
      originSector: 'Secretaria Acadêmica',
      condition: ItemCondition.usado,
      status: ItemStatus.reservado,
      icon: Icons.print,
      aiRecommendation:
          'O setor de Coordenação do Curso de Administração necessita de impressora.',
      publishedAt: DateTime(2026, 9, 9),
    ),
    ItemModel(
      id: '10',
      title: 'Notebook Lenovo i5',
      description:
          'Notebook Lenovo ThinkPad com processador i5, 8GB RAM e 256GB SSD. Bateria com 85% de saúde. Teclado e tela em bom estado.',
      category: ItemCategory.ti,
      originSector: 'Coordenação de TI',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      icon: Icons.laptop,
      publishedAt: DateTime(2026, 9, 7),
    ),
  ];

  static int get totalItemsSaved => items.length;

  static List<ItemModel> getByCategory(ItemCategory category) {
    return items.where((item) => item.category == category).toList();
  }

  static List<ItemModel> search(String query) {
    final q = query.toLowerCase();
    return items
        .where(
          (item) =>
              item.title.toLowerCase().contains(q) ||
              item.originSector.toLowerCase().contains(q) ||
              item.category.label.toLowerCase().contains(q),
        )
        .toList();
  }
}
