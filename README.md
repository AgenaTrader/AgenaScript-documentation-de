![AgenaTrader](./sources/images/logo_100.png)

# Live System
Um loszulegen: [https://agenatrader.github.io/AgenaScript-documentation-de/index.html](https://agenatrader.github.io/AgenaScript-documentation-de/index.html)

# Dokumentation
MkDocs ist ein schneller, einfacher und regelrecht wunderschöner Generator von statischen Webseiten, der auf den Aufbau von Projektdokumentation ausgerichtet ist. Quelldateien einer Dokumentation werden im [Markdown](https://guides.github.com/features/mastering-markdown/) Format geschrieben und mit einer einzigen YAML-Konfigurationsdatei konfiguriert. Die Tutorials im Quellenverzeichnis dieses Repositorys werden mit mkdocs gebaut und auf GitHub Pages öffentlich gehostet unter  [https://github.com/AgenaTrader/AgenaScript-documentation](https://github.com/AgenaTrader/AgenaScript-documentation)

Diese Beschreibung wird Ihnen zeigen, wie Sie statische Webseiten erstellen und diese auf das Live-System übertragen.

## Vorbereitung
### Editor
Um diese Dateien zu editieren, können Sie den GitHub Online Editor verwenden, wir empfehlen aber, einen gesonderten Text-Editor zu verwenden. Wir empfehlen den Text-Editor **Atom**. [You can download it here.](https://atom.io)

![Atom](./sources/images/logo_atom.png)

### Installation
Folgende Dinge sind Voraussetzung:
*   Installieren Sie  [GitHub Client](https://desktop.github.com), erstellen Sie einen GitHub-Benutzer und schauen Sie sich das Repository an
*   Installieren Sie  [Python](https://www.python.org/downloads/)
*   Installieren Sie das Python-Paket  [mkdocs](http://www.mkdocs.org) anhand von pip
*   Installieren Sie  [Pandoc](http://pandoc.org/installing.html)

Nach Installation aller Pakete können wir anfangen, die Daten zu analysieren und unsere Seite einzusetzen.

# Getting Started
Klonieren Sie das Haupt-Repository auf ihrem lokalen Rechner. Da wir jetzt alles in der richtigen Stelle haben, werden wir Dateien modifizieren und die neue Seite einführen. Im Folgenden sehen Sie eine ausführliche Beschreibung, wie Sie Daten in der GH Pages-Seite erstellen und einsetzen. Falls Sie keine Zeit haben, schauen Sie einfach direkt auf  [Short version on how to deploy](#short-version-on-how-to-deploy)

## Detaillierte Beschreibung
### Verzweigte GH Pages erstellen
Folgenden Schritt müssen Sie nur dann ausführen, wenn der GH Pages-Zweig noch nicht zuvor erstellt wurde. Unsere statische Webseite wird über den GH Pages-Zweig dargestellt. Daher müssen wir den Zweig erstellen, indem wir folgende Befehle mithilfe der Befehlszeile verwenden.
```bash
git checkout master # you can avoid this line if you are in master
git subtree split --prefix output -b gh-pages # create a local gh-pages branch containing the splitted output folder
git push -f origin gh-pages:gh-pages # force the push of the gh-pages branch to the remote gh-pages branch at origin
git branch -D gh-pages # delete the local gh-pages
```

### Analyse (Parsen) von Markdown zur statischen Webseite
Alle sich in diesem Repository befindlichen Dokumente sind im Markdown-Format geschrieben und werden im Quellenverzeichnis dieses Repositorys aufbewahrt. Um diese Markdown-Dateien in statische Webseiten zu parsen, brauchen wir mkdocs, um diese Arbeit für uns zu erledigen. mkdocs wird diese Markdown-Dateien parsen, diese in statische Webseiten übertragen und dann im Site-Verzeichnis aufbewahren. Die gesamte Konfiguration wird in einer einzigen  [YAML configuration file](mkdocs.yml) ausgeführt, um den Analysevorgang zu konfigurieren. Öffnen Sie Console, navigieren Sie zu Ihrer YAML-Konfigurationsdatei und bauen Sie die Markdown-Dateien anhand des mkdocs-

```bash
mkdocs build
```
Dies wird ein neues Verzeichnis mit dem Namen *site* erschaffen. 
Falls Sie eine Warnung bekommen, dass das *site-Verzeichnis* schon erstellt wurde, können Sie das `clean` Parameter verwenden, um dieses Verzeichnis zu löschen, bevor Sie diese neu erschaffen.
```bash
mkdocs build --clean
```

### Analyse (Parsen) von Markdown zum Ebook (epub)
Öffnen Sie nun den Ordner „Dokumente“ und modifizieren Sie das Freigabedatum in der **epub_title.txt** Datei.
Danach navigieren Sie zu Ihrem Quellordner, öffnen Sie eine Console und erstellen Sie ein Ebook im \*.epub Format:
```bash
pandoc -S --epub-cover-image=../documents/epub_cover.png --epub-stylesheet=../documents/epub_styles.css -o ../documents/agenascript-documentation.epub ../documents/epub_title.txt index.md handling_bars_and_instruments.md events.md strategy_programming.md keywords.md drawing_objects.md hints_and_advice.md
```

### Ebook validieren (epub)
Wir empfehlen, mithilfe von  **pagina EPUB-Checker** das Ebook zu validieren. [You can download it here.](http://www.pagina-online.de/produkte/epub-checker/#c773)

### PAnalyse (Parsen) von Markdown zur Word-Datei
Navigieren Sie zu Ihrem Quellordner, öffnen Sie eine Console und erstellen Sie ein Word-Dokument im  \*.docx Format:
```bash
pandoc -S -o ../documents/agenascript-documentation.docx ../documents/epub_title.txt index.md handling_bars_and_instruments.md events.md strategy_programming.md keywords.md drawing_objects.md hints_and_advice.md
```

### Links zur Fehlerbehebung für Bilder
Falls Sie  *<img> tags* in Ihrer Markdown-Datei verwenden, erstellt mkdocs falsche Links für diese Bilder, deswegen müssen wir dies ändern, indem wir ** ./media/ to ../media/** manuell ersetzen.
Eine weitere Option besteht darin, dies automatisch anhand von **sed** auf Linux oder Macintosh zu machen:
```bash
sed -i .bak -e 's%./media/%../media/%g' site/drawing_objects/index.html  && rm site/drawing_objects/index.html.bak
sed -i .bak -e 's%./media/%../media/%g' site/events/index.html  && rm site/events/index.html.bak
sed -i .bak -e 's%./media/%../media/%g' site/handling_bars_and_instruments/index.html  && rm site/handling_bars_and_instruments/index.html.bak
sed -i .bak -e 's%./media/%../media/%g' site/hints_and_advice/index.html  && rm site/hints_and_advice/index.html.bak
sed -i .bak -e 's%./media/%../media/%g' site/keywords/index.html  && rm site/keywords/index.html.bak
sed -i .bak -e 's%./media/%../media/%g' site/strategy_programming/index.html  && rm site/strategy_programming/index.html.bak
```

## Kurze Version, wie man einsetzt
Wir haben schon einen Zweig namens *gh-pages* erstellt, alle Daten von diesem Zweig werden auf GitHub Pages angezeigt.

### mkdocs-Version nachprüfen
Der neueste Einsatz dieser Dokumentation wurde mit  **mkdocs version 0.16.0 (2016-11-04)** erstellt.
Bitte verwenden Sie folgendes Befehl, um Ihre mkdocs-Version nachzuprüfen.
```bash
mkdocs --version
```

Wenn Sie eine ältere mkdocs-Version betreiben, verwenden Sie bitte folgendes Befehl, um auf eine neuere Version zu aktualisieren.
```bash
pip install --upgrade mkdocs
```

### Änderungen festlegen
Erstellen Sie einen Commit und schicken Sie all Ihre Änderungen ins Haupt-Repository, dann synchronisieren Sie mit Ihrem entfernten Repository.

### Bauen
Nun sind wir bereit, folgendes Shell-Script auszuführen, um die Webseite aus unseren Markdown-Dateien zu bauen.
```bash
./buildanddeploy.sh -build
```

### Aufbau festlegen
Nun ist es Zeit, den neuen Aufbau im Haupt-Repository festzulegen. Erstellen Sie einen Commit, schicken Sie all Ihre Änderungen ins Haupt-Repository und synchronisieren Sie mit Ihrem entfernten Repository.

### Einsetzen
Ist der Bauprozess fertig, können wir damit anfangen, die Webseite zum gh-Zweig unseres entfernten Repositorys einzusetzen.
```bash
./buildanddeploy.sh -deploy
```

Glückwünsche! Wir sind fertig. Alle Änderungen sind nun auf GitHub Pages online.
