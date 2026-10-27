<?php
$link = new mysqli('localhost','root','','rzeki');

$level_f = $_POST['level'] ?? 'all';

if ($level_f == 'all'){
    $sql = "SELECT nazwa, rzeka, stanOstrzegawczy, stanAlarmowy, stanWody
    FROM wodowskazy INNER JOIN pomiary ON wodowskazy.id=pomiary.wodowskazy_id
    WHERE datapomiaru = '2022-05-05'";
} 
else
if ($level_f == 'warning'){
    $sql = "SELECT nazwa, rzeka, stanOstrzegawczy, stanAlarmowy, stanWody
FROM wodowskazy INNER JOIN pomiary ON wodowskazy.id=pomiary.wodowskazy_id
WHERE datapomiaru = '2022-05-05'
AND pomiary.stanwody > wodowskazy.stanOstrzegawczy";
} 
else
if ($level_f == 'alarm'){
    $sql = "SELECT nazwa, rzeka, stanOstrzegawczy, stanAlarmowy, stanWody
FROM wodowskazy INNER JOIN pomiary ON wodowskazy.id=pomiary.wodowskazy_id
WHERE dataPomiaru = '2022-05-05'
AND pomiary.stanwody > wodowskazy.stanAlarmowy";
}
$result = $link->query($sql);
$water_levels = $result->fetch_all(1);

$sql = "SELECT dataPomiaru, AVG(stanwody) as srednia
FROM pomiary 
GROUP BY datapomiaru";

$result = $link->query($sql);
$averages = $result->fetch_all(1)
?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Poziomy rzek</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
        <section class="header-left">
            <img src="obraz1.png" alt="Mapa Polski">
        </section>

        <section class="header-right">
            <h1>Rzeki w województwie dolnośląskim</h1>
        </section>
    </header>
    <nav>
    <form action="" method="post">
        <input type="radio" name="level" id="all" value="all">
        <label for="all" class="radio-label">Wszystkie</label>
        <input type="radio" name="level" id="warning" value="warning">
        <label for="warning" class="radio-label">Ponad stan ostrzegawczy</label>
        <input type="radio" name="level" id="alarm" value="alarm">
        <label for="alarm" class="radio-label">Ponad stan alarmowy</label>
        <button type="submit">Pokaż</button>
    </form>
    </nav>
    <main>
        <section class="left">
            <h3>Stany na dzień 2022-05-05</h3>
            <table>
                <tr>
                    <th>Wodomierz</th>
                    <th>Rzeka</th>
                    <th>Ostrzegawczy</th>
                    <th>Alarmowy</th>
                    <th>Aktualny</th>
                </tr>
                <?php
                   foreach($water_levels as $water_level){
                    echo "
                    <tr>
                        <th>{$water_level['nazwa']}</th>
                        <th>{$water_level['rzeka']}</th>
                        <th>{$water_level['stanOstrzegawczy']}</th>
                        <th>{$water_level['stanAlarmowy']}</th>
                        <th>{$water_level['stanWody']}</th>
                    </tr>";
                   }
                ?>
            </table>
        </section>

        <section class="right">
            <h3>Informacje</h3>
            <ul>
                <li>Brak ostrzeżeń o burzach z gradem</li>
                <li>Smog w mieście Wrocław</li>
                <li>Silny wiatr w Karkonoszach</li>
            </ul>
            <h3>Średni stan wód</h3>
            <!-- SKRYPT 2 -->
            <?php
                foreach($averages as $average){
                    echo "<p>{$average['dataPomiaru']}: {$average['srednia']} </p>";
                }

            ?>  

             <a href="https://komunikaty.pl">Dowiedz się więcej</a>
             <img src="obraz2.jpg" alt="rzeka">
        </section>
    </main>

    <footer>
        <p>Stronę wykonał: 8912383129023ujjniqrew</p>
    </footer>


    <?php
    $link->close();
    ?>
</body>
</html>