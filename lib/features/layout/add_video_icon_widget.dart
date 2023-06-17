import 'package:flutter/material.dart';

import '../../lib_exports.dart';

class AddVideoIconWidget extends StatelessWidget {
  const AddVideoIconWidget({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 45,
        height: 30,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 38,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 38,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Center(
              child: Container(
                height: double.infinity,
                width: 38,
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );
}
