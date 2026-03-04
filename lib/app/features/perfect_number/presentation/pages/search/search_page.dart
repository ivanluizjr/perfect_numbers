import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
        title: const Text('Buscar em Intervalo'),
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
                    'Encontre Números Perfeitos',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ex: 6 e 28 são os primeiros números perfeitos.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
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
                              'Início',
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
                              'Fim',
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
                    label: const Text('Encontrar Números Perfeitos'),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          BlocBuilder<RangeSearchCubit, RangeSearchState>(
            builder: (context, state) {
              if (state is RangeSearchLoading) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
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
                          color: AppColors.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        state.message,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (state is RangeSearchEmpty) {
                return const SliverFillRemaining(
                  child: EmptyStateWidget(
                    icon: Icons.search_off_rounded,
                    message: 'Nenhum número perfeito encontrado',
                    subtitle: 'Tente um intervalo maior, como 1 a 10000.',
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
                          title:
                              'Resultados encontrados (${state.results.length})',
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
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: EmptyStateWidget(
                    icon: Icons.bar_chart_rounded,
                    message: 'Continue explorando novos intervalos',
                    subtitle: 'para descobrir propriedades matemáticas.',
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
