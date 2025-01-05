part of 'language_cubit.dart';

sealed class LanguageState {
  const LanguageState();

  // @override
  // List<Object> get props => [];
}

class ChangeLanguageState extends LanguageState {
  final Locale locale;
  const ChangeLanguageState({required this.locale});
  // @override
  // List<Object> get props => [locale];
}
