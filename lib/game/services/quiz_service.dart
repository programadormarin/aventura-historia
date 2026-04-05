import '../../core/constants/historical_eras.dart';
import '../../data/models/quiz_question.dart';

/// Service for managing quiz questions
class QuizService {
  /// Get questions for a specific era
  /// In a real app, this would load from database or JSON files
  Future<List<QuizQuestion>> getQuestionsForEra(HistoricalEra era) async {
    // Simulate async loading
    await Future.delayed(const Duration(milliseconds: 500));

    // Sample questions for each era
    return _getSampleQuestions(era);
  }

  List<QuizQuestion> _getSampleQuestions(HistoricalEra era) {
    switch (era) {
      case HistoricalEra.preRoman:
        return [
          const QuizQuestion(
            id: 'pr_1',
            question:
                'Quais eram os principais povos que habitavam a Península Ibérica antes da chegada dos Romanos?',
            options: [
              'Lusitanos, Celtas e Iberos',
              'Vikings e Normandos',
              'Gregos e Fenícios',
              'Francos e Visigodos'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Os Lusitanos, Celtas e Iberos eram os principais povos pré-romanos na Península Ibérica.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            question: 'O que eram os "castros"?',
            options: [
              'Aldeias fortificadas no topo de colinas',
              'Templos religiosos',
              'Mercados comerciais',
              'Navios de guerra'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Os castros eram aldeias fortificadas construídas no topo de colinas para defesa.',
            difficulty: DifficultyLevel.easy,
            id: 'pr_2',
          ),
          const QuizQuestion(
            id: 'pr_3',
            question:
                'Qual era a principal atividade económica dos povos pré-romanos?',
            options: [
              'Agricultura e pastorícia',
              'Comércio marítimo',
              'Mineração de ouro',
              'Artesanato de cerâmica',
              'Pesca em alto mar'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A agricultura e pastorícia eram as principais atividades económicas.',
            difficulty: DifficultyLevel.hard,
          ),
          const QuizQuestion(
            id: 'pr_4',
            question:
                'Que animal era frequentemente esculpido em pedra pelos povos do Norte (Verracos)?',
            options: ['Porcos e Touros', 'Lobos e Ursos', 'Cavalos e Águias', 'Ovelhas e Cabras'],
            correctAnswerIndex: 0,
            explanation:
                'Os Verracos são esculturas de pedra representando porcos ou touros.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'pr_5',
            question: 'Qual era o metal mais cobiçado pelos Fenícios na Península?',
            options: ['Estanho', 'Plástico', 'Papel'],
            correctAnswerIndex: 0,
            explanation: 'O estanho era essencial para fabricar bronze.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'pr_6',
            question:
                'Qual é a designação da escrita usada no Sul de Portugal antes dos Romanos?',
            options: [
              'Escrita do Sudoeste',
              'Hieróglifos',
              'Latim',
              'Grego Arcaico',
              'Fenício'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A escrita do sudoeste é uma das mais antigas gravações epigráficas em Portugal.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.roman:
        return [
          const QuizQuestion(
            id: 'rom_1',
            question: 'Em que ano os Romanos invadiram a Península Ibérica?',
            options: ['218 a.C.', '476 d.C.', '711 d.C.', '1385 d.C.'],
            correctAnswerIndex: 0,
            explanation:
                'Os Romanos invadiram a Península Ibérica em 218 a.C. durante a Segunda Guerra Púnica.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'rom_2',
            question: 'Qual foi o líder Lusitano que combateu os Romanos?',
            options: ['Viriato', 'César', 'Augusto', 'Trajano'],
            correctAnswerIndex: 0,
            explanation:
                'Viriato foi o famoso líder Lusitano que resistiu aos Romanos.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'rom_3',
            question:
                'Qual era o nome de uma das principais estradas construídas pelos Romanos em Portugal?',
            options: [
              'Via Augusta',
              'Autoestrada do Norte',
              'Estrada da Luz',
              'Caminho de Santiago'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A Via Augusta ligava várias cidades importantes da Península Ibérica.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'rom_4',
            question: 'Que cidade atual corresponde à romana "Olissipo"?',
            options: ['Lisboa', 'Beja', 'Braga'],
            correctAnswerIndex: 0,
            explanation: 'Olissipo era a designação romana de Lisboa.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'rom_5',
            question: 'Que monumento romano ainda se pode visitar em Évora?',
            options: [
              'Templo Romano',
              'Muralha da China',
              'Coliseu',
              'Torre de Belém',
              'Aqueduto'
            ],
            correctAnswerIndex: 0,
            explanation:
                'O Templo de Évora é um dos mais bem preservados monumentos romanos em Portugal.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.suebiVisigoth:
        return [
          const QuizQuestion(
            id: 'sv_1',
            question:
                'Qual destes povos germânicos fundou um reino no Norte de Portugal e Galiza?',
            options: ['Suevos', 'Vikings', 'Romanos', 'Mouros'],
            correctAnswerIndex: 0,
            explanation:
                'O Reino Suevo foi um dos primeiros reinos germânicos na Península.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'sv_2',
            question: 'Qual era a capital do Reino Visigodo na Península?',
            options: ['Toledo', 'Porto', 'Lisboa'],
            correctAnswerIndex: 0,
            explanation: 'Toledo foi a principal capital dos Visigodos.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'sv_3',
            question:
                'Quem foi o último rei Visigodo a lutar contra os Muçulmanos?',
            options: ['Rodrigo', 'Viriato', 'D. Afonso', 'Suevus', 'Egica'],
            correctAnswerIndex: 0,
            explanation:
                'O Rei Rodrigo foi derrotado, marcando o fim do Reino Visigodo.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.islamic:
        return [
          const QuizQuestion(
            id: 'isl_1',
            question: 'Em que ano os Muçulmanos chegaram à Península Ibérica?',
            options: ['711', '1139', '1415', '1640'],
            correctAnswerIndex: 0,
            explanation:
                'Os Muçulmanos chegaram em 711, iniciando quase 4 séculos de presença na Península.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'isl_2',
            question: 'Como se chamava a região sob domínio muçulmano?',
            options: ['Al-Andalus', 'França', 'Britânia', 'Gália'],
            correctAnswerIndex: 0,
            explanation:
                'Al-Andalus foi o nome dado pelos muçulmanos à Península Ibérica.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'isl_3',
            question: 'Que fruta foi introduzida pelos Muçulmanos em Portugal?',
            options: ['Laranja', 'Maçã', 'Uva'],
            correctAnswerIndex: 0,
            explanation:
                'Os muçulmanos introduziram citrinos, incluindo a laranja amarga.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'isl_4',
            question: 'O que é um "Açoteia", comum na arquitetura do Algarve?',
            options: [
              'Terraço plano',
              'Tipo de comida',
              'Vestimenta',
              'Ponta da lança',
              'Moeda'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A açoteia é um terraço plano típico das casas algarvias de influência mourisca.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.countyPortugal:
        return [
          const QuizQuestion(
            id: 'cp_1',
            question: 'Quem foi o pai do primeiro Rei de Portugal?',
            options: ['Conde D. Henrique', 'D. Sanches', 'D. Dinis', 'Viriato'],
            correctAnswerIndex: 0,
            explanation:
                'O Conde D. Henrique de Borgonha foi o pai de D. Afonso Henriques.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'cp_2',
            question: 'Como se chamava a mãe de D. Afonso Henriques?',
            options: ['D. Teresa', 'D. Dulce', 'D. Maria'],
            correctAnswerIndex: 0,
            explanation: 'D. Teresa governou o Condado antes do seu filho.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'cp_3',
            question:
                'Em que batalha D. Afonso Henriques derrotou os apoiantes da sua mãe?',
            options: [
              'São Mamede',
              'Aljubarrota',
              'Ourique',
              'Das Navas',
              'Do Salado'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A Batalha de São Mamede (1128) permitiu a D. Afonso Henriques assumir o governo.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.firstDynasty:
        return [
          const QuizQuestion(
            id: 'fd_1',
            question: 'Quem foi o primeiro Rei de Portugal?',
            options: [
              'D. Afonso Henriques',
              'D. Dinis',
              'D. João I',
              'D. Sebastião'
            ],
            correctAnswerIndex: 0,
            explanation:
                'D. Afonso Henriques foi o primeiro Rei de Portugal, coroado em 1139.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'fd_2',
            question: 'Em que ano ocorreu a Batalha de Ourique?',
            options: ['1139', '1147', '1385', '1415', '1498'],
            correctAnswerIndex: 0,
            explanation:
                'A Batalha de Ourique ocorreu em 1139, onde D. Afonso Henriques foi proclamado Rei.',
            difficulty: DifficultyLevel.hard,
          ),
          const QuizQuestion(
            id: 'fd_3',
            question: 'Qual foi o rei que mandou plantar o Pinhal de Leiria?',
            options: ['D. Dinis', 'D. Duarte', 'D. Pedro I', 'D. Fernando'],
            correctAnswerIndex: 0,
            explanation:
                'D. Dinis mandou plantar o pinhal para fornecer madeira para a construção naval.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'fd_4',
            question: 'Como ficou conhecido o Rei D. Dinis?',
            options: ['O Lavrador', 'O Africano', 'O Bravo'],
            correctAnswerIndex: 0,
            explanation:
                'D. Dinis ficou conhecido como "O Lavrador" pelas suas reformas agrícolas.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'fd_5',
            question:
                'Qual o tratado de 1297 que estabeleceu as fronteiras de Portugal?',
            options: [
              'Alcanizes',
              'Tordesilhas',
              'Windsor',
              'Utrecht',
              'Zamora'
            ],
            correctAnswerIndex: 0,
            explanation:
                'O Tratado de Alcanizes definiu as fronteiras terrestres de Portugal.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.discoveries:
        return [
          const QuizQuestion(
            id: 'disc_1',
            question: 'Quem descobriu o caminho marítimo para a Índia?',
            options: [
              'Vasco da Gama',
              'Cristóvão Colombo',
              'Fernão de Magalhães',
              'Bartolomeu Dias'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Vasco da Gama chegou à Índia por via marítima em 1498.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'disc_2',
            question: 'Qual foi a primeira conquista ultramarina portuguesa?',
            options: [
              'Ceuta (1415)',
              'Brasil (1500)',
              'Goa (1510)',
              'Madeira (1419)'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Ceuta foi a primeira conquista ultramarina em 1415, marcando o início da expansão.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'disc_3',
            question:
                'Quem dobrou o Cabo das Tormentas (Boa Esperança) em 1488?',
            options: [
              'Bartolomeu Dias',
              'Diogo Cão',
              'Gil Eanes',
              'Pedro Álvares Cabral'
            ],
            correctAnswerIndex: 0,
            explanation:
                'Bartolomeu Dias provou que era possível contornar a África para chegar ao Índico.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'disc_4',
            question: 'Em que ano Pedro Álvares Cabral chegou ao Brasil?',
            options: ['1500', '1415', '1498'],
            correctAnswerIndex: 0,
            explanation: 'Cabral chegou ao Brasil numa expedição em 1500.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'disc_5',
            question:
                'Qual tratado de 1494 dividiu o mundo entre Portugal e Castela?',
            options: [
              'Tordesilhas',
              'Alcanizes',
              'Madrid',
              'Roma',
              'Saragoça'
            ],
            correctAnswerIndex: 0,
            explanation:
                'O Tratado de Tordesilhas dividiu as terras a descobrir por um meridiano.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.iberialUnion:
        return [
          const QuizQuestion(
            id: 'ui_1',
            question: 'Qual rei desapareceu na Batalha de Alcácer-Quibir?',
            options: ['D. Sebastião', 'D. Manuel I', 'D. João III', 'D. Henrique'],
            correctAnswerIndex: 0,
            explanation:
                'O desaparecimento de D. Sebastião em 1578 levou a uma crise de sucessão.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'ui_2',
            question: 'Quantos reis chamados "Filipe" governaram Portugal?',
            options: ['Três', 'Dois', 'Um'],
            correctAnswerIndex: 0,
            explanation:
                'Filipe I, II e III governaram Portugal durante a União Ibérica.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'ui_3',
            question: 'Durante quantos anos Portugal esteve unido a Espanha?',
            options: ['60 anos', '100 anos', '20 anos', '150 anos', '10 anos'],
            correctAnswerIndex: 0,
            explanation:
                'Portugal esteve sob a União Ibérica de 1580 a 1640.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.restoration:
        return [
          const QuizQuestion(
            id: 'res_1',
            question: 'Em que data se celebra a Restauração da Independência?',
            options: ['1 de dezembro', '5 de outubro', '25 de abril', '10 de junho'],
            correctAnswerIndex: 0,
            explanation:
                'A 1 de dezembro de 1640, Portugal recuperou a sua independência.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'res_2',
            question: 'Quem foi o primeiro Rei da Dinastia de Bragança?',
            options: ['D. João IV', 'D. Teodósio', 'D. Duarte'],
            correctAnswerIndex: 0,
            explanation: 'D. João IV foi aclamado Rei após a Restauração.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'res_3',
            question: 'Qual destes eventos destruiu Lisboa em 1755?',
            options: [
              'Terramoto',
              'Peste Negra',
              'Inundação',
              'Incêndio',
              'Fecunda'
            ],
            correctAnswerIndex: 0,
            explanation: 'O terramoto de 1755 destruiu grande parte da capital.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      case HistoricalEra.modern:
        return [
          const QuizQuestion(
            id: 'mod_1',
            question: 'Em que ano ocorreu a implantação da República?',
            options: ['1910', '1820', '1974', '1933'],
            correctAnswerIndex: 0,
            explanation: 'A República foi proclamada a 5 de outubro de 1910.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'mod_2',
            question: 'Qual é o nome da revolução de 25 de abril de 1974?',
            options: ['Dos Cravos', 'Liberal', 'Gloriosa'],
            correctAnswerIndex: 0,
            explanation: 'A Revolução dos Cravos restaurou a democracia.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'mod_3',
            question: 'Que evento marcou o ano de 1820 em Portugal?',
            options: [
              'Revolução Liberal',
              'Tratado de Roma',
              'Expo 98',
              'CEE',
              'Ponte'
            ],
            correctAnswerIndex: 0,
            explanation:
                'A Revolução Liberal trouxe a monarquia constitucional.',
            difficulty: DifficultyLevel.hard,
          ),
        ];

      default:
        return [
          const QuizQuestion(
            id: 'default_1',
            question: 'Qual é a capital de Portugal?',
            options: ['Lisboa', 'Porto', 'Faro', 'Braga'],
            correctAnswerIndex: 0,
            explanation: 'Lisboa é a capital de Portugal.',
            difficulty: DifficultyLevel.easy,
          ),
          const QuizQuestion(
            id: 'default_2',
            question: 'Qual é o rio mais longo de Portugal?',
            options: ['Tejo', 'Douro', 'Guadiana', 'Minho'],
            correctAnswerIndex: 0,
            explanation: 'O rio Tejo é o mais longo da Península Ibérica.',
            difficulty: DifficultyLevel.medium,
          ),
          const QuizQuestion(
            id: 'default_3',
            question: 'Em que continente se localiza Portugal?',
            options: ['Europa', 'Ásia', 'África', 'América'],
            correctAnswerIndex: 0,
            explanation: 'Portugal localiza-se na Europa Ocidental.',
            difficulty: DifficultyLevel.easy,
          ),
        ];
    }
  }
}
