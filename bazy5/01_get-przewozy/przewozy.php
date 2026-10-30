<?php
$link = new mysqli("localhost", "root", "", "przewozy");

$sql = "SELECT id_zadania, zadanie, data
FROM zadania";
$result = $link->query($sql);
$exercises = $result->fetch_all(1);


?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Firma przewozowa</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Firma przewozowa Półdarmo</h1>
    </header>

    <nav></nav>

    <main>
        <section class="left">
            <h2>Zadania do wykonania</h2>

            <table>
                <tr>
                    <th>Zadanie do wykonania</th>
                    <th>Data realizacji</th>
                    <th>Akcja</th>
                </tr>
                <!-- SKRYPT 1 -->
                 <!-- <tr>
                   <td>{zadanie}</td> 
                   <td>{data}</td> 
                   <td><a href='przewozy.php?exercise-id={id_zadania}'>Usuń</a></td> 
                 </tr> -->
                <?php
                foreach ($exercises as $exercise){
                    echo "<tr>
                   <td>{$exercise['zadanie']}</td> 
                   <td>{$exercise['data']}</td> 
                   <td><a href='przewozy.php?exercise-id={$exercise['id_zadania']}'>Usuń</a></td> 
                 </tr>";
                }

                ?>
            </table>

            <form action="" method="post">
                <label for="exercise">Zadanie do wykonania</label>
                <input type="text" name="exercise" id="exercise"><br>
                <label for="date">Data realizacji</label>
                <input type="date" name="date" id="date">
                <button type="submit">Dodaj</button>
            </form>
        </section>

        <section class="right">
            <img src="auto.png" alt="auto firmowe">
            <h3>Nasza specjalność</h3>
            <ul>
                <li>Przeprowadzki</li>
                <li>Przewóz mebli</li>
                <li>Przesyłki gabarytowe</li>
                <li>Wynajem pojazdów</li>
                <li>Zakupy towarów</li>
            </ul>
        </section>
    </main>

    <footer>
        <p>Stronę wykonał:wqjei1h980e1h3</p>
    </footer>
</body>
</html>