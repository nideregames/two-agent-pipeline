# Dev Pipeline: Claude.ai + Claude Code

**Stateful AI dev pipeline for stateless coding agents.**

Убирает повторное объяснение проекта между сессиями. Делает задачи атомарными, а решения — трассируемыми.

Claude.ai планирует и ведёт память проекта. Claude Code исполняет спеки. Vault хранит источник правды.

> Это готовая реализация пайплайна для разработки ПО. Абстрактный фреймворк и гайд по адаптации под другие области — в [корне репозитория](../../README.md).

---

## Зачем

| | Claude Code напрямую | Через pipeline |
|---|---|---|
| **Плюс** | Быстро стартануть | Память между сессиями, трассируемость, меньше дрейфа |
| **Минус** | Контекст распадается, каждый раз объясняешь заново | Выше операционная дисциплина |

Проблема: Claude Code не помнит контекст между сессиями, а Claude.ai не может писать код. Работая с Claude Code напрямую, приходится каждый раз заново объяснять проект, повторять ограничения, вспоминать, что было сделано.

Решение: **project vault** — общая память проекта на диске. Оба агента читают и пишут туда. Ничего не теряется.

## Когда НЕ нужен pipeline

- Одноразовый скрипт на 10 минут — проще попросить напрямую
- Микро-багфикс без проектного контекста — adhoc через Claude Code
- Проект в сильном хаосе, когда source of truth всё равно невозможно поддерживать
- Первые эксперименты с идеей — сначала проверь гипотезу, потом формализуй

---

## Что нужно

1. **Claude.ai** (Pro/Max/Team/Enterprise) с подключённым Filesystem MCP
2. **Claude Code** (CLI или IDE)
3. **Obsidian** (бесплатный, опционально) — для просмотра vault

## Установка

### Шаг 1: Скилл

Положи папку [`dev-pipeline-init/`](dev-pipeline-init/) в `~/.claude/skills/`. Или загрузи `.skill` файл в Claude.ai: Settings → Skills → Upload ZIP.

### Шаг 2: Project instructions

Создай новый проект в Claude.ai. Вставь содержимое [`project-instructions.md`](project-instructions.md) в Project Instructions.

### Шаг 3: Filesystem MCP

Убедись, что Filesystem MCP подключён к Claude.ai.

### Шаг 4: Slash command для Claude Code

Создай файл `~/.claude/commands/go.md` — это глобальная команда `/go` для Claude Code. Содержимое — в [`dev-pipeline-init/go.md`](dev-pipeline-init/go.md). После этого вместо объяснений "прочитай CLAUDE.md, найди спеку" достаточно написать `/go`.

### Шаг 5: Инициализация

Скажи Claude.ai: **"Инициализируй vault для моего проекта. Корневая папка: /path/to/project"**

Для миграции существующего проекта: **"Мигрируй проект на пайплайн. Корневая папка: /path/to/project"**

Git-репозитории создавать руками не нужно — Claude Code инициализирует git для vault'а и всех подпроектов автоматически при первом обращении. Он также предложит создать remote на GitHub.

---

## Как работать

### Новая фича

1. Открой чат с Claude.ai → опиши что хочешь
2. Claude.ai изучит vault, обсудит подход, напишет спеки
3. Покажет спек на проверку → ты подтверждаешь
4. Открой Claude Code в нужном репо, напиши **`/go`**
5. Claude Code сам найдёт approved спек, прочитает контекст из vault'а и начнёт работу
6. Вернись к Claude.ai → он сам найдёт и прочитает отчёт

### Быстрый фикс

1. Опиши проблему в Claude Code
2. Claude Code прочитает constraints и gotchas, починит, напишет adhoc-отчёт
3. Claude.ai подхватит отчёт в следующем чате автоматически

---

## Пример: добавление email-логина

**Шаг 1: Обсуждение с Claude.ai**

> Ты: "Хочу добавить email+password логин в лончер. Сейчас есть только OAuth через Cognito."

Claude.ai читает vault, предлагает план:
1. RECON — как работает текущая авторизация
2. Реализация формы логина
3. Интеграция с Cognito email auth
4. Тесты

**Шаг 2: Claude.ai пишет спек 005 (RECON)**

```markdown
---
id: "005"
status: draft
subsystem: launcher
feature: email-auth
type: recon
---
# 005: RECON — Current auth flow in launcher

## Task
Investigate how auth currently works and what needs to change for email login.

## Questions to answer
1. Where is auth logic located?
2. How does OAuth flow work?
3. What Cognito config exists?
...
```

Ты подтверждаешь → Claude.ai меняет статус на `approved`.

> Claude.ai: "Спек 005 готов. Открой Claude Code в лончере и напиши `/go`."

**Шаг 3: Claude Code выполняет RECON**

Claude Code читает спек, изучает код, пишет отчёт:

```markdown
# Session 005: RECON — Current auth flow

## Result
Auth flow исследован. Email login потребует изменений в 3 файлах.

## Discoveries
- Cognito User Pool уже поддерживает email+password, просто не включён в UI
- safeStorage хранит только OAuth токены, нужно расширить формат
...

## Next recommended step
Спек на UI формы логина. Cognito-часть уже готова, менять не нужно.
```

**Шаг 4: Следующий чат с Claude.ai**

> Ты: "Привет"

Claude.ai автоматически: "Нашёл непрочитанный отчёт по сессии 005. Вот что узнал Claude Code: [резюме]. Cognito уже поддерживает email — нужен только UI. Пишу спек 006 на форму логина."

---

## Структура vault

> В абстрактном фреймворке эти слои называются `pipeline/`, `project/`, `areas/`, `state/`. Здесь используются доменные имена с префиксом `_` и `subsystems/` вместо `areas/` — это пример адаптации под разработку.

```
vault/
├── _pipeline/         # Шаблоны
├── _project/          # Источник правды о проекте
│   ├── brief.md
│   ├── architecture.md
│   ├── conventions.md
│   ├── constraints.md     # "Не делай" правила (КРИТИЧНО)
│   ├── gotchas.md
│   ├── integrations.md
│   └── working-preferences.md  # Как пользователь предпочитает работать
├── _state/
│   ├── active.md
│   ├── backlog.md
│   ├── roadmap.md         # Стратегический план с вехами
│   ├── decisions.md       # Решения с обоснованием
│   └── reviewed.md
├── discussions/       # Резюме обсуждений PM ↔ пользователь
├── features/          # Трекеры фич
├── subsystems/        # Знания по каждой подсистеме (= areas/ в абстрактном фреймворке)
├── specs/             # ТЗ от Claude.ai
└── sessions/          # Отчёты от Claude Code
```

Каждая подсистема содержит `architecture.md` (как работает), `structure.md` (где что лежит в коде), `gotchas.md` (подводные камни) и другие файлы по необходимости.

---

## Ключевые принципы

**Один спек = одна задача = 10-15 минут.** Большие задачи дробятся.

**RECON перед реализацией.** Сначала исследование, потом код.

**Vault = источник правды.** Код — реальность. Vault — документация. Когда расходятся — код побеждает, но расхождение фиксируется.

**Constraints — приоритет #1.** Пропущенное правило "не делай X" стоит дороже пропущенной конвенции.

**Спек проходит lifecycle:** `draft` → `approved` → `in_progress` → `done` / `partial` / `blocked` / `failed` / `cancelled`

---

## FAQ

**Нужен ли Obsidian?**
Нет. Vault — папка с .md файлами. Obsidian удобен для просмотра, но не обязателен.

**Можно ли работать без спеков?**
Да — adhoc-сессии. Но для сложных фич спеки дают лучший результат.

**Что если Claude Code ошибся?**
Claude.ai напишет спек на bugfix с git revert. Ошибка документируется в gotchas.

**Работает ли для не-кодовых задач?**
Да. Маркетинг, гейм-дизайн, операции — всё это subsystems с такой же структурой знаний. Спеки работают одинаково: "напиши контент-план", "проанализируй конкурентов". См. также [гайд по кастомизации](../../docs/customization.md).

**Можно ли улучшать пайплайн?**
Мелкие улучшения — в любом чате. Структурные изменения — в отдельном мета-проекте.

**Как поделиться с коллегой?**
Ему нужны: этот README + [`project-instructions.md`](project-instructions.md) + папка [`dev-pipeline-init/`](dev-pipeline-init/) + [`go.md`](dev-pipeline-init/go.md) (скопировать в `~/.claude/commands/`).
