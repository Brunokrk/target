import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target/core/injection/injection_container.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/modules/listing/domain/entities/information.dart';
import 'package:target/modules/listing/presentation/pages/details_page.dart';
import 'package:target/modules/listing/presentation/stores/listing_store.dart';
import 'package:target/modules/listing/presentation/widgets/information_bottom_sheet.dart';
import 'package:target/modules/listing/presentation/widgets/information_card.dart';
import 'package:target/shared/services/toast_service.dart';
import 'package:target/shared/widgets/widgets.dart';

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  late final ListingStore _listingStore;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _listingStore = getIt<ListingStore>();
  }

  void _showInformationBottomSheet({Information? information}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => InformationBottomSheet(
            information: information,
            onSave: (text, icon) {
              if (information == null) {
                _handleAddInformation(text, icon);
              } else {
                _handleUpdateInformation(information.id, text, icon);
              }
            },
          ),
    );
  }

  void _handleAddInformation(String text, IconData icon) {
    _listingStore.addInformation(text, icon);

    if (_listingStore.errorMessage != null) {
      ToastService.showError(context, _listingStore.errorMessage!);
      _listingStore.clearErrorMessage();
    } else {
      ToastService.showSuccess(context, 'Informação adicionada com sucesso!');
    }
  }

  void _handleUpdateInformation(String id, String text, IconData icon) {
    _listingStore.updateInformation(id, text, icon);

    if (_listingStore.errorMessage != null) {
      ToastService.showError(context, _listingStore.errorMessage!);
      _listingStore.clearErrorMessage();
    } else {
      ToastService.showSuccess(context, 'Informação atualizada com sucesso!');
    }
  }

  void _handleRemoveInformation(String id) {
    _listingStore.removeInformation(id);
    ToastService.showSuccess(context, 'Informação removida');
  }

  void _handleDuplicateInformation(String id) {
    _listingStore.duplicateInformation(id);
    ToastService.showSuccess(context, 'Informação duplicada com sucesso!');
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _currentIndex == 0 ? 'Lista' : 'Detalhes'),
      drawer: const CustomDrawer(),
      body: GradientBackground(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildInformationsList(),
            ),
            DetailsPage(store: _listingStore),
          ],
        ),
      ),
      floatingActionButton:
          _currentIndex == 0
              ? FloatingActionButton(
                onPressed: () => _showInformationBottomSheet(),
                backgroundColor: AppTheme.fabBackground,
                child: const Icon(Icons.add, color: AppTheme.fabIcon),
              )
              : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: AppTheme.bottomNavBackground,
        selectedItemColor: AppTheme.bottomNavSelected,
        unselectedItemColor: AppTheme.bottomNavUnselected,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Lista'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Detalhes',
          ),
        ],
      ),
    );
  }

  Widget _buildInformationsList() {
    return Observer(
      builder: (_) {
        if (!_listingStore.hasInformations) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list, size: 64, color: AppTheme.textSecondaryOnDark),
                Spacing.lgVertical,
                Text(
                  'Nenhuma informação adicionada ainda',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondaryOnDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: _listingStore.informations.length,
          itemBuilder: (context, index) {
            final information = _listingStore.informations[index];
            return InformationCard(
              information: information,
              onEdit: (id) {
                _showInformationBottomSheet(information: information);
              },
              onDuplicate: _handleDuplicateInformation,
              onDelete: (id) {
                _showDeleteConfirmation(information);
              },
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(Information information) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text(
            'Deseja realmente excluir esta informação?\n\n"${information.text}"',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handleRemoveInformation(information.id);
              },
              child: const Text(
                'Excluir',
                style: TextStyle(color: AppTheme.error),
              ),
            ),
          ],
        );
      },
    );
  }
}
