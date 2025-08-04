# 🧩 Git Command Übersicht fürs Team

## 🔁 Allgemeine Projektpflege

| Zweck| Befehl|
|-----------------------------|--------------------------------------------------|
| Repository klonen           | `git clone <repo-url>`                          |
| Status anzeigen             | `git status`                                    |
| Änderungen anzeigen         | `git diff`                                      |
| Änderungen an Datei sehen   | `git diff <dateiname>`                          |
| Projekt aktualisieren       | `git pull`                                      |

---

## ✍️ Änderungen lokal verwalten

| Zweck                        | Befehl                                           |
|-----------------------------|--------------------------------------------------|
| Dateien zur Staging-Area    | `git add <datei>` oder `git add .`              |
| Änderungen committen        | `git commit -m "Commit-Nachricht"`              |
| Letzten Commit ansehen      | `git log -1`                                     |
| Letzte Commits im Überblick | `git log --oneline`                              |

---

## 🚀 Änderungen hochladen (Push)

| Zweck                        | Befehl                                           |
|-----------------------------|--------------------------------------------------|
| Änderungen hochladen        | `git push`                                      |
| Erstes Push auf Remote      | `git push -u origin main` *(oder master)*       |

---

## 🌱 Mit Branches arbeiten (optional)

| Zweck                        | Befehl                                           |
|-----------------------------|--------------------------------------------------|
| Neuen Branch erstellen      | `git checkout -b feature/mein-feature`          |
| Zu anderem Branch wechseln  | `git checkout main`                             |
| Lokale Branches anzeigen    | `git branch`                                    |
| Remote-Branches anzeigen    | `git branch -r`                                 |
| Branch pushen               | `git push -u origin <branch-name>`              |

---

## 🛠️ Konflikte & Schutz

| Zweck                        | Befehl                                           |
|-----------------------------|--------------------------------------------------|
| Änderungen sichern (Stash)  | `git stash`                                     |
| Gespeicherte Änderungen anwenden | `git stash pop`                           |
| Änderungen verwerfen        | `git restore <datei>`                           |
| Dateien aus letztem Commit zurücksetzen | `git reset --hard HEAD`            |

---

## 🔐 Authentifizierung

| Zweck                        | Hinweis                                          |
|-----------------------------|--------------------------------------------------|
| Push ohne Passwort          | GitHub verlangt einen **Personal Access Token** |
| Token erzeugen              | [Token erstellen](https://github.com/settings/tokens) |