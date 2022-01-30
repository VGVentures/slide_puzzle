import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nftpuzzlefun/dashatar/artworks/my_custom_artwork_one.dart';
import 'package:opensea_repository/opensea_repository.dart';

part 'artwork_event.dart';
part 'artwork_state.dart';

/// doc
class ArtworkBloc extends Bloc<ArtworkEvent, ArtworkState> {
  /// doc
  ArtworkBloc({required List<Artwork> artworks})
      : super(ArtworkState(artworks: artworks)) {
    // on<ArtworkEvent>(_onArtworkChanged);
    on<ArtworkChanged>(_onArtworkChanged);
  }

  void _onArtworkChanged(
    ArtworkChanged event,
    Emitter<ArtworkState> emit,
  ) {
    emit(state.copyWith(artwork: state.artworks[event.artworkIndex]));
  }
}
