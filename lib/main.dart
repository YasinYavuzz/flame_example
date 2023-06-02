
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame{
  SpriteComponent girl = SpriteComponent();
   SpriteComponent boy = SpriteComponent();
   SpriteComponent background = SpriteComponent();
   final double characterSize = 200.0;
   bool turnAway = false;
   TextPaint dialogText = TextPaint(style: const TextStyle(fontSize: 36));
   int dialogLevel = 0;
  @override
  Future<void> onLoad() async{
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    const textBoxHeight = 50;
    // print('Oyun assetleri burada yüklenecektir');
    // girl.sprite = await loadSprite('girl.png');
    // girl.size  = Vector2(10, 10);
    // add(girl);
    add(background..sprite = await loadSprite('background.png')..size = Vector2(size[0], size[1] - textBoxHeight));

    girl
      ..sprite = await loadSprite('girl.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..anchor =  Anchor.topCenter;
    add(girl);

     boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(characterSize, characterSize)
      ..x = screenWidth - characterSize
      ..y = screenHeight - characterSize - textBoxHeight
      ..anchor = Anchor.topCenter
      ..flipHorizontally();
    add(boy);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 2 - 100) {
      girl.x += 30 * dt;
      if (girl.x > 50 && dialogLevel == 0) {
        dialogLevel = 1;
      }

      if (girl.x > 150 && dialogLevel == 1) {
        dialogLevel = 2;
      }
    } else if(turnAway == false){
      boy.flipHorizontally();
      turnAway = true;
      if (dialogLevel == 2) {
        dialogLevel = 3; 
      }
    }

    if (boy.x > size[0] / 2 - 50) {
      boy.x -= 30 * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 1:
        dialogText.render(canvas, 'Hello', Vector2(10, size[1] - 50));
        break;
      case 2:
        dialogText.render(canvas, 'Merhaba', Vector2(10, size[1] - 50));
        break;
      case 3:
        dialogText.render(canvas, 'How are you?', Vector2(10, size[1] - 50));
        break;
    }
    
  }
}

