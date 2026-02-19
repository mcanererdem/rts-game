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
          const Color(0xFF7C3AED),
          const Color(0xFFA78BFA),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF7C3AED).withOpacity(0.35),
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
          const Color(0xFF0891B2),
          const Color(0xFF22D3EE),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF0891B2).withOpacity(0.35),
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
          const Color(0xFFBE185D),
          const Color(0xFFF472B6),
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFBE185D).withOpacity(0.35),
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
