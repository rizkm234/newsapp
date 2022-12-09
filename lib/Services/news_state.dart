part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitial extends NewsState {}
class changedScreen extends NewsState {}
class getDataState extends NewsState {}
class changeThemeState extends NewsState {}
