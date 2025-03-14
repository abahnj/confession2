import 'package:confession/core/base/domain_model.dart';
import 'package:confession/core/base/view_data.dart';

class MockDomainModel extends DomainModel {
  const MockDomainModel({
    required this.id,
    required this.name,
  });

  factory MockDomainModel.fromJson(Map<String, dynamic> json) {
    return MockDomainModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
  final String id;
  final String name;

  @override
  MockDomainModel copyWith({
    String? id,
    String? name,
  }) {
    return MockDomainModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}

class MockViewData extends ViewData {
  const MockViewData({
    required this.id,
    required this.name,
  });
  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
