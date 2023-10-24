import 'package:flutter/material.dart';
import 'package:mboistat/datas/pictures.dart';
import 'package:mboistat/theme.dart';

class Pictures extends StatelessWidget {
  const Pictures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Pictures
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logobps.jpg',
                height: 50,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Yuk lebih dekat dengan BPS Kota Malang ❤',
                style: bold16.copyWith(color: dark1),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Mau cari data apa???',
                style: regular14.copyWith(color: dark2),
              )
            ],
          ),
        ),

        const SizedBox(
          height: 24,
        ),

        //News
        ...news.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: dark4)),
                child: Column(
                  children: [
                    Image.asset('assets/images/${item.image}'),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: bold16.copyWith(color: dark1),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            item.description,
                            style: regular14.copyWith(color: dark2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
