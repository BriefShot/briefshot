import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FloatingActionButton(
        heroTag: "FilterButton",
        backgroundColor: const Color(0xFFE88954),
        onPressed: () {},
        child: SvgPicture.asset("assets/icons/filter.svg"),
      ),
    );
  }
}
