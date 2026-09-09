import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';

class ItemDetailScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailScreen({super.key, required this.item});

  Color _conditionColor() {
    switch (item.condition) {
      case ItemCondition.novo:
        return AppTheme.accentGreen;
      case ItemCondition.usado:
        return AppTheme.info;
      case ItemCondition.precisaReparo:
        return AppTheme.warning;
    }
  }

  Color _statusColor() {
    return item.status == ItemStatus.disponivel
        ? AppTheme.accentGreen
        : AppTheme.reserved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero Header ────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              height: 280,
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern
                  Positioned(
                    right: -30,
                    bottom: -30,
                    child: Icon(
                      item.icon,
                      size: 200,
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  // Top bar
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _circleButton(
                          icon: Icons.arrow_back_rounded,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        _circleButton(
                          icon: Icons.share_rounded,
                          onTap: () => _showSnackBar(
                            context,
                            'Link de compartilhamento copiado!',
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Center icon
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Icon(
                            item.icon,
                            size: 44,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Status tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor().withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _statusColor().withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.status == ItemStatus.disponivel
                                    ? Icons.check_circle_outline
                                    : Icons.lock_outline,
                                size: 14,
                                color: _statusColor(),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.status.label,
                                style: TextStyle(
                                  color: _statusColor(),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppTheme.textMuted.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.originSector,
                          style: TextStyle(
                            color: AppTheme.textMuted.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Info chips
                  Row(
                    children: [
                      _infoChip(
                        icon: Icons.category_outlined,
                        label: item.category.label,
                        color: AppTheme.primaryLight,
                      ),
                      const SizedBox(width: 10),
                      _infoChip(
                        icon: Icons.build_outlined,
                        label: item.condition.label,
                        color: _conditionColor(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: AppTheme.glassDecoration,
                    child: Text(
                      item.description,
                      style: TextStyle(
                        color: AppTheme.textSecondary.withValues(alpha: 0.9),
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // AI Recommendation
                  if (item.aiRecommendation != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.warning.withValues(alpha: 0.1),
                            AppTheme.warning.withValues(alpha: 0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.warning.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.warning.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: AppTheme.warning,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Recomendação da IA',
                                  style: TextStyle(
                                    color: AppTheme.warning,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.aiRecommendation!,
                                  style: TextStyle(
                                    color: AppTheme.textSecondary
                                        .withValues(alpha: 0.9),
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Details section
                  const Text(
                    'Detalhes',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: AppTheme.glassDecoration,
                    child: Column(
                      children: [
                        _detailRow(
                          Icons.category_outlined,
                          'Categoria',
                          item.category.label,
                        ),
                        _divider(),
                        _detailRow(
                          Icons.apartment_outlined,
                          'Setor de Origem',
                          item.originSector,
                        ),
                        _divider(),
                        _detailRow(
                          Icons.build_circle_outlined,
                          'Condição',
                          item.condition.label,
                        ),
                        _divider(),
                        _detailRow(
                          Icons.calendar_today_outlined,
                          'Publicado em',
                          '${item.publishedAt.day.toString().padLeft(2, '0')}/${item.publishedAt.month.toString().padLeft(2, '0')}/${item.publishedAt.year}',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      // ── Bottom Action Button ─────────────────────────────────────────
      bottomSheet: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom + 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          border: Border(
            top: BorderSide(
              color: AppTheme.primaryGreen.withValues(alpha: 0.15),
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: item.status == ItemStatus.disponivel
                ? () => _showTransferDialog(context)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: item.status == ItemStatus.disponivel
                  ? AppTheme.primaryGreen
                  : AppTheme.surfaceElevated,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppTheme.surfaceElevated,
              disabledForegroundColor: AppTheme.textMuted.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: item.status == ItemStatus.disponivel ? 4 : 0,
              shadowColor: AppTheme.primaryGreen.withValues(alpha: 0.4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.status == ItemStatus.disponivel
                      ? Icons.swap_horiz_rounded
                      : Icons.lock_outline,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  item.status == ItemStatus.disponivel
                      ? 'Solicitar Transferência para Meu Setor'
                      : 'Item Reservado',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppTheme.textMuted.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: AppTheme.textMuted.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
      height: 1,
    );
  }

  void _showTransferDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppTheme.accentGreen),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Solicitar Transferência',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'Deseja solicitar a transferência de "${item.title}" para o seu setor?\n\nO responsável pelo item será notificado.',
          style: TextStyle(
            color: AppTheme.textSecondary.withValues(alpha: 0.9),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancelar',
              style: TextStyle(
                color: AppTheme.textMuted.withValues(alpha: 0.7),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _showSnackBar(
                context,
                'Solicitação enviada com sucesso! ✅',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
