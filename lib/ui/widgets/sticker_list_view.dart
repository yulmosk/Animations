import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../data/_data.dart';
import '../../ui_kit/_ui_kit.dart';
import '../_ui.dart';

class StickerListView extends StatelessWidget {
  const StickerListView({super.key, required this.stickers, this.isReversed = false});

  final List<Sticker> stickers;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (_, index) {
            Sticker sticker = isReversed ? stickers.reversed.toList()[index] : stickers[index];
            // return GestureDetector(
            //   onTap: () {
            //     print('Клик на карточку');
            //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StickerDetail()));
            //   },
            //   child: _StickerCard(sticker: sticker,),
            // );
            return OpenContainer<bool>(
              transitionType: ContainerTransitionType.fadeThrough,
              openBuilder: (BuildContext _, VoidCallback openContainer) {
                return const StickerDetail();
              },
              onClosed: (_){},
              tappable: false,
              closedShape: const RoundedRectangleBorder(),
              closedElevation: 0.0,
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return GestureDetector(
                  onTap: openContainer,
                  child: _StickerCard(sticker: sticker,),
                );
              },
              openColor: Colors.transparent,
              closedColor: Colors.transparent,
            );
          },
          separatorBuilder: (_, __) {
            return Container(
              width: 50,
            );
          },
          itemCount: 20),
    );
  }
}

class _StickerCard extends StatelessWidget {
  const _StickerCard({required this.sticker});
  final Sticker sticker;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: isDark ? AppColor.dark : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(sticker.image, scale: 6),
            Text(
              "\$${sticker.price}",
              style: AppTextStyle.h3Style.copyWith(color: AppColor.accent),
            ),
            Text(
              sticker.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}
