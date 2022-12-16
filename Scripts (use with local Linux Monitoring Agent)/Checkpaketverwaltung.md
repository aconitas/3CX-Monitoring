# Beschreibung

Dieser Artikel beschreibt die regelbasierte Verteilung der Skripte über die Checkpaketverwaltung in der RiverSuite eingerichtet wird. Sie finden hier eine grafische Anleitung der einzelnen Schritte

# Anleitung

Step 1: `Monitoring` -> `Vorlagen` -> `Checkpakete verwalten`

![FID07OHnfF](https://user-images.githubusercontent.com/119604651/208193034-d068b7aa-f0a0-4948-a7d4-1d9a8f9aeb21.png)

Step 2: `Checkpaket erstellen` -> dem Checkpaket einen aussagekräftigen Namen zuweisen -> `Neue Regelbasierte Zuweisung` starten

![RiverSuite_Inventory_SNfZFJs6ux](https://user-images.githubusercontent.com/119604651/208192262-0baf0af6-b786-4b2a-8455-1c067e60bb74.png)

Step 3: Neue Regel hinzufügen -> mit Bedingung: Der Name einer Anwendung ist gleich 3cxpbx -> Übernehmen
Über die Vorschau kann geprüft werden, ob die Regel korrekt angewendet werden kann. Es sollte einer Liste der Server erscheinen. Falls dies alles korrekt ist den Punkt mit Übernehmen abschließen.

![1HKi5pbNOi](https://user-images.githubusercontent.com/119604651/208193106-25382e53-169e-4006-809f-d73bd0d904ae.png)

Step 4: Checks mit dem neuen Checkpaket verknüpfen -> gewünschte Checks auswählen und mit `Ausgewählte Vorlagen übernemen` bestägigen

![RiverSuite_Inventory_CB0neHdn0j](https://user-images.githubusercontent.com/119604651/208193829-9a60bd54-9077-4f6a-9447-3bba6efb1406.png)

Step 5: Nach erfolgreicher konfiguration sollten die Checks wie gewünscht aufgeführt sein. Bei Bedarf können auch noch RiverSuite eigene Checks für Performance, Diensteüberwachung, uws. hinzugefügt werden. Zum Schluss die Einrichtung über `Alles Speichern` sichern.

![RiverSuite_Inventory_GqO4joJSDF](https://user-images.githubusercontent.com/119604651/208195332-1eb87991-3345-43b4-9c90-b05634fd4067.png)
