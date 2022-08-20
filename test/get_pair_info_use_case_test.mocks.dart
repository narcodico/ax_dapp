// Mocks generated by Mockito 5.3.0 from annotations
// in ax_dapp/test/get_pair_info_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:ax_dapp/repositories/subgraph/sub_graph_repo.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shared/shared.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [SubGraphRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockSubGraphRepo extends _i1.Mock implements _i3.SubGraphRepo {
  MockSubGraphRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>
      queryPairDataForTokenAddress(String? token0, String? token1) => (super.noSuchMethod(
          Invocation.method(#queryPairDataForTokenAddress, [token0, token1]),
          returnValue:
              _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>.value(
                  _FakeEither_0<Map<String, dynamic>?, _i2.OperationException>(
                      this, Invocation.method(#queryPairDataForTokenAddress, [token0, token1])))) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>);
  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>
      queryAllPairs() => (super.noSuchMethod(
          Invocation.method(#queryAllPairs, []),
          returnValue:
              _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>.value(
                  _FakeEither_0<Map<String, dynamic>?, _i2.OperationException>(
                      this, Invocation.method(#queryAllPairs, [])))) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>);
  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>
      querySpecificPairs(String? token) => (super.noSuchMethod(
          Invocation.method(#querySpecificPairs, [token]),
          returnValue:
              _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>.value(
                  _FakeEither_0<Map<String, dynamic>?, _i2.OperationException>(
                      this, Invocation.method(#querySpecificPairs, [token])))) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>);
  @override
  _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>
      queryAllPairsForWalletId(String? walletId) => (super.noSuchMethod(
          Invocation.method(#queryAllPairsForWalletId, [walletId]),
          returnValue: _i4.Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>.value(
              _FakeEither_0<Map<String, dynamic>?, _i2.OperationException>(this,
                  Invocation.method(#queryAllPairsForWalletId, [walletId])))) as _i4
          .Future<_i2.Either<Map<String, dynamic>?, _i2.OperationException>>);
}
