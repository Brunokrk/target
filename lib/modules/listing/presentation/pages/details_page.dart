import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:target/core/theme/app_theme.dart';
import 'package:target/modules/listing/presentation/stores/listing_store.dart';
import 'package:target/shared/widgets/widgets.dart';

class DetailsPage extends StatelessWidget {
  final ListingStore store;

  const DetailsPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Observer(
        builder:
            (_) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildStatCard(
                    icon: Icons.list,
                    title: 'Total de Linhas',
                    value: store.totalItems.toString(),
                    color: AppTheme.statItems,
                  ),
                  Spacing.smVertical,
                  _buildStatCard(
                    icon: Icons.edit,
                    title: 'Edições Realizadas',
                    value: store.editCount.toString(),
                    color: AppTheme.statEdits,
                  ),
                  Spacing.smVertical,
                  _buildStatCard(
                    icon: Icons.text_fields,
                    title: 'Caracteres Totais',
                    value: store.totalCharacters.toString(),
                    color: AppTheme.statCharacters,
                  ),
                  Spacing.smVertical,
                  _buildChartCard(store),
                ],
              ),
            ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            Spacing.horizontal(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  Spacing.smVertical,
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(ListingStore store) {
    final lettersPercentage = store.lettersPercentage;
    final numbersPercentage = store.numbersPercentage;
    final total = store.totalCharacters;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Distribuição de Caracteres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            Spacing.lgVertical,
            if (total == 0)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'Nenhum dado disponível',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              )
            else
              Column(
                children: [
                  _buildChartBar(
                    label: 'Letras',
                    percentage: lettersPercentage,
                    color: AppTheme.statLetters,
                  ),
                  Spacing.mdVertical,
                  _buildChartBar(
                    label: 'Números',
                    percentage: numbersPercentage,
                    color: AppTheme.statNumbers,
                  ),
                  Spacing.lgVertical,
                  _buildChartLegend(store),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({
    required String label,
    required double percentage,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '${percentage.toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Spacing.smVertical,
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 24,
            backgroundColor: AppTheme.progressBackground,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _buildChartLegend(ListingStore store) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.legendBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem(
            color: AppTheme.statLetters,
            label: 'Letras',
            value: store.totalLetters.toString(),
          ),
          Container(width: 1, height: 40, color: AppTheme.legendDivider),
          _buildLegendItem(
            color: AppTheme.statNumbers,
            label: 'Números',
            value: store.totalNumbers.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Spacing.xsVertical,
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}
