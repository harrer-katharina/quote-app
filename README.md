# Flutter Quote App

Die Quote App ermöglicht es dir, zufällige inspirierende Zitate zu entdecken und basierend auf ausgewählten Tags zu filtern. Zitate können zu einer Favoritenliste hinzugefügt und von dort wieder entfernt werden. Die Zitate und Tags werden über eine öffentliche API dynamisch abgerufen.

---

## 🛠 Features

- Anzeigen von zufälligen Zitaten.
- Anzeigen aller verfügbaren Kategorien.
- Filtern von Zitaten basierend auf ausgewählten Kategorien.
- Anzeigen der Zitate mit Autor und Text.
- Hinzufügen eines Zitates zu einer Favoritenliste.
- Anzeigen der Favoritenliste.
- Entfernen eines Zitates von der Favoritenliste.

---

## 🚀 Voraussetzungen

1. **Flutter SDK**:

   - Lade das Flutter SDK von [flutter.dev](https://flutter.dev/docs/get-started/install) herunter.

2. **Android Studio** (auch andere IDE möglich):

   - Lade Android Studio von [developer.android.com](https://developer.android.com/studio) herunter.

3. **IDE-Plugins**:

   - Installiere **Flutter- / Dart-Plugins** in deiner IDE (z. B. Android Studio oder VS Code).

4. **Emulator oder physisches Gerät**:
   - Richte einen Emulator in Android Studio ein (siehe unten) oder verwende ein angeschlossenes physisches Gerät.

---

## 🔧 Installation

1. **Repository klonen**:

   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. **Abhängigkeiten installieren**  
   Lade alle erforderlichen Abhängigkeiten mit dem folgenden Befehl:

   ```bash
   flutter pub get
   ```

3. **Emulator einrichten**

- Öffne Android Studio.
- Gehe zu Tools > Device Manager.
- Erstelle ein neues Gerät und starte den Emulator.

## ▶️ Projekt starten

1. Emulator oder Gerät verbinden:

- Starte den Emulator in Android Studio oder verbinde ein physisches Gerät.

2. App ausführen:

- Terminal:

  ```bash
  flutter run
  ```

  Wenn du die App über die Kommandozeile startest, drücke r in deinem Terminal, um einen Hot Reload auszulösen, ohne die App zu beenden.

- Android Studio:
  - Öffne das Projekt in Android Studio.
  - Wähle oben rechts im Dropdown-Menü das gewünschte Gerät aus.
  - Klicke auf den grünen "Run"-Button.

## 💡 Hinweise

API: Die App verwendet keine eigene Backend-Datenbank, sondern ruft Zitate über eine API ab: https://quoteslate.vercel.app/
