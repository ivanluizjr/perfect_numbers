import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/l10n/app_localizations.dart';
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
        backgroundColor: AppColors.of(context).background,
        appBar: AppBar(
          title: Text(context.l10n.historyTitle),
          automaticallyImplyLeading: false,
          actions: [
            BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state is HistoryLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.delete_sweep_rounded),
                    color: AppColors.of(context).primary,
                    onPressed: () => _confirmClear(context),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: context.l10n.tabAll),
              Tab(text: context.l10n.tabFavorites),
            ],
          ),
        ),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.of(context).primary,
                ),
              );
            }
            if (state is HistoryEmpty) {
              return EmptyStateWidget(
                icon: Icons.history_rounded,
                message: context.l10n.noHistory,
                subtitle: context.l10n.noHistorySubtitle,
              );
            }
            if (state is HistoryLoaded) {
              return TabBarView(
                children: [
                  _HistoryList(entries: state.entries),
                  state.favorites.isEmpty
                      ? EmptyStateWidget(
                        icon: Icons.favorite_border_rounded,
                        message: context.l10n.noFavorites,
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
            backgroundColor: AppColors.of(context).card,
            title: Text(
              context.l10n.clearHistory,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
            ),
            content: Text(
              context.l10n.clearHistoryConfirm,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(context.l10n.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  context.l10n.clear,
                  style: TextStyle(color: AppColors.of(context).error),
                ),
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
    final grouped = _groupByDate(context, entries);
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

  Map<String, List<HistoryEntry>> _groupByDate(
    BuildContext context,
    List<HistoryEntry> entries,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final grouped = <String, List<HistoryEntry>>{};

    for (final e in entries) {
      final d = DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      final String label;
      if (d == today) {
        label = context.l10n.today;
      } else if (d == yesterday) {
        label = context.l10n.yesterday;
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
                ? context.l10n.historyIsPerfect(entry.singleResult!.number)
                : context.l10n.historyIsNotPerfect(entry.singleResult?.number))
            : context.l10n.historyInterval(entry.rangeStart, entry.rangeEnd);

    final subtitle =
        isSingle
            ? (entry.singleResult != null ? context.l10n.singleCheck : '')
            : context.l10n.historyResultsCount(entry.rangeResults?.length ?? 0);

    final thumbnailText =
        isSingle ? '${entry.singleResult?.number ?? ''}' : '#';

    final thumbnailColor =
        isSingle && entry.singleResult?.isPerfect == true
            ? AppColors.of(context).primaryDark
            : AppColors.of(context).surfaceVariant;

    final thumbnailTextColor =
        isSingle && entry.singleResult?.isPerfect == true
            ? AppColors.of(context).primary
            : AppColors.of(context).textMuted;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.of(context).card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.of(context).border.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: AppColors.of(context).textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeStr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.of(context).textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.of(context).textSecondary,
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
                          color: AppColors.of(
                            context,
                          ).primary.withValues(alpha: 0.5),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: AppColors.of(context).primary,
                        textStyle: AppTextStyles.labelSmall,
                      ),
                      child: Text(
                        isSingle
                            ? context.l10n.viewDetails
                            : context.l10n.viewList,
                      ),
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
                                ? AppColors.of(context).primary
                                : AppColors.of(context).textMuted,
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
