# Aventura da História 🇵🇹

Um jogo educativo em Flutter + Flame para ensinar a História de Portugal a crianças dos 10–13 anos.

## 🎮 Funcionalidades

- **10 Capítulos Históricos**: Desde os Povos Pré-Romanos até ao Portugal Moderno
- **Personagens Companheiras**: Uma personagem estilo anime por cada era histórica
- **Quiz Interativo**: Perguntas de múltipla escolha com dificuldade mista (Fácil, Médio, Difícil)
- **Progresso Persistido**: SQLite para guardar progresso e personagens desbloqueadas
- **Linha Temporal Visual**: Mapa interativo da história de Portugal
- **Idioma**: Português (pt-PT)

## 📱 Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/         # Strings e constantes da app
│   └── theme/             # Temas e estilos
├── data/
│   ├── database/          # SQLite helper
│   ├── models/            # Modelos de dados
│   └── providers/         # State management com Provider
├── game/
│   ├── components/        # Componentes Flame
│   └── services/          # Quiz service
├── screens/               # Ecrãs da aplicação
└── widgets/               # Widgets reutilizáveis
```

## 🚀 Começar

### Pré-requisitos

- Flutter SDK >= 3.16.0
- Dart SDK >= 3.2.0
- Android Studio / VS Code com extensões Flutter

### Instalação

```bash
# Clonar o repositório
cd aventura-historia

# Instalar dependências
flutter pub get

# Executar a app
flutter run
```

## 🧪 Testes

O projeto inclui uma suite completa de testes (unitários, widget e integração).

### Executar testes localmente (com Docker)
Recomendado para garantir a consistência do ambiente de execução (Flutter 3.19.4).

```bash
# Configurar o ambiente (build da imagem)
make docker-setup

# Executar todos os testes
make docker-test
```

### Executar testes manualmente (sem Docker)
```bash
flutter test
```

## 📚 Capítulos

1. **Povos Pré-Romanos** (antes de 218 a.C.)
2. **Domínio Romano** (218 a.C. - 468 d.C.)
3. **Suevos e Visigodos** (468 - 711)
4. **Domínio Islâmico** (711 - 1095)
5. **Condado Portucalense** (1095 - 1139)
6. **Primeira Dinastia** (1139 - 1383)
7. **Era dos Descobrimentos** (1415 - 1580)
8. **União Ibérica** (1580 - 1640)
9. **Restauração da Independência** (1640 - 1820)
10. **Portugal Moderno** (1820 - atualidade)

## 🎨 Personagens

Cada era histórica tem uma personagem companheira com:
- Nome e descrição única
- Traços de personalidade
- Cor temática associada
- Estado de desbloqueio (bloqueado/desbloqueado)

## 💾 Persistência

A app usa SQLite para guardar:
- Progresso por capítulo
- Pontuações e estrelas
- Personagens desbloqueadas
- Histórico de quizzes

## 🛠️ Tecnologias

- **Flutter**: Framework UI
- **Flame**: Game engine para efeitos visuais
- **SQLite**: Base de dados local
- **Provider**: Gestão de estado
- **Material 3**: Design system

## 📝 Próximos Passos

- [x] Adicionar mais perguntas a cada capítulo
- [ ] Implementar animações Flame
- [ ] Adicionar assets de personagens (imagens anime)
- [ ] Efeitos sonoros e música
- [ ] Modo de estudo vs modo de teste
- [ ] Conquistas e recompensas
- [ ] Partilha de progresso

## 📄 Licença

Este projeto é educativo.

## 👥 Equipa

Desenvolvido para ensinar a História de Portugal às novas gerações! 🇵🇹✨
