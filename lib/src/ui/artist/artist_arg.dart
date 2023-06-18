import 'package:syscraft_task/model/artist_model.dart';

enum ArtistAction { add, edit }

class ArtistArg {
  ArtistAction action;
  ArtistModel? artist;

  ArtistArg({required this.action, this.artist});
}
