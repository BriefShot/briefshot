import 'package:flutter/material.dart';

class TagPill extends StatefulWidget {
  const TagPill({super.key, required this.tag});

  final String tag;

  @override
  State<TagPill> createState() => _TagPillState();
}

class _TagPillState extends State<TagPill> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      onLongPress: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(
            10.0,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Text(
        widget.tag.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
