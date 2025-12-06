import 'package:flutter/material.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/modules/listing/domain/entities/information.dart';

class InformationCard extends StatelessWidget {
  final Information information;
  final Function(String) onEdit;
  final Function(String) onDelete;
  final Function(String) onDuplicate;

  const InformationCard({
    super.key,
    required this.information,
    required this.onEdit,
    required this.onDelete,
    required this.onDuplicate,
  });

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: AppTheme.iconSelectedBackground,
          child: Icon(
            information.icon,
            color: AppTheme.iconSelected,
          ),
        ),
        title: Text(
          information.text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          _formatDate(information.createdAt),
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit(information.id);
                break;
              case 'duplicate':
                onDuplicate(information.id);
                break;
              case 'delete':
                onDelete(information.id);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'duplicate',
              child: Row(
                children: [
                  Icon(Icons.copy_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Duplicar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, size: 20, color: AppTheme.error),
                  SizedBox(width: 8),
                  Text('Deletar', style: TextStyle(color: AppTheme.error)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

