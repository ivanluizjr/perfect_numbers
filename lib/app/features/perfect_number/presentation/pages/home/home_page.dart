import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/l10n/app_localizations.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/check_number/check_number_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/check_number/check_number_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<CheckNumberCubit>(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();
  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: Text(context.l10n.appTitle),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card com ícone sigma
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'Σ',
                  style: TextStyle(
                    fontSize: 72,
                    color: AppColors.of(context).primaryDark,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.checkNumberTitle,
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.checkNumberSubtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.of(context).primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.l10n.enterNumber,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: AppColors.of(context).textPrimary,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: context.l10n.enterNumberHint,
              ),
              onSubmitted:
                  (_) =>
                      context.read<CheckNumberCubit>().check(_controller.text),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  () =>
                      context.read<CheckNumberCubit>().check(_controller.text),
              child: Text(context.l10n.checkNow),
            ),
            const SizedBox(height: 24),
            // Result area
            BlocBuilder<CheckNumberCubit, CheckNumberState>(
              builder: (context, state) {
                if (state is CheckNumberLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.of(context).primary,
                    ),
                  );
                }
                if (state is CheckNumberError) {
                  return Container(
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
                  );
                }
                if (state is CheckNumberSuccess) {
                  return _ResultCard(result: state.result);
                }
                return _InfoCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final dynamic result;
  const _ResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final isPerfect = result.isPerfect as bool;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            isPerfect
                ? AppColors.of(context).successSubtle
                : AppColors.of(context).surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              isPerfect
                  ? AppColors.of(context).primary.withValues(alpha: 0.5)
                  : AppColors.of(context).border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isPerfect ? Icons.verified_rounded : Icons.cancel_rounded,
                color:
                    isPerfect
                        ? AppColors.of(context).primary
                        : AppColors.of(context).error,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isPerfect
                      ? context.l10n.isPerfect(result.number)
                      : context.l10n.isNotPerfect(result.number),
                  style: AppTextStyles.titleLarge.copyWith(
                    color:
                        isPerfect
                            ? AppColors.of(context).primary
                            : AppColors.of(context).error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.of(context).border),
          const SizedBox(height: 12),
          Text(
            context.l10n.properDivisors,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            result.divisors.isEmpty
                ? context.l10n.none
                : result.divisors.join(', '),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.of(context).textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.divisorSum(
              result.divisorSum,
              result.number,
              isPerfect,
            ),
            style: AppTextStyles.bodyMedium.copyWith(
              color:
                  isPerfect
                      ? AppColors.of(context).primary
                      : AppColors.of(context).textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.of(context).border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: AppColors.of(context).primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.whatIsTitle,
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.of(context).textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
              children: [
                TextSpan(text: context.l10n.whatIsRichPart1),
                TextSpan(
                  text: context.l10n.whatIsRichBold,
                  style: TextStyle(
                    color: AppColors.of(context).textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: context.l10n.whatIsRichPart2),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.of(context).card,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.l10n.whatIsExample,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.of(context).textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
