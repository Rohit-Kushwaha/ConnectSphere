part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {
  final ThemeData themeMode;
  ThemeInitial({required this.themeMode});
}
