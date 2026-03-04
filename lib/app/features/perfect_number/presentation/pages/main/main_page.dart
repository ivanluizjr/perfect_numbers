import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfect_numbers/app/core/theme/app_colors.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/main/main_cubit.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/history/history_page.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/home/home_page.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/search/search_page.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/pages/settings/settings_page.dart';

class MainPage extends StatelessWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  static const _tabs = [
    HomePage(),
    SearchPage(),
    HistoryPage(),
    SettingsPage(),
  ];

  static const _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Início'),
    BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Buscar'),
    BottomNavigationBarItem(
      icon: Icon(Icons.history_rounded),
      label: 'Histórico',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: 'Ajustes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<MainCubit>()..selectTab(initialIndex),
      child: BlocBuilder<MainCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            body: IndexedStack(index: selectedIndex, children: _tabs),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.of(context).border,
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (i) => context.read<MainCubit>().selectTab(i),
                items: _navItems,
              ),
            ),
          );
        },
      ),
    );
  }
}
