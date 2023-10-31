import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final Function(String) funcao;
  final bool isDisabled;
  final bool isCompleted;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.funcao,
    this.isDisabled = false,
    this.isCompleted = false,
  }) : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;
  bool _hover = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey[400],
      end: Colors.grey[800],
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          _hover = true;
        });
        widget.isDisabled == false ? _animationController.forward() : null;
      },
      onExit: (e) {
        setState(() {
          _hover = false;
        });
        _animationController.reverse();
      },
      cursor: _hover == true && widget.isDisabled == false
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
          onTap: widget.isDisabled == false
              ? () => widget.funcao(widget.key.toString())
              : () => {},
          child: widget.isDisabled == false
              ? AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Icon(
                          widget.icon,
                          color: _colorAnimation.value,
                        ));
                  },
                )
              : Icon(
                  widget.icon,
                  color: _colorAnimation.value,
                )),
    );
  }
}
