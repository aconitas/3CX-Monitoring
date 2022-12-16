# Beschreibung

Dieser Artikel beschreibt die Vorgehensweise zum Import von Monitoring-Skripten in die Skriptbibliotek im .rsf-Format in **RiverSuite**

# Anleitung

Step 1: `Monitoring` -> `Einstellungen` -> `Skript-Einstellungen`

![RiverSuite_Inventory_mpP51riAtz](https://user-images.githubusercontent.com/119604651/208198649-8543ac8f-75eb-4507-885b-5273fd50c944.png)

Step 2: `Anlegen` -> aussagekräftigen Namen vergeben -> `Speichern`

![RiverSuite_Inventory_0aghLe5hwY](https://user-images.githubusercontent.com/119604651/208199030-66ab091b-9cd5-4d0d-b9c7-244d6745a5b7.png)

Step 3: Auf der linken Seite die neu erstelle Kategorie markieren -> `Skript importieren` -> Datei auswählen -> `öffnen`

![RiverSuite_Inventory_NdD7FqIhii](https://user-images.githubusercontent.com/119604651/208201957-eecbfae9-8880-445b-a712-2aed136978ea.png)

Step 4: Bei Bedarf Anpassung des Skript-Namens -> `Exit-Codes` wie abgebildet übernehmen -> `Speichern`

![RiverSuite_Inventory_2IGrqNTg8v](https://user-images.githubusercontent.com/119604651/208199828-e5557027-cdc1-45d0-b0ad-a76cc72e1702.png)

# Ergebnis

Der Check kann nun jedem relevanten Server manuell hinzugefügt werden.

Step 1: `Monitoring`-> Sever auswählen -> `Skript`-> `Skript aus Skript Bibliothek auswhählen`

![RiverSuite_Inventory_ufvidNC2tb](https://user-images.githubusercontent.com/119604651/208202792-20a349d8-dc7e-45c4-8ce1-9bbee3332b23.png)

Step 2:

![RiverSuite_Inventory_1Cib6ReOqa](https://user-images.githubusercontent.com/119604651/208203242-577e8812-0c5a-4af5-84a8-0322a280ee10.png)


Ein einfache Möglichkeit für ein regelbasierte Verteilung der Checks über die Checkpaketverwaltung finden sie <a href="https://github.com/aconitas/3CX-Monitoring/blob/main/Scripts%20(use%20with%20local%20Linux%20Monitoring%20Agent)/Checkpaketverwaltung.md">hier</a>.

ACHTUNG: diese Möglichkeit der regelbasierten Verteilung eignet sich idealerweise nur für die Variante <a href="https://github.com/aconitas/3CX-Monitoring/tree/main/Scripts%20(use%20with%20local%20Linux%20Monitoring%20Agent)">use with local Linux Monitoring Agent</a>, da hier keine individuelle Anpassung der Parameter und Variablen benötigt wird.
