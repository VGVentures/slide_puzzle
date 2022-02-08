// ignore_for_file: public_member_api_docs
part of 'collections_bloc.dart';

abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();

  @override
  List<Object> get props => [];
}

class CollectionsSubscriptionRequested extends CollectionsEvent {
  const CollectionsSubscriptionRequested();
}

class CollectionsChanged extends CollectionsEvent {
  const CollectionsChanged({required this.collectionSlug});

  /// The index of the changed theme in [CollectionsState.collections].
  final String collectionSlug;

  @override
  List<Object> get props => [collectionSlug];
}
