import 'package:flutter/cupertino.dart';
import 'package:shoes_shop_ui/themes/app_colors.dart';

class GetStartedButtonWidget extends StatefulWidget {
  const GetStartedButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.color = AppColors.black,
    this.border,
    this.icon,
    this.padding = 18,
    required this.width,
    this.tapOpacity = 0.4,
  }) : assert(tapOpacity == null || (tapOpacity >= 0.0 && tapOpacity <= 1.0));

  final Text title;
  final void Function()? onTap;
  final double? tapOpacity;
  final Color color;
  final String? icon;
  final Border? border;
  final double width;
  final double padding;
  bool get enabled => onTap != null;

  @override
  State<GetStartedButtonWidget> createState() => _GetStartedButtonWidgetState();
}

class _GetStartedButtonWidgetState extends State<GetStartedButtonWidget>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(GetStartedButtonWidget old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.tapOpacity ?? 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0,
            duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? _handleTapDown : null,
      onTapUp: enabled ? _handleTapUp : null,
      onTapCancel: enabled ? _handleTapCancel : null,
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            border: widget.border,
          ),
          padding: EdgeInsets.symmetric(
            vertical: widget.padding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(widget.icon!),
                    )
                  : const SizedBox.shrink(),
              widget.title,
            ],
          ),
        ),
      ),
    );
  }
}
