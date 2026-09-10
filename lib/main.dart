import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_feed_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/approvals_screen.dart';
import 'screens/profile_screen.dart';
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Início',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_rounded),
              activeIcon: Icon(Icons.add_circle_rounded),
              label: 'Publicar',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('${MockData.pendingRequestsCount}'),
                child: const Icon(Icons.fact_check_outlined),
              ),
              activeIcon: Badge(
                label: Text('${MockData.pendingRequestsCount}'),
                child: const Icon(Icons.fact_check_rounded),
              ),
              label: 'Aprovações',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
