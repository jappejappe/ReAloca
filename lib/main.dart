import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_feed_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/approvals_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/barcode_scanner_screen.dart';
import 'data/mock_data.dart';
import 'models/item_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ReAlocaApp());
}

class ReAlocaApp extends StatelessWidget {
  const ReAlocaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReAloca',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  
  // Shared state para a lista de itens
  final List<ItemModel> _sharedItems = List.from(MockData.items);

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeFeedScreen(items: _sharedItems),
      AddItemScreen(
        onItemAdded: (newItem) {
          setState(() {
            _sharedItems.insert(0, newItem);
            // Voltar para a aba Home
            _currentIndex = 0;
          });
        },
      ),
      const ApprovalsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            setState(() => _currentIndex = 1);
          },
          elevation: 0,
          backgroundColor: AppTheme.primary,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: AppTheme.surface,
        elevation: 12,
        shadowColor: AppTheme.primary.withValues(alpha: 0.1),
        padding: EdgeInsets.zero,
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ── Lado esquerdo ──
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Início',
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: Icons.barcode_reader,
                    activeIcon: Icons.barcode_reader,
                    label: 'Scanner',
                    index: -1, // Modal, não é tab
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BarcodeScannerScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Espaço para o FAB
            const SizedBox(width: 56),
            // ── Lado direito ──
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.fact_check_outlined,
                    activeIcon: Icons.fact_check_rounded,
                    label: 'Aprovações',
                    index: 2,
                    badgeCount: MockData.pendingRequestsCount,
                  ),
                  _buildNavItem(
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Perfil',
                    index: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    VoidCallback? onTap,
    int? badgeCount,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: onTap ?? () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            badgeCount != null
                ? Badge(
                    label: Text(
                      '$badgeCount',
                      style: const TextStyle(fontSize: 10),
                    ),
                    child: Icon(
                      isSelected ? activeIcon : icon,
                      color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                      size: 24,
                    ),
                  )
                : Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected ? AppTheme.primary : AppTheme.textMuted,
                    size: 24,
                  ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppTheme.primary : AppTheme.textMuted,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
