// ignore_for_file: public_member_api_docs

part of 'artwork_bloc.dart';

abstract class ArtworkEvent extends Equatable {
  const ArtworkEvent();

  @override
  List<Object> get props => [];
}

class ArtworkSubscriptionRequested extends ArtworkEvent {
  const ArtworkSubscriptionRequested();
}

class ArtworkChanged extends ArtworkEvent {
  const ArtworkChanged({required this.artworkIndex});

  /// The index of the changed theme in [ArtworkState.artworks].
  final int artworkIndex;

  @override
  List<Object> get props => [artworkIndex];
}
