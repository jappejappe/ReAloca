import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';
import '../widgets/category_carousel.dart';
import '../widgets/item_card.dart';
import '../widgets/search_bar_widget.dart';
import 'item_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  ItemCategory? _selectedCategory;
  String _searchQuery = '';
  late AnimationController _counterController;
  late Animation<int> _counterAnim;

  @override
  void initState() {
    super.initState();
    _counterController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _counterAnim = IntTween(
      begin: 0,
      end: MockData.totalItemsSaved,
    ).animate(CurvedAnimation(
      parent: _counterController,
      curve: Curves.easeOutCubic,
    ));
    _counterController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _counterController.dispose();
    super.dispose();
  }

  List<ItemModel> get _filteredItems {
    List<ItemModel> items = MockData.items;

    if (_searchQuery.isNotEmpty) {
      items = MockData.search(_searchQuery);
    }

    if (_selectedCategory != null) {
      items = items
          .where((item) => item.category == _selectedCategory)
          .toList();
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.eco_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EcoTroca',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                'Escolar',
                                style: TextStyle(
                                  color: Color(0xFFA5D6A7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Notification bell
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Badge(
                          smallSize: 8,
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Counter card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGreen.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.recycling_rounded,
                            color: Color(0xFF69F0AE),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Itens Salvos do Desperdício',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              AnimatedBuilder(
                                animation: _counterAnim,
                                builder: (context, child) {
                                  return Text(
                                    '${_counterAnim.value} materiais reaproveitados',
                                    style: const TextStyle(
                                      color: Color(0xFF69F0AE),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.trending_up_rounded,
                          color: Color(0xFF69F0AE),
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Search Bar ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 6),
              child: SearchBarWidget(
                controller: _searchController,
                onChanged: (query) {
                  setState(() => _searchQuery = query);
                },
              ),
            ),
          ),

          // ── Categories ───────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Categorias',
                      style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CategoryCarousel(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (cat) {
                      setState(() => _selectedCategory = cat);
                    },
                  ),
                ],
              ),
            ),
          ),

          // ── Items Header ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Materiais Disponíveis',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_filteredItems.length} itens',
                    style: TextStyle(
                      color: AppTheme.textMuted.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Items List ───────────────────────────────────────────────────
          _filteredItems.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 56,
                            color: AppTheme.textMuted.withValues(alpha: 0.4),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum material encontrado',
                            style: TextStyle(
                              color: AppTheme.textMuted.withValues(alpha: 0.6),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = _filteredItems[index];
                      return ItemCard(
                        item: item,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ItemDetailScreen(item: item),
                            ),
                          );
                        },
                      );
                    },
                    childCount: _filteredItems.length,
                  ),
                ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
