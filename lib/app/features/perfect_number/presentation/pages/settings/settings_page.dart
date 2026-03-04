import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<SettingsCubit>(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: const Text('Ajustes'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _SectionLabel(title: 'Preferências'),
              const SizedBox(height: 8),
              _SettingsCard(
                children: [
                  _SettingsTile(
                    icon: Icons.dark_mode_rounded,
                    title: 'Tema Escuro',
                    subtitle: 'Alternar entre modos claro e escuro',
                    trailing: Switch(
                      value: state.isDark,
                      onChanged: (_) => cubit.toggleTheme(),
                    ),
                  ),
                  Divider(color: AppColors.of(context).border, height: 1),
                  _SettingsTile(
                    icon: Icons.translate_rounded,
                    title: 'Idioma',
                    subtitle: 'Idioma de exibição do aplicativo',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.language,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.of(context).textSecondary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.of(context).textMuted,
                          size: 20,
                        ),
                      ],
                    ),
                    onTap:
                        () =>
                            _showLanguagePicker(context, cubit, state.language),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionLabel(title: 'Cálculos'),
              const SizedBox(height: 8),
              _SettingsCard(
                children: [
                  _SettingsTile(
                    icon: Icons.notifications_active_rounded,
                    title: 'Alertas de Cálculo',
                    subtitle: 'Notificar quando cálculos longos terminarem',
                    trailing: Switch(
                      value: state.computationAlerts,
                      onChanged: (_) => cubit.toggleComputationAlerts(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionLabel(title: 'Sobre Números Perfeitos'),
              const SizedBox(height: 8),
              _SettingsCard(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primaryDark,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.info_outline_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'O que é um Número Perfeito?',
                                style: AppTextStyles.titleMedium.copyWith(
                                  color: AppColors.of(context).textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Em teoria dos números, um número perfeito é um inteiro positivo igual à soma de seus divisores positivos, excluindo o próprio número. Por exemplo, 6 tem divisores 1, 2 e 3, e 1 + 2 + 3 = 6.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.of(context).textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '6, 28, 496...',
                                style: AppTextStyles.headlineLarge.copyWith(
                                  color: AppColors.textOnPrimary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'A SEQUÊNCIA DA PERFEIÇÃO',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textOnPrimary.withValues(
                                    alpha: 0.8,
                                  ),
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: AppColors.of(context).border, height: 1),
                  _SettingsTile(
                    icon: Icons.open_in_new_rounded,
                    title: 'História dos Números Perfeitos',
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    onTap:
                        () => launchUrl(
                          Uri.parse(
                            'https://en.wikipedia.org/wiki/Perfect_number',
                          ),
                        ),
                  ),
                  Divider(color: AppColors.of(context).border, height: 1),
                  _SettingsTile(
                    icon: Icons.info_rounded,
                    title: 'Versão do App',
                    trailing: Text(
                      'v2.4.0 (Emerald)',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.of(context).textMuted,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    SettingsCubit cubit,
    String current,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.of(context).card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                'Selecionar idioma',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.of(context).textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              for (final lang in ['Português', 'English'])
                ListTile(
                  title: Text(
                    lang,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  trailing:
                      lang == current
                          ? const Icon(
                            Icons.check_rounded,
                            color: AppColors.primary,
                          )
                          : null,
                  onTap: () {
                    cubit.setLanguage(lang);
                    Navigator.pop(context);
                  },
                ),
              const SizedBox(height: 16),
            ],
          ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.primary,
        letterSpacing: 1.5,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.of(context).border.withValues(alpha: 0.5),
        ),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 22),
      ),
      title: Text(
        title,
        style: AppTextStyles.titleSmall.copyWith(
          color: AppColors.of(context).textPrimary,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.of(context).textMuted,
                ),
              )
              : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
