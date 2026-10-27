<?php
$link=new mysqli ('localhost','root','','antyki');

$buy_f = $_POST['buy'] ?? NULL;
if ($buy_f){
    $sql = "INSERT INTO zakupy (idKlienci, idMeble, sztuk)
            VALUES(1, $buy_f, 1)";
    $result = $link->query($sql);
}

$sql = "SELECT idMeble, nazwa, plik, styl, cena, opis
FROM meble
WHERE kategoria = 1";

$result = $link->query($sql);
$furnitures_1a = $result->fetch_all(1);

$sql = "SELECT idMeble, nazwa, plik, styl, cena, opis
FROM meble
WHERE kategoria = 2";

$result = $link->query($sql);
$furnitures_1b = $result->fetch_all(1);

$sql = "SELECT idMeble, nazwa, plik, styl, cena, opis
FROM meble
WHERE kategoria = 3";

$result = $link->query($sql);
$furnitures_1c = $result->fetch_all(1);

$sql= "SELECT nazwa, cena
FROM meble INNER JOIN zakupy ON meble.idMeble=zakupy.idMeble
WHERE idKlienci = 1";

$result = $link->query($sql);
$basket = $result->fetch_all(1);

?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sprzedaż antyków</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
        <h1>Najlepsze antyki w mieście</h1>
    </header>

    <main>
        <section>
            <h2>-Sofy</h2>
            <!-- SKRYPT 1 wariant 1a -->
             <!-- <div class='mebel'>
                <div class='obraz'>
                    <img src='sofy/{plik}' alt='mebel'>
                </div>
                <div class='informacje'>
                    <h3>{nazwa}</h3>
                    <h4>styl {styl}</h4>
                    <h3>Cena: {cena} zł</h3>

                    <form action='' method='post'>
                        <button value='{idMeble}' name='buy'>KUP</button>
                    </form>
                </div>

                <div class='opis'>
                    {opis}
                </div>
             </div> -->
            <?php
        foreach ($furnitures_1a as $furniture) {
            echo "
                <div class='mebel'>
                    <div class='obraz'>
                        <img src='sofy/{$furniture['plik']}' alt='mebel'>
                    </div>
                    <div class='informacje'>
                        <h3>{$furniture['nazwa']}</h3>
                        <h4>styl {$furniture['styl']}</h4>
                        <h3>Cena: {$furniture['cena']} zł</h3>

                        <form action='' method='post'>
                            <button value='{$furniture['idMeble']}' name='buy'>KUP</button>
                        </form>
                    </div>

                    <div class='opis'>
                        {$furniture['opis']}
                    </div>
                </div>";
        }

            ?>
            <h2>-Fotele-</h2>
            <!-- SKRYPT 2 wariant 1b -->
             <?php
        foreach ($furnitures_1b as $furniture) {
            echo "
                <div class='mebel'>
                    <div class='obraz'>
                        <img src='fotele/{$furniture['plik']}' alt='mebel'>
                    </div>
                    <div class='informacje'>
                        <h3>{$furniture['nazwa']}</h3>
                        <h4>styl {$furniture['styl']}</h4>
                        <h3>Cena: {$furniture['cena']} zł</h3>

                        <form action='' method='post'>
                            <button value='{$furniture['idMeble']}' name='buy'>KUP</button>
                        </form>
                    </div>

                    <div class='opis'>
                        {$furniture['opis']}
                    </div>
                </div>";
        }

            ?>
            <h2>-Komody-</h2>
            <!-- SKRYPT 3 wariant 1c -->
            <?php
        foreach ($furnitures_1c as $furniture) {
            echo "
                <div class='mebel'>
                    <div class='obraz'>
                        <img src='komody/{$furniture['plik']}' alt='mebel'>
                    </div>
                    <div class='informacje'>
                        <h3>{$furniture['nazwa']}</h3>
                        <h4>styl {$furniture['styl']}</h4>
                        <h3>Cena: {$furniture['cena']} zł</h3>

                        <form action='' method='post'>
                            <button value='{$furniture['idMeble']}' name='buy'>KUP</button>
                        </form>
                    </div>

                    <div class='opis'>
                        {$furniture['opis']}
                    </div>
                </div>";
        }

            ?>

            <!-- SKRYPT 2 -->
             

        </section>

        <aside>
            <h2>Koszyk</h2>
            <p>Zalogowano: Anna Kowalska</p>
            <!-- SKRYPT 3 -->
             <!-- <li>{nazwa}, cena: {cena} zł</li> -->
             <?php
                echo "<ol>";
                $total = 0;
                foreach($basket as $position){
                    echo "<li>{$position['nazwa']}, cena: {$position['cena']} zł</li>";
                    $total += $position['cena'];
                }
                echo "</ol>";
                echo "Koszt całkowity: {$total} zł";
             ?>
        </aside>
    </main>

    <footer>
        <p>Stronę wykonał: wnqueqe891</p>
    </footer>
</body>
</html>