// Mocks generated by Mockito 5.1.0 from annotations
// in tv/test/presentation/bloc/tv_watchlist_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:core/utils/failure.dart' as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tv/domain/entities/tv.dart' as _i7;
import 'package:tv/domain/entities/tv_detail.dart' as _i10;
import 'package:tv/domain/repositories/tv_repository.dart' as _i3;
import 'package:tv/domain/usecases/get_watchlist_tv.dart' as _i4;
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart' as _i8;
import 'package:tv/domain/usecases/remove_watchlist_tv.dart' as _i11;
import 'package:tv/domain/usecases/save_watchlist_tv.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTvRepository_1 extends _i1.Fake implements _i3.TvRepository {}

/// A class which mocks [GetWatchlistTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTv extends _i1.Mock implements _i4.GetWatchlistTv {
  MockGetWatchlistTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, List<_i7.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<_i2.Either<_i6.Failure, List<_i7.Tv>>>.value(
                  _FakeEither_0<_i6.Failure, List<_i7.Tv>>()))
          as _i5.Future<_i2.Either<_i6.Failure, List<_i7.Tv>>>);
}

/// A class which mocks [GetWatchListTvStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvStatus extends _i1.Mock
    implements _i8.GetWatchListTvStatus {
  MockGetWatchListTvStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_1()) as _i3.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvWatchlist extends _i1.Mock implements _i9.SaveTvWatchlist {
  MockSaveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_1()) as _i3.TvRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvWatchlist extends _i1.Mock implements _i11.RemoveTvWatchlist {
  MockRemoveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvRepository_1()) as _i3.TvRepository);
  @override
  _i5.Future<_i2.Either<_i6.Failure, String>> execute(_i10.TvDetail? tv) =>
      (super.noSuchMethod(Invocation.method(#execute, [tv]),
              returnValue: Future<_i2.Either<_i6.Failure, String>>.value(
                  _FakeEither_0<_i6.Failure, String>()))
          as _i5.Future<_i2.Either<_i6.Failure, String>>);
}
