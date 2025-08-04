# 🧩 Git Command Übersicht

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

---   


# ✅ Git Feature-Branch mit `main` mergen

Diese Anleitung zeigt dir Schritt für Schritt, wie du deinen Feature-Branch sauber in den `main`-Branch mergen kannst, damit dein Team Zugriff auf deinen erstellten Code hat.

---

#### Beispiel Branch: `login`

---

## 🧭 Schritte (lokal + GitHub)

### 1. 📍 Sicherstellen, dass du im Branch `login` bist:

```bash
git branch
# Falls du nicht auf login bist:
git checkout login
```

---

### 2. 💾 Änderungen committen:

```bash
git add .
git commit -m "Login-Funktion fertig"
```

---

### 3. 🔄 Den aktuellen `main`-Branch holen:

```bash
git checkout main
git pull origin main
```

---

### 4. 🔀 Zurück zu `login` und `main` hineinmischen:

```bash
git checkout login
git merge main
```

*(Optional: Testen, ob alles läuft)*

---

### 5. 📤 Merge `login` → `main`:

```bash
git checkout main
git merge login
```

**Falls Konflikte auftreten:**
- Konflikte manuell lösen
- Danach:

```bash
git add .
git commit -m "Konflikte beim Login-Merge gelöst"
```

---

### 6. 🚀 Änderungen in `main` pushen:

```bash
git push origin main
```

---

## 🧹 Optional: Feature-Branch löschen

```bash
git branch -d login                 # lokal löschen
git push origin --delete login     # remote löschen (optional)
```

---

## ✅ Ergebnis:
- `main` enthält jetzt den Login-Code
- Dein Team kann ihn mit `git pull` abrufen
