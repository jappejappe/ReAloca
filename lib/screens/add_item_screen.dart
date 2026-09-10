import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/item_model.dart';
import '../theme/app_theme.dart';

class AddItemScreen extends StatefulWidget {
  final ValueChanged<ItemModel> onItemAdded;

  const AddItemScreen({super.key, required this.onItemAdded});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sectorController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  ItemCategory _selectedCategory = ItemCategory.ti;
  ItemCondition _selectedCondition = ItemCondition.usado;
  String? _capturedImagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _sectorController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (photo != null) {
        setState(() {
          _capturedImagePath = photo.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao capturar foto: $e'),
            backgroundColor: AppTheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _capturedImagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: $e'),
            backgroundColor: AppTheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  void _simulateBarcodeScan() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.qr_code_scanner_rounded,
                color: AppTheme.accent,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Leitura de Código de Barras',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Simulando leitura...',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
            ),
            const SizedBox(height: 16),
            // Simulated loading
            const LinearProgressIndicator(
              color: AppTheme.accent,
              backgroundColor: AppTheme.surfaceVariant,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Código: 7891234567890',
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Produto: Teclado Mecânico USB',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  setState(() {
                    _nameController.text = 'Teclado Mecânico USB';
                    _selectedCategory = ItemCategory.ti;
                    _quantityController.text = '1';
                    _sectorController.text = 'Almoxarifado Central';
                    _descriptionController.text =
                        'Teclado mecânico USB identificado via leitura de código de barras. Novo, embalagem original.';
                    _selectedCondition = ItemCondition.novo;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Usar Dados Escaneados',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ─────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 20,
                right: 20,
                bottom: 24,
              ),
              decoration: const BoxDecoration(
                gradient: AppTheme.headerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/logo.jpeg',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.add_rounded,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cadastrar Novo Item',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Publique materiais ociosos para reuso',
                          style: TextStyle(
                            color: Color(0xFFB0C4DE),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Scanner button
                  GestureDetector(
                    onTap: _simulateBarcodeScan,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.accent.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner_rounded,
                        color: AppTheme.accent,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Form ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Foto do item ─────────────────────────────────────
                    _buildLabel('Foto do Item', Icons.camera_alt_outlined),
                    const SizedBox(height: 10),
                    _buildPhotoSection(),
                    const SizedBox(height: 22),

                    // ── Nome ─────────────────────────────────────────────
                    _buildLabel('Nome do Material', Icons.inventory_2_outlined),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Ex: Monitor Dell 23"',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome do material';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),

                    // ── Categoria ────────────────────────────────────────
                    _buildLabel('Categoria', Icons.category_outlined),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.divider),
                      ),
                      child: DropdownButtonFormField<ItemCategory>(
                        value: _selectedCategory,
                        dropdownColor: AppTheme.surface,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                        ),
                        items: ItemCategory.values.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Row(
                              children: [
                                Icon(
                                  cat.icon,
                                  size: 18,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  cat.label,
                                  style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (cat) {
                          if (cat != null) {
                            setState(() => _selectedCategory = cat);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 22),

                    // ── Quantidade ───────────────────────────────────────
                    _buildLabel('Quantidade', Icons.format_list_numbered),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.divider),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  int current =
                                      int.tryParse(_quantityController.text) ??
                                      1;
                                  if (current > 1) {
                                    setState(() {
                                      _quantityController.text =
                                          '${current - 1}';
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppTheme.primary,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                  controller: _quantityController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  int current =
                                      int.tryParse(_quantityController.text) ??
                                      1;
                                  setState(() {
                                    _quantityController.text = '${current + 1}';
                                  });
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    // ── Setor ────────────────────────────────────────────
                    _buildLabel('Setor Atual', Icons.apartment_outlined),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _sectorController,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Ex: Laboratório de Informática 1',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o setor atual';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),

                    // ── Condição ─────────────────────────────────────────
                    _buildLabel('Condição', Icons.build_outlined),
                    const SizedBox(height: 10),
                    Row(
                      children: ItemCondition.values.map((condition) {
                        final isSelected = _selectedCondition == condition;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedCondition = condition);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? AppTheme.primaryGradient
                                    : null,
                                color: isSelected ? null : AppTheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.support
                                      : AppTheme.divider,
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primary.withValues(
                                            alpha: 0.2,
                                          ),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    _conditionIcon(condition),
                                    color: isSelected
                                        ? Colors.white
                                        : AppTheme.primary,
                                    size: 22,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    condition.label,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                      fontSize: 11,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 22),

                    // ── Descrição ────────────────────────────────────────
                    _buildLabel(
                      'Descrição (Opcional)',
                      Icons.description_outlined,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionController,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText:
                            'Descreva o item, incluindo detalhes como estado de conservação etc.',
                        alignLabelWithHint: true,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Submit button ────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: AppTheme.primary.withValues(alpha: 0.4),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.publish_rounded, size: 22),
                            SizedBox(width: 10),
                            Text(
                              'Publicar para Reuso',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Row(
      children: [
        // Preview da foto capturada
        GestureDetector(
          onTap: _capturePhoto,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _capturedImagePath != null
                    ? AppTheme.support
                    : AppTheme.divider,
                width: _capturedImagePath != null ? 2 : 1,
              ),
            ),
            child: _capturedImagePath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(_capturedImagePath!),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: AppTheme.primary.withValues(alpha: 0.5),
                        size: 32,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tirar Foto',
                        style: TextStyle(
                          color: AppTheme.textMuted.withValues(alpha: 0.7),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(width: 12),
        // Botões de ação
        Expanded(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _capturePhoto,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.camera_alt_rounded, size: 18),
                  label: const Text(
                    'Câmera',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _pickFromGallery,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    side: const BorderSide(color: AppTheme.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.photo_library_outlined, size: 18),
                  label: const Text(
                    'Galeria',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  IconData _conditionIcon(ItemCondition condition) {
    switch (condition) {
      case ItemCondition.novo:
        return Icons.fiber_new_rounded;
      case ItemCondition.usado:
        return Icons.autorenew_rounded;
      case ItemCondition.precisaReparo:
        return Icons.build_rounded;
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final newItem = ItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? 'Sem descrição adicional.'
            : _descriptionController.text.trim(),
        category: _selectedCategory,
        originSector: _sectorController.text.trim(),
        condition: _selectedCondition,
        status: ItemStatus.disponivel,
        quantity: int.tryParse(_quantityController.text) ?? 1,
        imagePath: _capturedImagePath,
        publishedAt: DateTime.now(),
      );

      widget.onItemAdded(newItem);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppTheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.success,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Item Publicado!',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '"${_nameController.text}" foi publicado com sucesso e já aparece no Feed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.textSecondary.withValues(alpha: 0.9),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    // Reset form
                    _nameController.clear();
                    _sectorController.clear();
                    _descriptionController.clear();
                    _quantityController.text = '1';
                    setState(() {
                      _capturedImagePath = null;
                      _selectedCategory = ItemCategory.ti;
                      _selectedCondition = ItemCondition.usado;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
