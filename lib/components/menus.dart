import 'package:flutter/material.dart';
import 'package:mboistats/datas/icons.dart';
import 'package:mboistats/theme.dart';

class Menus extends StatelessWidget {
  const Menus({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 15, top: 32),
      child: SizedBox(
        height: 200,
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          children: [
            ...mboistatsMenuIcon.map((icon) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, icon.route);
                },
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: icon.icon == 'ipm'
                            ? Color.fromARGB(255, 254, 255, 255)
                            : icon.color,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset(
                        'assets/icons/${icon.icon}.png',
                        width: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      icon.title,
                      style: regular12_5.copyWith(color: dark2),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
