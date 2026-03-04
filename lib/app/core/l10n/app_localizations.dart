import 'package:flutter/material.dart';

class AppLocalizations {
  final bool _en;
  const AppLocalizations._(this._en);

  static AppLocalizations of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AppLocalizations._(locale.languageCode == 'en');
  }

  String get appTitle => _en ? 'Perfect Numbers' : 'Números Perfeitos';
  String get cancel => _en ? 'Cancel' : 'Cancelar';

  String get checkNumberTitle =>
      _en ? 'Number Verification' : 'Verificação de Número';
  String get checkNumberSubtitle =>
      _en
          ? 'Discover if your number is perfect through the sum of its divisors.'
          : 'Descubra se o seu número é perfeito através da soma de seus divisores.';
  String get enterNumber => _en ? 'Enter a number' : 'Insira um número';
  String get enterNumberHint => _en ? 'e.g. 6, 28, 496' : 'Ex: 6, 28, 496';
  String get checkNow => _en ? 'Check Now' : 'Verificar Agora';

  String isPerfect(num n) =>
      _en ? '$n is a perfect number! 🎉' : '$n é um número perfeito! 🎉';
  String isNotPerfect(num n) =>
      _en ? '$n is not a perfect number' : '$n não é um número perfeito';
  String divisorSum(num sum, num n, bool perfect) =>
      _en
          ? 'Sum: $sum ${perfect ? "= $n ✓" : "≠ $n"}'
          : 'Soma: $sum ${perfect ? "= $n ✓" : "≠ $n"}';

  String get properDivisors => _en ? 'Proper divisors:' : 'Divisores próprios:';
  String get none => _en ? 'None' : 'Nenhum';
  String get whatIsTitle =>
      _en ? 'What is a perfect number?' : 'O que é um número perfeito?';
  String get whatIsRichPart1 =>
      _en ? 'In mathematics, a ' : 'Na matemática, um ';
  String get whatIsRichBold => _en ? 'perfect number' : 'número perfeito';
  String get whatIsRichPart2 =>
      _en
          ? ' is a positive integer equal to the sum of its positive proper divisors (excluding the number itself).'
          : ' é um número inteiro para o qual a soma de todos os seus divisores positivos próprios (excluindo o próprio número) é igual ao próprio número.';
  String get whatIsExample =>
      _en
          ? 'Example: The number 6 has divisors 1, 2 and 3.\n1 + 2 + 3 = 6. Therefore, 6 is perfect.'
          : 'Exemplo: O número 6 possui os divisores 1, 2 e 3.\n1 + 2 + 3 = 6. Portanto, 6 é perfeito.';

  String get searchTitle => _en ? 'Search in Range' : 'Buscar em Intervalo';
  String get findTitle =>
      _en ? 'Find Perfect Numbers' : 'Encontre Números Perfeitos';
  String get findSubtitle =>
      _en
          ? 'e.g. 6 and 28 are the first perfect numbers.'
          : 'Ex: 6 e 28 são os primeiros números perfeitos.';
  String get rangeStart => _en ? 'Start' : 'Início';
  String get rangeEnd => _en ? 'End' : 'Fim';
  String get findButton =>
      _en ? 'Find Perfect Numbers' : 'Encontrar Números Perfeitos';
  String resultsFound(int n) =>
      _en ? 'Results found ($n)' : 'Resultados encontrados ($n)';
  String get noResultsFound =>
      _en ? 'No perfect numbers found' : 'Nenhum número perfeito encontrado';
  String get tryLargerRange =>
      _en
          ? 'Try a larger range, such as 1 to 10000.'
          : 'Tente um intervalo maior, como 1 a 10000.';
  String get exploreRanges =>
      _en
          ? 'Keep exploring new ranges'
          : 'Continue explorando novos intervalos';
  String get discoverMath =>
      _en
          ? 'to discover mathematical properties.'
          : 'para descobrir propriedades matemáticas.';

  String get historyTitle => _en ? 'History' : 'Histórico';
  String get tabAll => _en ? 'All' : 'Todos';
  String get tabFavorites => _en ? 'Favorites' : 'Favoritos';
  String get clearHistory => _en ? 'Clear history' : 'Limpar histórico';
  String get clearHistoryConfirm =>
      _en
          ? 'All records will be deleted.'
          : 'Todos os registros serão apagados.';
  String get clear => _en ? 'Clear' : 'Limpar';
  String get today => _en ? 'Today' : 'Hoje';
  String get yesterday => _en ? 'Yesterday' : 'Ontem';
  String historyIsPerfect(num n) =>
      _en ? '$n is a perfect number' : '$n é um número perfeito';
  String historyIsNotPerfect(dynamic n) =>
      _en ? '$n is not perfect' : '$n não é perfeito';
  String historyInterval(dynamic start, dynamic end) =>
      _en ? 'Range: $start to $end' : 'Intervalo: $start a $end';
  String get singleCheck =>
      _en ? 'Single number check' : 'Verificação de número único';
  String historyResultsCount(int n) =>
      _en ? '$n perfect number(s) found' : '$n perfeito(s) encontrado(s)';
  String get viewDetails => _en ? 'View details' : 'Ver detalhes';
  String get viewList => _en ? 'View list' : 'Ver lista';
  String get noHistory => _en ? 'No history yet' : 'Nenhum histórico ainda';
  String get noHistorySubtitle =>
      _en
          ? 'Check or search for perfect numbers to see history here.'
          : 'Verifique ou busque números perfeitos para ver o histórico aqui.';
  String get noFavorites => _en ? 'No favorites yet' : 'Nenhum favorito ainda';

  String get settingsTitle => _en ? 'Settings' : 'Ajustes';
  String get preferences => _en ? 'Preferences' : 'Preferências';
  String get darkTheme => _en ? 'Dark Theme' : 'Tema Escuro';
  String get darkThemeSubtitle =>
      _en
          ? 'Switch between light and dark modes'
          : 'Alternar entre modos claro e escuro';
  String get language => _en ? 'Language' : 'Idioma';
  String get languageSubtitle =>
      _en ? 'App display language' : 'Idioma de exibição do aplicativo';
  String get calculations => _en ? 'Calculations' : 'Cálculos';
  String get computationAlerts =>
      _en ? 'Computation Alerts' : 'Alertas de Cálculo';
  String get computationAlertsSubtitle =>
      _en
          ? 'Notify when long calculations finish'
          : 'Notificar quando cálculos longos terminarem';
  String get aboutSection =>
      _en ? 'About Perfect Numbers' : 'Sobre Números Perfeitos';
  String get aboutTitle =>
      _en ? 'What is a Perfect Number?' : 'O que é um Número Perfeito?';
  String get aboutBody =>
      _en
          ? 'In number theory, a perfect number is a positive integer equal to the sum of its positive divisors, excluding the number itself. For example, 6 has divisors 1, 2 and 3, and 1 + 2 + 3 = 6.'
          : 'Em teoria dos números, um número perfeito é um inteiro positivo igual à soma de seus divisores positivos, excluindo o próprio número. Por exemplo, 6 tem divisores 1, 2 e 3, e 1 + 2 + 3 = 6.';
  String get sequenceSlogan =>
      _en ? 'THE SEQUENCE OF PERFECTION' : 'A SEQUÊNCIA DA PERFEIÇÃO';
  String get historyLink =>
      _en ? 'History of Perfect Numbers' : 'História dos Números Perfeitos';
  String get appVersion => _en ? 'App Version' : 'Versão do App';
  String get selectLanguage => _en ? 'Select language' : 'Selecionar idioma';

  String get navHome => _en ? 'Home' : 'Início';
  String get navSearch => _en ? 'Search' : 'Buscar';
  String get navHistory => _en ? 'History' : 'Histórico';
  String get navSettings => _en ? 'Settings' : 'Ajustes';

  String get onboardingExplore => _en ? 'Explore' : 'Explorar';
  String get onboardingSkip => _en ? 'Skip introduction' : 'Pular introdução';
  String get onboardingNext => _en ? 'Next' : 'Próximo';
  String get onboardingGetStarted => _en ? 'Get Started' : 'Começar';
  String get slide1Title =>
      _en
          ? 'Discover Mathematical\nPerfection'
          : 'Descubra a Perfeição\nMatemática';
  String get slide1Subtitle =>
      _en
          ? 'A perfect number equals the sum of its proper divisors. Explore the hidden beauty in arithmetic and uncover the secrets of Greek numbers.'
          : 'Um número perfeito é aquele que é igual à soma dos seus divisores próprios. Explore a beleza oculta na aritmética e desvende os segredos dos números gregos.';
  String get slide2Title =>
      _en ? 'Verify\nAny Number' : 'Verifique\nQualquer Número';
  String get slide2Subtitle =>
      _en
          ? 'Enter a number and instantly discover if it is perfect, with all its divisors calculated.'
          : 'Insira um número e descubra instantaneamente se ele é perfeito, com todos os seus divisores calculados.';
  String get slide3Title => _en ? 'Explore\nRanges' : 'Explore\nIntervalos';
  String get slide3Subtitle =>
      _en
          ? 'Find all perfect numbers between two values. 6, 28, 496, 8128... how many do you know?'
          : 'Encontre todos os números perfeitos entre dois valores. 6, 28, 496, 8128... quantos você conhece?';
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
