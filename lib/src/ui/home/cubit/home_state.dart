part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {
  bool? isBusy;
  List<ArtistModel>? artistList;
  List<User>? userList;
  int? selectTab;

  HomeInitial({
    this.isBusy = false,
    this.selectTab = 0,
    this.artistList,
    this.userList,
  });

  HomeInitial copyWith({
    bool? isBusy,
    List<ArtistModel>? artistList,
    List<User>? userList,
    int? selectTab,
  }) {
    return HomeInitial(
      isBusy: isBusy ?? this.isBusy,
      artistList: artistList ?? this.artistList,
      userList: userList ?? this.userList,
      selectTab: selectTab ?? this.selectTab,
    );
  }
}
