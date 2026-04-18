import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';

class CivigoGameWithQuiz extends FlameGame {
  late Player player;
  late ParallaxComponent parallax;

  bool quizActive = false;

  double distanceTravelled = 0;
  double nextQuizAt = 600;
  final double quizInterval = 600;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    parallax = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/sky.png'),
        ParallaxImageData('parallax/cloud1.png'),
        ParallaxImageData('parallax/cloud2.png'),
        ParallaxImageData('parallax/far_city1.png'),
        ParallaxImageData('parallax/far_city2.png'),
        ParallaxImageData('parallax/far_city3.png'),
        ParallaxImageData('parallax/ground.png'),
      ],
      baseVelocity: Vector2(200, 0),
      velocityMultiplierDelta: Vector2(1.2, 0),
    );

    add(parallax);

    player = Player();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (quizActive) return;

    distanceTravelled += 200 * dt;

    if (distanceTravelled >= nextQuizAt) {
      showQuiz();
      nextQuizAt += quizInterval;
    }
  }

  void showQuiz() {
    pauseEngine();
    overlays.add('QuizOverlay');
    quizActive = true;
  }

  void removeQuiz() {
    overlays.remove('QuizOverlay');
    resumeEngine();
    quizActive = false;
  }
}

class Player extends SpriteAnimationComponent
    with HasGameRef<CivigoGameWithQuiz> {
  final double gravity = 800;
  final double jumpSpeed = 400;

  Vector2 velocity = Vector2.zero();
  bool isOnGround = true;

  Player() : super(size: Vector2(100, 100), anchor: Anchor.bottomLeft);

  @override
  Future<void> onLoad() async {
    final image = await gameRef.images.load('player/player.png');

    animation = SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 12,
        textureSize: Vector2(234, 256),
        stepTime: 0.1,
      ),
    );

    position = Vector2(100, gameRef.size.y - size.y);
  }

  void jump() {
    if (isOnGround) {
      velocity.y = -jumpSpeed;
      isOnGround = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.y += gravity * dt;
    position.y += velocity.y * dt;

    final groundY = gameRef.size.y - size.y;

    if (position.y >= groundY) {
      position.y = groundY;
      velocity.y = 0;
      isOnGround = true;
    }
  }
}
