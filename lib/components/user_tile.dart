import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.text,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            //icon
            CircleAvatar(
              radius: 20,
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: 20),
            Text(text,style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
          ],
        ),
      ),
    );
  }
}
