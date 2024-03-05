<img src="assets/images/profile_pic.png" align="right" />

# Стикеры
Учебный Flutter проект.
В ветке animation реализована верстка нескольких экранов. 
В файле pubspec.yaml подключена библиотека 
```yaml
dependencies:
  flutter:
    sdk: flutter
  animations: ^2.0.11
```
Верстку предлагается использовать как тренажер для освоения и отработки нюансов работы с библиотекой animations.
<br/>
<br/>
<br/>


> План:
> 
> 
> - **OpenContainer**. Использование виджета OpenContainer для детального просмотра стикера при клике на карточку.
> - **OpenContainer**. Использование виджета OpenContainer для элемента списка избранных стикеров.
> - **OpenContainer**. .



### :bulb:  :star:  :classical_building:  :mag_right:  :test_tube:  :toolbox: :book:

<br/>

## :construction: Версии Dart && Flutter

```cmd
doctor --verbose
[✓] Flutter (Channel stable, 3.16.4, on macOS 14.0 23A344 darwin-arm64, locale ru-RU)
    • Flutter version 3.16.4 
    ...
    • Dart version 3.2.3
```

Описание основных веток:

## Ветка :star: animation

- [Учебник](https://yulmosk.github.io/SunStickers/tutorials/Stickers.pdf) - В учебнике пошагово рассмотренно создание верстки проекта (Главы 1-7). В главе 8 учебника бизнес логика приложения реализована без дополнительных библиотек.

<details>
    <summary> :warning: Правка для Material 3 </summary>

### Правка для Material 3

Верстка в учебнике реализована в условиях Material 2. В ветке main сделана правка, отменяющая Мaterial 3 
Листинг файла lib >> ui_kit >> app_theme.dart

```dart
class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    //...
  );

  static ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  brightness: Brightness.dark,
    //...
  );
}
```
Эта правка - минимальное изменение в коде, позволяющее пользоваться учебником.
</details>

В файле pubspec.yaml подключена библиотека
```yaml
dependencies:
  flutter:
    sdk: flutter
  animations: ^2.0.11
```
Этот проект предлагается использовать как тренажер для освоения и отработки нюансов работы с библиотекой animations.

## Ветка :star: detail_page

Использование виджета OpenContainer библиотеки animations для детального просмотра стикера при клике на карточку.

Листинг файла lib >> ui >> widgets >> sticker_list_view.dart

```dart
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 200,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 20),
          itemBuilder: (_, index) {
            Sticker sticker = isReversed ? stickers.reversed.toList()[index] : stickers[index];
            return GestureDetector(
              onTap: () {
                print('Клик на карточку');
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StickerDetail()));
              },
              child: Container(
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
              ),
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

```
Выделим верстку карточки в отдельный виджет.

```dart
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
```
Тогда StickerListView примет вид

```dart
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
            return GestureDetector(
              onTap: () {
                print('Клик на карточку');
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StickerDetail()));
              },
              child: _StickerCard(sticker: sticker,),
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
```

Код клика на карточку главного экрана и открытие экрана детального просмотра (StickerDetail()):

```dart
onTap: () {
  print('Клик на карточку');
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StickerDetail()));
},
```

Откроем детальный просмотр с использованием виджета OpenContainer

```dart
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
```