part of 'artist_cubit.dart';

abstract class ArtistState {}

class ArtistInitial extends ArtistState {
  bool? isBusy;
  ArtistArg? args;
  ArtistInitial({
    this.args,
    this.isBusy = false,});

  ArtistInitial copyWith({
    bool? isBusy,
    ArtistArg? args,
  }) {
    return ArtistInitial(
      isBusy: isBusy ?? this.isBusy,
      args: args ?? this.args,
    );
  }
}
