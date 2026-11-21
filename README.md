# Dateninfrastruktur-Workspace

Der Workspace klont die Produktrepositories und zeigt ihren lokalen Git-Status.
Voraussetzungen sind Bash und Git.

```sh
git clone https://github.com/sogis/dateninfrastruktur-workspace.git
cd dateninfrastruktur-workspace
./workspace clone
./workspace status
```

Der [Einstieg in die Admin-Webentwicklung](https://github.com/sogis/dateninfrastruktur-dev-stack/blob/main/docs/operations.md#admin-webentwicklung-vom-checkout-zur-ersten-%C3%A4nderung)
führt vom lokalen Stack zur ersten Änderung im Browser.

`clone` überspringt vorhandene Checkouts. `status` zeigt fehlende Repositories
sowie Branch und lokale Änderungen vorhandener Checkouts. Ein anderweitig
belegter Zielpfad wird gemeldet. Die Produktrepositories bleiben eigenständige
Git-Repositories.

Aktualisiere einzelne Checkouts direkt mit Git.

```sh
git -C dateninfrastruktur-admin pull --ff-only
```

Pflege die Liste in `repositories.txt` mit einer Git-URL pro Zeile. Der letzte
Teil der URL ohne `.git` ergibt den lokalen Verzeichnisnamen. Leerzeichen am
Zeilenrand, Leerzeilen und Kommentare mit `#` werden ignoriert.

Der Offline-Test läuft mit `bash tests/test-workspace.sh`.
