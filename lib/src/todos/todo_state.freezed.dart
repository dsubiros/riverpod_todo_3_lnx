// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodoState {
  List<Todo> get items => throw _privateConstructorUsedError;
  Todo? get selectedTodo => throw _privateConstructorUsedError;
  dynamic get isLoading => throw _privateConstructorUsedError;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoStateCopyWith<TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res, TodoState>;
  @useResult
  $Res call({List<Todo> items, Todo? selectedTodo, dynamic isLoading});

  $TodoCopyWith<$Res>? get selectedTodo;
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res, $Val extends TodoState>
    implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedTodo = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      selectedTodo: freezed == selectedTodo
          ? _value.selectedTodo
          : selectedTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      isLoading: freezed == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TodoCopyWith<$Res>? get selectedTodo {
    if (_value.selectedTodo == null) {
      return null;
    }

    return $TodoCopyWith<$Res>(_value.selectedTodo!, (value) {
      return _then(_value.copyWith(selectedTodo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodoStateImplCopyWith<$Res>
    implements $TodoStateCopyWith<$Res> {
  factory _$$TodoStateImplCopyWith(
          _$TodoStateImpl value, $Res Function(_$TodoStateImpl) then) =
      __$$TodoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Todo> items, Todo? selectedTodo, dynamic isLoading});

  @override
  $TodoCopyWith<$Res>? get selectedTodo;
}

/// @nodoc
class __$$TodoStateImplCopyWithImpl<$Res>
    extends _$TodoStateCopyWithImpl<$Res, _$TodoStateImpl>
    implements _$$TodoStateImplCopyWith<$Res> {
  __$$TodoStateImplCopyWithImpl(
      _$TodoStateImpl _value, $Res Function(_$TodoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? selectedTodo = freezed,
    Object? isLoading = freezed,
  }) {
    return _then(_$TodoStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      selectedTodo: freezed == selectedTodo
          ? _value.selectedTodo
          : selectedTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      isLoading: freezed == isLoading ? _value.isLoading! : isLoading,
    ));
  }
}

/// @nodoc

class _$TodoStateImpl implements _TodoState {
  const _$TodoStateImpl(
      {final List<Todo> items = const [],
      this.selectedTodo,
      this.isLoading = false})
      : _items = items;

  final List<Todo> _items;
  @override
  @JsonKey()
  List<Todo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final Todo? selectedTodo;
  @override
  @JsonKey()
  final dynamic isLoading;

  @override
  String toString() {
    return 'TodoState(items: $items, selectedTodo: $selectedTodo, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.selectedTodo, selectedTodo) ||
                other.selectedTodo == selectedTodo) &&
            const DeepCollectionEquality().equals(other.isLoading, isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      selectedTodo,
      const DeepCollectionEquality().hash(isLoading));

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoStateImplCopyWith<_$TodoStateImpl> get copyWith =>
      __$$TodoStateImplCopyWithImpl<_$TodoStateImpl>(this, _$identity);
}

abstract class _TodoState implements TodoState {
  const factory _TodoState(
      {final List<Todo> items,
      final Todo? selectedTodo,
      final dynamic isLoading}) = _$TodoStateImpl;

  @override
  List<Todo> get items;
  @override
  Todo? get selectedTodo;
  @override
  dynamic get isLoading;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoStateImplCopyWith<_$TodoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
