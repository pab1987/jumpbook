import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jumpbook/providers/jump_providers.dart';
import 'package:jumpbook/theme/app_colors.dart';

class JumpDetailActions extends ConsumerWidget {
  final String jumpId;

  const JumpDetailActions({super.key, required this.jumpId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Intentamos obtener el Jump completo desde el provider y lo pasamos como "extra"
              final jumps = ref.read(jumpsStreamProvider).value;

              if (jumps == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jump data not loaded yet')),
                );
                return;
              }

              try {
                final jump = jumps.firstWhere((j) => j.id == jumpId);
                context.push(
                  '/add_jump',
                  extra: jump, // pasamos el Jump completo
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Jump not found')),
                );
              }
            },
            child: const Text('Edit Jump'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => Dialog(
                  backgroundColor: AppColors.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icono
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.redAccent,
                            size: 32,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'Delete Jump',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'This action cannot be undone.\nAre you sure you want to delete this jump?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),

                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white70,
                                  side: const BorderSide(color: Colors.white24),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (confirm != true) return;

              await ref.read(jumpActionsProvider).deleteJump(jumpId);

              if (context.mounted) {
                Navigator.pop(context); // volver a la lista
              }
            },
            child: const Text('Delete Jump'),
          ),
        ),
      ],
    );
  }
}
