// ignore_for_file: public_member_api_docs
part of 'collections_bloc.dart';

enum CollectionsStatus { initial, loading, success, failure }

// a few to try: doodles-official, dartart, themushroompeople, copypasteearth,
// para-bellum-by-matty-mariansky
class CollectionsState extends Equatable {
  const CollectionsState({
    this.status = CollectionsStatus.initial,
    this.collections = const [],
    this.selectedCollection = 'doodles-official',
  });

  final CollectionsStatus status;

  /// The list of all available [Collection]s.
  final List<Collection> collections;

  /// Currently selected [Collection].
  final String selectedCollection;

  @override
  List<Object> get props => [status, collections, selectedCollection];

  CollectionsState copyWith({
    CollectionsStatus Function()? status,
    List<Collection> Function()? collections,
    String Function()? selectedCollection,
  }) {
    return CollectionsState(
      status: status != null ? status() : this.status,
      collections: collections != null ? collections() : this.collections,
      selectedCollection: selectedCollection != null
          ? selectedCollection()
          : this.selectedCollection,
    );
  }
}
