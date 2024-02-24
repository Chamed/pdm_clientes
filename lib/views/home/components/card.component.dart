import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final IconData iconData;
  final String label;
  final String? description;
  final Function? onTap;

  const CardComponent({
    required this.iconData,
    required this.label,
    this.description,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      onTap: () => {if (onTap != null) onTap!()},
      child: Ink(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 45.0,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
