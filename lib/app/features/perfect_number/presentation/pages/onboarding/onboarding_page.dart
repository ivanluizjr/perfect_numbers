import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/routes/app_router.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/onboarding/onboarding_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/widgets/dot_indicator_widget.dart';

class _OnboardingSlide {
  final String title;
  final String subtitle;
  final IconData icon;
  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const _slides = [
  _OnboardingSlide(
    title: 'Descubra a Perfeição\nMatemática',
    subtitle:
        'Um número perfeito é aquele que é igual à soma dos seus divisores próprios. Explore a beleza oculta na aritmética e desvende os segredos dos números gregos.',
    icon: Icons.auto_awesome_rounded,
  ),
  _OnboardingSlide(
    title: 'Verifique\nQualquer Número',
    subtitle:
        'Insira um número e descubra instantaneamente se ele é perfeito, com todos os seus divisores calculados.',
    icon: Icons.calculate_rounded,
  ),
  _OnboardingSlide(
    title: 'Explore\nIntervalos',
    subtitle:
        'Encontre todos os números perfeitos entre dois valores. 6, 28, 496, 8128... quantos você conhece?',
    icon: Icons.search_rounded,
  ),
];

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<OnboardingCubit>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();
  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.state < _slides.length - 1) {
      cubit.nextPage();
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish(context);
    }
  }

  Future<void> _finish(BuildContext context) async {
    await context.read<OnboardingCubit>().complete();
    if (context.mounted) {
      Routes.pushNamedAndRemoveAll(context, Routes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Explorar',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => _finish(context),
        ),
      ),
      body: BlocBuilder<OnboardingCubit, int>(
        builder: (context, currentPage) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged:
                      (i) => context.read<OnboardingCubit>().setPage(i),
                  itemCount: _slides.length,
                  itemBuilder: (_, i) => _SlidePage(slide: _slides[i]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                child: DotIndicatorWidget(
                  count: _slides.length,
                  current: currentPage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
                child: ElevatedButton(
                  onPressed: () => _next(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentPage == _slides.length - 1
                            ? 'Começar'
                            : 'Começar',
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => _finish(context),
                child: Text(
                  'Pular introdução',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  final _OnboardingSlide slide;
  const _SlidePage({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(slide.icon, size: 100, color: AppColors.primaryDark),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            slide.title,
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            slide.subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
