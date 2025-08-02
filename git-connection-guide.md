# Anleitung für das Team
GitHub-Repo mit VS Code verbinden

**Projektname:** meal_planner_app  
**GitHub-URL:**  
\<https://github.com/HendrikAlexander/meal_planner_app\>

## Voraussetzungen (einmalig)
- Git installieren: \<https://git-scm.com/downloads\>
- VS Code installieren: \<https://code.visualstudio.com\>
- Optional: GitHub-Konto (für Push)

**Test:**  
Öffne das Terminal und gib `git --version` ein. Es sollte z. B. `git version 2.x.x` erscheinen

## Schritt-für-Schritt: Projekt klonen

1. **Repo-URL kopieren**  
   \<https://github.com/HendrikAlexander/meal_planner_app\>

2. **VS Code öffnen**

3. **Befehlspalette starten**  
   Windows: `Strg + Shift + P`  
   macOS: `Cmd + Shift + P`  
   -> Dann eingeben: `Git: Clone`

4. **Repo-URL einfügen**  
   -> Wenn du gefragt wirst: URL einfügen und bestätigen

5. **Zielordner auswählen**  
   -> Speicherort auf dem Gerät wählen (z. B. Dokumente/Projekte)

6. **Projekt öffnen**  
   -> VS Code fragt: Projekt öffnen? -> Ja

7. **Projekt testen**  
   Terminal öffnen:  
   Windows: `Strg + ö`  
   macOS: `Ctrl + ö`  
   Dann ausführen:  
   `flutter doctor`  
   `flutter run`

## Änderungen hochladen (Push)

1. **Code committen:**  
   ```bash
   git add .
   git commit -m "Mein erster Commit"