import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/historical_eras.dart';
import '../data/providers/character_provider.dart';
import '../data/models/character.dart';

/// Character gallery screen showing all companion characters
class CharacterGalleryScreen extends StatelessWidget {
  const CharacterGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characterProvider = context.watch<CharacterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.characters),
      ),
      body: characterProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: characterProvider.characters.length,
              itemBuilder: (context, index) {
                final character = characterProvider.characters[index];
                return _CharacterCard(character: character);
              },
            ),
    );
  }
}

/// Character card widget
class _CharacterCard extends StatelessWidget {
  final Character character;

  const _CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = character.isUnlocked;
    final isActive =
        context.watch<CharacterProvider>().activeCharacter?.id == character.id;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isUnlocked
            ? () => _showCharacterDetail(context, character)
            : () => _showLockedMessage(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isUnlocked
                  ? [
                      character.accentColor,
                      character.accentColor.withOpacity(0.7),
                    ]
                  : [Colors.grey[300]!, Colors.grey[400]!],
            ),
            borderRadius: BorderRadius.circular(16),
            border: isActive ? Border.all(color: Colors.white, width: 3) : null,
            boxShadow: [
              BoxShadow(
                color: isUnlocked
                    ? character.accentColor.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Character avatar placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: isUnlocked
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: character.accentColor,
                      )
                    : Icon(
                        Icons.lock,
                        size: 50,
                        color: Colors.grey[600],
                      ),
              ),
              const SizedBox(height: 12),

              // Character name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? Colors.white : Colors.grey[700],
                  ),
                ),
              ),
              const SizedBox(height: 4),

              // Era name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  character.era.displayName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnlocked ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              ),

              if (isActive) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Ativo',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showCharacterDetail(BuildContext context, Character character) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _CharacterDetailSheet(character: character),
    );
  }

  void _showLockedMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.locked),
        content: const Text(
          'Completa mais capítulos para desbloquear esta personagem!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
        ],
      ),
    );
  }
}

/// Character detail sheet
class _CharacterDetailSheet extends StatelessWidget {
  final Character character;

  const _CharacterDetailSheet({required this.character});

  @override
  Widget build(BuildContext context) {
    final characterProvider = context.read<CharacterProvider>();
    final isActive = characterProvider.activeCharacter?.id == character.id;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: character.accentColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            character.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Era
          Text(
            character.era.displayName,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            character.description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),

          // Personality traits
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: character.personalityTraits.map((trait) {
              return Chip(
                label: Text(trait),
                backgroundColor: character.accentColor.withOpacity(0.1),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Set active button
          if (!isActive)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  characterProvider.setActiveCharacter(character);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            '${character.name} é agora a tua personagem ativa!')),
                  );
                },
                child: const Text('Escolher como Personagem Ativa'),
              ),
            )
          else
            const Text(
              'Esta é a tua personagem ativa',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
