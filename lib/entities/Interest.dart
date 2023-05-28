import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Interest extends Equatable {
  final String label;
  late String image;

  Interest({required this.label, required this.image});

  factory Interest.fromMap(Map<String, dynamic> map) {
    return Interest(
      label: map['label'],
      image: map['image'],
    );
  }

  @override
  List<Object?> get props => [label, image];
}
