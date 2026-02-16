import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModernGameIcons {
  // Modern taş ikonu (geçici)
  static Widget get rockIcon => Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF8D6E63),
          const Color(0xFF6D4C41),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8D6E63).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: const Icon(
      Icons.terrain,
      color: Colors.white,
      size: 35,
    ),
  );

  // Modern kağıt ikonu (geçici)
  static Widget get paperIcon => Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF64B5F6),
          const Color(0xFF42A5F5),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF64B5F6).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: const Icon(
      Icons.description,
      color: Colors.white,
      size: 35,
    ),
  );

  // Modern makas ikonu (geçici)
  static Widget get scissorsIcon => Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF81C784),
          const Color(0xFF66BB6A),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF81C784).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: const Icon(
      Icons.content_cut,
      color: Colors.white,
      size: 35,
    ),
  );
}
