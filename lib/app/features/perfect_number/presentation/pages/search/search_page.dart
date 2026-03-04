import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/range_search/range_search_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/range_search/range_search_state.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/widgets/empty_state_widget.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/widgets/perfect_number_card_widget.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/widgets/section_header_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<RangeSearchCubit>(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();
  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _startController = TextEditingController(text: '1');
  final _endController = TextEditingController(text: '1000');

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: Text(context.l10n.searchTitle),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.l10n.findTitle,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.findSubtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.of(context).primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.rangeStart,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _startController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: AppColors.of(context).textPrimary,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(hintText: '1'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.rangeEnd,
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.of(context).textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _endController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                color: AppColors.of(context).textPrimary,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                hintText: '1000',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed:
                        () => context.read<RangeSearchCubit>().search(
                          _startController.text,
                          _endController.text,
                        ),
                    icon: const Icon(Icons.grid_view_rounded),
                    label: Text(context.l10n.findButton),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          BlocBuilder<RangeSearchCubit, RangeSearchState>(
            builder: (context, state) {
              if (state is RangeSearchLoading) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.of(context).primary,
                      ),
                    ),
                  ),
                );
              }
              if (state is RangeSearchError) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.of(context).errorSubtle,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.of(
                            context,
                          ).error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        state.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.of(context).error,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (state is RangeSearchEmpty) {
                return SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: Icons.search_off_rounded,
                    message: context.l10n.noResultsFound,
                    subtitle: context.l10n.tryLargerRange,
                  ),
                );
              }
              if (state is RangeSearchSuccess) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      if (i == 0) {
                        return SectionHeaderWidget(
                          title: context.l10n.resultsFound(
                            state.results.length,
                          ),
                        );
                      }
                      return PerfectNumberCardWidget(
                        result: state.results[i - 1],
                      );
                    }, childCount: state.results.length + 1),
                  ),
                );
              }
              // Initial / empty hint
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: EmptyStateWidget(
                    icon: Icons.bar_chart_rounded,
                    message: context.l10n.exploreRanges,
                    subtitle: context.l10n.discoverMath,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
