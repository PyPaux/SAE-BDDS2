# Réponses SAE BDD
## Exercice 1 - Comprendre les données
1. Il y a 271117 lignes dans le fichier atlhète `wc -l athlete_events.csv`

2. 
```
"ID","Name","Sex","Age","Height","Weight","Team","NOC","Games","Year","Season","City","Sport","Event","Medal"
```
`head -n 1 athlete_events.csv`

3. On voit grâce à la commande d'avant que les séparateurs sont les virgules.

4. Une ligne représente une donnée `head -n 5 athlete_events.csv`

5. Il y a 14 colonnes `head -n 1 athlete_events.csv | grep ,`

6. La colonne "Season" permet de disntiguer les deux jeux.

7. Il y a 6 lignes qui font référence à Jean-Claude Killy `cat athlete_events.csv | grep "Jean-Claude Killy" -c`

8. Le fichier est en ASCII `file athlete_events.csv -i`

9. En créant une table import dans notre base de données et charger le fichier dedans.

## Exercice 4 - Ventiler les données