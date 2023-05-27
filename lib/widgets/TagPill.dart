import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/tagPills/tag_pills_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagPill extends StatefulWidget {
  const TagPill({super.key, required this.tag});

  final String tag;

  @override
  State<TagPill> createState() => _TagPillState();
}

class _TagPillState extends State<TagPill> {
  @override
  Widget build(BuildContext context) {
    if (BlocProvider.of<TagPillsBloc>(context).state is TagPillsDeleteMode ||
        BlocProvider.of<ProfileBloc>(context).state is ProfileEditionAsked) {
      return Stack(
        children: [
          TextButton(
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
          ),
          Positioned(
            top: -0.0,
            right: -0.0,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<TagPillsBloc>(context).add(
                      TagPillsDeleteAsked(tag: widget.tag),
                    );
                  },
                  child: Text(
                    String.fromCharCode(Icons.clear.codePoint),
                    style: TextStyle(
                      inherit: false,
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      fontFamily: Icons.clear.fontFamily,
                    ),
                  ),
                )),
          ),
        ],
      );
    }
    return TextButton(
      onPressed: () {},
      onLongPress: () {
        BlocProvider.of<TagPillsBloc>(context).add(TagPillsLongPressed());
      },
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
