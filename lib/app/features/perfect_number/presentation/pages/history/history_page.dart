import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';
import 'package:perfect_numbers/app/features/perfect_number/domain/entities/history_entry.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/history/history_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/history/history_state.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/widgets/empty_state_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<HistoryCubit>()..load(),
      child: const _HistoryView(),
    );
  }
}

class _HistoryView extends StatelessWidget {
  const _HistoryView();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Histórico'),
          automaticallyImplyLeading: false,
          actions: [
            BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.delete_sweep_rounded),
                    color: AppColors.primary,
                    onPressed: () => _confirmClear(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: 'Todos'), Tab(text: 'Favoritos')],
          ),
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is HistoryEmpty) {
              return const EmptyStateWidget(
                icon: Icons.history_rounded,
                message: 'Nenhum histórico ainda',
                subtitle:
                    'Verifique ou busque números perfeitos para ver o histórico aqui.',
              );
            }
            if (state is HistoryLoaded) {
              return TabBarView(
                children: [
                  _HistoryList(entries: state.entries),
                  state.favorites.isEmpty
                      ? const EmptyStateWidget(
                        icon: Icons.favorite_border_rounded,
                        message: 'Nenhum favorito ainda',
                      )
                      : _HistoryList(entries: state.favorites),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<void> _confirmClear(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: AppColors.card,
            title: Text(
              'Limpar histórico',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            content: Text(
              'Todos os registros serão apagados.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Limpar', style: TextStyle(color: AppColors.error)),
              ),
            ],
          ),
    );
    if (confirmed == true && context.mounted) {
      context.read<HistoryCubit>().clearAll();
    }
  }
}

class _HistoryList extends StatelessWidget {
  final List<HistoryEntry> entries;
  const _HistoryList({required this.entries});

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(entries);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grouped.keys.length,
      itemBuilder: (context, sectionIndex) {
        final dateLabel = grouped.keys.elementAt(sectionIndex);
        final items = grouped[dateLabel]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                dateLabel.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textMuted,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            ...items.map((e) => _HistoryEntryCard(entry: e)),
          ],
        );
      },
    );
  }

  Map<String, List<HistoryEntry>> _groupByDate(List<HistoryEntry> entries) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final grouped = <String, List<HistoryEntry>>{};

    for (final e in entries) {
      final d = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      final String label;
      if (d == today) {
        label = 'Hoje';
      } else if (d == yesterday) {
        label = 'Ontem';
      } else {
        label =
            '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
      }
      grouped.putIfAbsent(label, () => []).add(e);
    }
    return grouped;
  }
}

class _HistoryEntryCard extends StatelessWidget {
  final HistoryEntry entry;
  const _HistoryEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HistoryCubit>();
    final isSingle = entry.type == HistoryEntryType.singleCheck;
    final timeStr =
        '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}';

    final title =
        isSingle
            ? (entry.singleResult?.isPerfect == true
                ? '${entry.singleResult!.number} é um número perfeito'
                : '${entry.singleResult?.number} não é perfeito')
            : 'Intervalo: ${entry.rangeStart} a ${entry.rangeEnd}';

    final subtitle =
        isSingle
            ? (entry.singleResult != null ? 'Verificação de número único' : '')
            : '${entry.rangeResults?.length ?? 0} perfeito(s) encontrado(s)';

    final thumbnailText =
        isSingle ? '${entry.singleResult?.number ?? ''}' : '#';

    final thumbnailColor =
        isSingle && entry.singleResult?.isPerfect == true
            ? AppColors.primaryDark
            : AppColors.surfaceVariant;

    final thumbnailTextColor =
        isSingle && entry.singleResult?.isPerfect == true
            ? AppColors.primary
            : AppColors.textMuted;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeStr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        side: BorderSide(
                          color: AppColors.primary.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: AppColors.primary,
                        textStyle: AppTextStyles.labelSmall,
                      ),
                      child: Text(isSingle ? 'Ver detalhes' : 'Ver lista'),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => cubit.toggleFavorite(entry.id),
                      child: Icon(
                        entry.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 20,
                        color:
                            entry.isFavorite
                                ? AppColors.primary
                                : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: thumbnailColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              thumbnailText,
              style: AppTextStyles.headlineMedium.copyWith(
                color: thumbnailTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
