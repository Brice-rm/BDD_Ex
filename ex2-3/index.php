<?php
$db = new PDO('mysql:host=localhost;dbname=test2', 'root', '');

$requete = $db->query('SELECT UPPER(nom) AS nom_maj FROM games');
while ($donnees = $requete->fetch())
{
echo $donnees['nom_maj'] .  '<br />';
}
$requete->closeCursor();

?>