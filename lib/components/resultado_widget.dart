import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final Function() onRestart;

  const ResultadoWidget({
    Key? key,
    this.venceu,
    required this.onRestart,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(120);

  _getColor() {
    if (venceu == null) {
      return Colors.amber;
    } else if (venceu!) {
      return Colors.green;
    } else {
      return Colors.red[300];
    }
  }

  _getIcon() {
    if (venceu == null) {
      return Icons.sentiment_satisfied;
    } else if (venceu!) {
      return Icons.sentiment_very_satisfied;
    } else {
      Colors.red[300];
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              onPressed: onRestart,
              padding: const EdgeInsets.all(0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
