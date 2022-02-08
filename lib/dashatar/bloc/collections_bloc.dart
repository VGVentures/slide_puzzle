import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  CollectionsBloc() : super(CollectionsInitial()) {
    on<CollectionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
