import 'package:aventura_historia/core/constants/app_strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppStrings', () {
    test('all strings are non-empty', () {
      expect(AppStrings.appTitle.isNotEmpty, isTrue);
      expect(AppStrings.appSubtitle.isNotEmpty, isTrue);
      expect(AppStrings.home.isNotEmpty, isTrue);
      expect(AppStrings.chapters.isNotEmpty, isTrue);
      expect(AppStrings.characters.isNotEmpty, isTrue);
      expect(AppStrings.progress.isNotEmpty, isTrue);
      expect(AppStrings.settings.isNotEmpty, isTrue);
      expect(AppStrings.start.isNotEmpty, isTrue);
      expect(AppStrings.next.isNotEmpty, isTrue);
      expect(AppStrings.previous.isNotEmpty, isTrue);
      expect(AppStrings.confirm.isNotEmpty, isTrue);
      expect(AppStrings.cancel.isNotEmpty, isTrue);
      expect(AppStrings.back.isNotEmpty, isTrue);
      expect(AppStrings.retry.isNotEmpty, isTrue);
      expect(AppStrings.continue_.isNotEmpty, isTrue);
      expect(AppStrings.question.isNotEmpty, isTrue);
      expect(AppStrings.correct.isNotEmpty, isTrue);
      expect(AppStrings.incorrect.isNotEmpty, isTrue);
      expect(AppStrings.score.isNotEmpty, isTrue);
      expect(AppStrings.questionsRemaining.isNotEmpty, isTrue);
      expect(AppStrings.quizComplete.isNotEmpty, isTrue);
      expect(AppStrings.chapterComplete.isNotEmpty, isTrue);
      expect(AppStrings.unlockCharacter.isNotEmpty, isTrue);
      expect(AppStrings.easy.isNotEmpty, isTrue);
      expect(AppStrings.medium.isNotEmpty, isTrue);
      expect(AppStrings.hard.isNotEmpty, isTrue);
      expect(AppStrings.selectChapter.isNotEmpty, isTrue);
      expect(AppStrings.locked.isNotEmpty, isTrue);
      expect(AppStrings.unlocked.isNotEmpty, isTrue);
      expect(AppStrings.complete.isNotEmpty, isTrue);
      expect(AppStrings.companion.isNotEmpty, isTrue);
      expect(AppStrings.characterProfile.isNotEmpty, isTrue);
      expect(AppStrings.confirmExit.isNotEmpty, isTrue);
      expect(AppStrings.progressSaved.isNotEmpty, isTrue);
    });

    test('app title is correct', () {
      expect(AppStrings.appTitle, 'Aventura da História');
    });

    test('app subtitle is correct', () {
      expect(AppStrings.appSubtitle, 'História de Portugal');
    });

    test('navigation strings are in Portuguese', () {
      expect(AppStrings.home, 'Início');
      expect(AppStrings.chapters, 'Capítulos');
      expect(AppStrings.characters, 'Personagens');
      expect(AppStrings.progress, 'Progresso');
      expect(AppStrings.settings, 'Definições');
    });

    test('action strings are in Portuguese', () {
      expect(AppStrings.start, 'Começar');
      expect(AppStrings.next, 'Seguinte');
      expect(AppStrings.previous, 'Anterior');
      expect(AppStrings.confirm, 'Confirmar');
      expect(AppStrings.cancel, 'Cancelar');
      expect(AppStrings.back, 'Voltar');
      expect(AppStrings.retry, 'Tentar Novamente');
      expect(AppStrings.continue_, 'Continuar');
    });

    test('quiz strings are in Portuguese', () {
      expect(AppStrings.question, 'Pergunta');
      expect(AppStrings.correct, 'Correto!');
      expect(AppStrings.incorrect, 'Incorreto');
      expect(AppStrings.score, 'Pontuação');
      expect(AppStrings.quizComplete, 'Quiz Concluído!');
      expect(AppStrings.chapterComplete, 'Capítulo Concluído!');
      expect(AppStrings.unlockCharacter, 'Personagem Desbloqueado!');
    });

    test('difficulty strings are in Portuguese', () {
      expect(AppStrings.easy, 'Fácil');
      expect(AppStrings.medium, 'Médio');
      expect(AppStrings.hard, 'Difícil');
    });
  });
}
