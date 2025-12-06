import 'package:flutter/material.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/modules/listing/domain/entities/information.dart';
import 'package:target/shared/widgets/widgets.dart';

class InformationBottomSheet extends StatefulWidget {
  final Information? information;
  final Function(String, IconData) onSave;

  const InformationBottomSheet({
    super.key,
    this.information,
    required this.onSave,
  });

  @override
  State<InformationBottomSheet> createState() => _InformationBottomSheetState();
}

class _InformationBottomSheetState extends State<InformationBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _textController;
  late IconData _selectedIcon;

  static const List<IconData> _availableIcons = [
    Icons.shopping_cart,
    Icons.flight,
    Icons.music_note,
    Icons.attach_money,
    Icons.phone,
    Icons.calendar_today,
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: widget.information?.text ?? '',
    );
    _selectedIcon = widget.information?.icon ?? _availableIcons[0];
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_textController.text.trim(), _selectedIcon);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.information != null;

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEditing ? 'Editar Informação' : 'Adicionar Informação',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Spacing.lgVertical,
            _buildIconSelector(),
            Spacing.lgVertical,
            CustomTextField(
              controller: _textController,
              hintText: 'Digite a informação',
              prefixIcon: Icons.text_fields,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleSave(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, digite uma informação';
                }
                return null;
              },
            ),
            Spacing.lgVertical,
            CustomButton(
              text: isEditing ? 'Salvar Alterações' : 'Adicionar',
              onPressed: _handleSave,
            ),
            Spacing.mdVertical,
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Selecione um ícone',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.divider),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children:
                  _availableIcons.map((icon) {
                    final isSelected = _selectedIcon == icon;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppTheme.iconSelectedBackground
                                  : AppTheme.iconUnselectedBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppTheme.iconSelectedBorder
                                    : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color:
                              isSelected
                                  ? AppTheme.iconSelected
                                  : AppTheme.iconUnselected,
                          size: 28,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
