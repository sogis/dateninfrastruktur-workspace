# Dateninfrastruktur-Workspace

Der Workspace hilft beim lokalen Klonen und Anzeigen des Git-Status. Die
Produktrepositories sind eigenständige Git-Repositories mit eigenen
Agentenanweisungen. Ihre Quellen bleiben ausserhalb des Workspace-Index.
Produktbuilds, Betrieb, Integrationstests und Releases gehören in die jeweiligen
Repos. Coding-Agenten und Reviews brauchen hier keine eigene Plattform.

Prüfe Git-Toplevel, Ausgangscommit, Status und Remotes vor Änderungen. Bewahre
fremde Dateien und lokale Arbeit. Bestehende Checkouts bleiben bei
Workspace-Befehlen unverändert. Verwende dort keine destruktiven Git-Kommandos.
Pushes, Merges, Releases und Änderungen an fremden Repos benötigen einen
ausdrücklichen Auftrag.

Bevorzuge direkte Git-Kommandos und Löschungen. Ergänze Funktionen nur bei
konkretem aktuellem Bedarf. Vermeide unnötige Abstraktionen, historische
Kompatibilitätsschichten und eigene Kontrollmechanismen. Hashes, Fingerprints
und Belegsysteme brauchen eine echte Produktanforderung. Prüfe das Verhalten
mit kleinen, isolierten Tests.

Prüfe grössere Entwürfe vor der Umsetzung mit
[simplify-change](.agents/skills/simplify-change/SKILL.md). Beauftrage vor
PR-Abschluss einen unabhängigen Review mit
[review-change](.agents/skills/review-change/SKILL.md) und simplify-change.
