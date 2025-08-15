part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}
final class ChangeBottomNav extends HomeState{
  int index;
  ChangeBottomNav(this.index);
  @override
  // TODO: implement props
  List<Object?> get props =>[index];
}

