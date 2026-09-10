import '../models/item_model.dart';
import '../models/transfer_request_model.dart';

class MockData {
  // ── Items ─────────────────────────────────────────────────────────────
  static final List<ItemModel> items = [
    ItemModel(
      id: '1',
      title: 'Monitor Dell 23"',
      description:
          'Monitor LED Full HD Dell de 23 polegadas. Funcionando perfeitamente, com cabo de energia e cabo HDMI inclusos.',
      category: ItemCategory.ti,
      originSector: 'Laboratório de Informática 1',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      quantity: 3,
      publishedAt: DateTime.now().subtract(const Duration(days: 45)),
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
      quantity: 1,
      publishedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    ItemModel(
      id: '3',
      title: 'Caixa de Cabos HDMI',
      description:
          'Caixa com 20 cabos HDMI 2.0, cada um com 1,8m de comprimento. Novos, ainda embalados individualmente.',
      category: ItemCategory.ti,
      originSector: 'Almoxarifado Central',
      condition: ItemCondition.novo,
      status: ItemStatus.disponivel,
      quantity: 20,
      publishedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ItemModel(
      id: '4',
      title: 'Cadeiras Giratórias',
      description:
          'Conjunto de cadeiras giratórias com estofamento em tecido preto. Em bom estado de conservação, com regulagem de altura funcional.',
      category: ItemCategory.escritorio,
      originSector: 'Sala dos Professores - Bloco B',
      condition: ItemCondition.usado,
      status: ItemStatus.reservado,
      quantity: 5,
      publishedAt: DateTime.now().subtract(const Duration(days: 60)),
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
      quantity: 2,
      publishedAt: DateTime.now().subtract(const Duration(days: 22)),
    ),
    ItemModel(
      id: '6',
      title: 'Teclados USB ABNT2',
      description:
          'Lote de teclados USB padrão ABNT2. Todos funcionando. Alguns com marcas de uso, mas em condições de utilização.',
      category: ItemCategory.ti,
      originSector: 'Laboratório de Informática 3',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      quantity: 12,
      publishedAt: DateTime.now().subtract(const Duration(days: 3)),
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
      quantity: 1,
      publishedAt: DateTime.now().subtract(const Duration(days: 38)),
    ),
    ItemModel(
      id: '8',
      title: 'Kit Béquer e Erlenmeyer',
      description:
          'Kit com 10 béqueres (250ml) e 10 Erlenmeyers (500ml) de vidro borossilicato. Novos, nunca utilizados.',
      category: ItemCategory.laboratorio,
      originSector: 'Laboratório de Química',
      condition: ItemCondition.novo,
      status: ItemStatus.disponivel,
      quantity: 10,
      publishedAt: DateTime.now().subtract(const Duration(days: 52)),
    ),
    ItemModel(
      id: '9',
      title: 'Impressora Laser HP',
      description:
          'Impressora HP LaserJet Pro monocromática. Possui toner com 40% de capacidade restante. Funciona via rede e USB.',
      category: ItemCategory.escritorio,
      originSector: 'Secretaria Acadêmica',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      quantity: 1,
      publishedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    ItemModel(
      id: '10',
      title: 'Notebook Lenovo i5',
      description:
          'Notebook Lenovo ThinkPad com processador i5, 8GB RAM e 256GB SSD. Bateria com 85% de saúde.',
      category: ItemCategory.ti,
      originSector: 'Coordenação de TI',
      condition: ItemCondition.usado,
      status: ItemStatus.disponivel,
      quantity: 1,
      publishedAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
  ];

  // ── Transfer Requests (Solicitações recebidas) ────────────────────────
  static final List<TransferRequest> transferRequests = [
    TransferRequest(
      id: 'tr1',
      item: items[0], // Monitor Dell
      requesterName: 'Profa. Ana Silva',
      requesterSector: 'Sala de Informática 2',
      destinationSector: 'Sala de Informática 2',
      requestedQuantity: 2,
      status: TransferStatus.pendente,
      requestedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    TransferRequest(
      id: 'tr2',
      item: items[4], // Microscópio
      requesterName: 'Prof. Carlos Mendes',
      requesterSector: 'Curso Técnico em Enfermagem',
      destinationSector: 'Lab. Enfermagem',
      requestedQuantity: 1,
      status: TransferStatus.pendente,
      requestedAt: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    TransferRequest(
      id: 'tr3',
      item: items[7], // Kit Béquer
      requesterName: 'Profa. Beatriz Lima',
      requesterSector: 'Laboratório de Ciências',
      destinationSector: 'Lab. Ciências - Bloco C',
      requestedQuantity: 5,
      status: TransferStatus.pendente,
      requestedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // ── Trade History (Histórico estático) ────────────────────────────────
  static final List<TradeHistoryEntry> tradeHistory = [
    TradeHistoryEntry(
      itemTitle: 'Mouses USB (8 un.)',
      fromSector: 'Almoxarifado Central',
      toSector: 'Laboratório de Informática 2',
      quantity: 8,
      completedAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    TradeHistoryEntry(
      itemTitle: 'Mesa de Escritório',
      fromSector: 'Sala dos Professores',
      toSector: 'Coordenação de Administração',
      quantity: 1,
      completedAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    TradeHistoryEntry(
      itemTitle: 'Datashow LG',
      fromSector: 'Sala de Reuniões - Bloco A',
      toSector: 'Sala de Aula 12',
      quantity: 1,
      completedAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    TradeHistoryEntry(
      itemTitle: 'Estabilizadores 600VA (4 un.)',
      fromSector: 'Laboratório de Informática 1',
      toSector: 'Biblioteca',
      quantity: 4,
      completedAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    TradeHistoryEntry(
      itemTitle: 'Cadeiras Empilháveis (10 un.)',
      fromSector: 'Auditório Principal',
      toSector: 'Refeitório',
      quantity: 10,
      completedAt: DateTime.now().subtract(const Duration(days: 32)),
    ),
  ];

  // ── Helpers ───────────────────────────────────────────────────────────
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

  static int get pendingRequestsCount =>
      transferRequests.where((r) => r.status == TransferStatus.pendente).length;
}
