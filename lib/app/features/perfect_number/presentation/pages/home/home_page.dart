import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
        title: const Text('Números Perfeitos'),
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
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Verificação de Número',
              style: AppTextStyles.headlineMedium.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Descubra se o seu número é perfeito através da soma de seus divisores.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Insira um número',
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
              decoration: const InputDecoration(hintText: 'Ex: 6, 28, 496'),
              onSubmitted:
                  (_) =>
                      context.read<CheckNumberCubit>().check(_controller.text),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  () =>
                      context.read<CheckNumberCubit>().check(_controller.text),
              child: const Text('Verificar Agora'),
            ),
            const SizedBox(height: 24),
            // Result area
            BlocBuilder<CheckNumberCubit, CheckNumberState>(
              builder: (context, state) {
                if (state is CheckNumberLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state is CheckNumberError) {
                  return Container(
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
                  ? AppColors.primary.withValues(alpha: 0.5)
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
                color: isPerfect ? AppColors.primary : AppColors.error,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isPerfect
                      ? '${result.number} é um número perfeito! 🎉'
                      : '${result.number} não é um número perfeito',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: isPerfect ? AppColors.primary : AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.of(context).border),
          const SizedBox(height: 12),
          Text(
            'Divisores próprios:',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            result.divisors.isEmpty ? 'Nenhum' : result.divisors.join(', '),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.of(context).textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Soma: ${result.divisorSum} ${isPerfect ? "= ${result.number} ✓" : "≠ ${result.number}"}',
            style: AppTextStyles.bodyMedium.copyWith(
              color:
                  isPerfect
                      ? AppColors.primary
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
              const Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'O que é um número perfeito?',
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
                const TextSpan(text: 'Na matemática, um '),
                TextSpan(
                  text: 'número perfeito',
                  style: TextStyle(
                    color: AppColors.of(context).textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(
                  text:
                      ' é um número inteiro para o qual a soma de todos os seus divisores positivos próprios (excluindo o próprio número) é igual ao próprio número.',
                ),
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
              'Exemplo: O número 6 possui os divisores 1, 2 e 3.\n1 + 2 + 3 = 6. Portanto, 6 é perfeito.',
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
