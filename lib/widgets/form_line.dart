import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FormLine extends StatelessWidget {
  const FormLine({
    super.key,
    required this.spacer,
    required this.children,
    this.flex = 1,
  });

  final bool spacer;
  final List<Widget> children;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...children,
        if (children.length > 2 && spacer) const Gap(20),
        if (spacer) Spacer(flex: flex),
      ],
    );
  }
}
