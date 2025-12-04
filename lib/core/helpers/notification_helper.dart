import 'package:flutter/material.dart';

class NotificationHelper {
  static OverlayEntry? _currentOverlay;

  static void generarNotificacion(
    BuildContext context,
    String mensaje, {
    bool exito = true,
    Duration duration = const Duration(seconds: 3),
  }) {

    _currentOverlay?.remove(); // Quita la anterior
    
    final overlay = Overlay.of(context);
    final color = exito ? Colors.green.shade700 : Colors.red.shade700;
    final icon = exito ? Icons.check_circle_outline : Icons.error_outline;

    final top = MediaQuery.of(context).viewPadding.top + 16;

    _currentOverlay = OverlayEntry(
      builder: (_) => Positioned(
        top: top,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    mensaje,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(_currentOverlay!);

    Future.delayed(duration, () {
      _currentOverlay?.remove();
      _currentOverlay = null;
    });
  }
}
