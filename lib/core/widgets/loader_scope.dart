import 'package:flutter/material.dart';

abstract class LoaderScopeBase<T extends StatefulWidget> extends State<T> {
  void changeLoaderVisibility(bool value) {}
}

class LoaderScope extends StatefulWidget {
  const LoaderScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static LoaderScopeBase of(BuildContext context) {
    return context
        .findAncestorStateOfType<LoaderScopeBase<LoaderScope>>()!;
  }

  @override
  State<LoaderScope> createState() {
    return _LoaderScopeState();
  }
}

class _LoaderScopeState extends State<LoaderScope>
    implements LoaderScopeBase<LoaderScope> {
  final _loadingNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _loadingNotifier.dispose();
    super.dispose();
  }

  @override
  void changeLoaderVisibility(bool value) {
    _loadingNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: widget.child),
        ValueListenableBuilder(
          valueListenable: _loadingNotifier,
          builder: (_, value, __) {
            if (!value) {
              return const SizedBox.shrink();
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.7),
              child: const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
