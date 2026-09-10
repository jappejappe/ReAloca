import 'item_model.dart';

enum TransferStatus {
  pendente('Pendente'),
  aprovada('Aprovada'),
  recusada('Recusada');

  final String label;
  const TransferStatus(this.label);
}

class TransferRequest {
  final String id;
  final ItemModel item;
  final String requesterName;
  final String requesterSector;
  final String destinationSector;
  final int requestedQuantity;
  TransferStatus status;
  final DateTime requestedAt;

  TransferRequest({
    required this.id,
    required this.item,
    required this.requesterName,
    required this.requesterSector,
    required this.destinationSector,
    required this.requestedQuantity,
    required this.status,
    required this.requestedAt,
  });
}

class TradeHistoryEntry {
  final String itemTitle;
  final String fromSector;
  final String toSector;
  final int quantity;
  final DateTime completedAt;

  const TradeHistoryEntry({
    required this.itemTitle,
    required this.fromSector,
    required this.toSector,
    required this.quantity,
    required this.completedAt,
  });
}
