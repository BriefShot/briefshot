import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class NewTagPill extends StatelessWidget {
  const NewTagPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipOval(
        child: Container(
          width: 33,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFFE88954),
              width: 2.0,
            ),
          ),
          child: Material(
            shape: CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFE88954),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
