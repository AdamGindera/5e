<?php
$link=new mysqli ('localhost','root','','hurtownia');

$sql = "SELECT zdjecie, imie, opinia
FROM klienci INNER JOIN opinie ON klienci.id=opinie.klienci_id
WHERE typy_id IN (2,3)";

$result = $link->query($sql);
$opinie = $result->fetch_all(1);

$sql= "SELECT imie, nazwisko, punkty
FROM klienci
ORDER BY punkty desc
LIMIT 3";

$result = $link->query($sql);
$points = $result->fetch_all(1);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="styl3.css">
</head>
<body>
    <header>
        <h1>Hurtownia spożywcza</h1>
    </header>
    
    <main>
        <h2>Opinie naszych klientów</h2>

    <?php
    foreach($opinie as $opinia) {
        echo '<div class="opinia">';
        echo '<img src="' . $opinia['zdjecie'] . '" alt="klient">';
        echo '<blockquote>' . $opinia['opinia'] . '</blockquote>';
        echo '<h4>' . $opinia['imie'] . '</h4>';
        echo '</div>';
    }
    ?>
    </main>
    <footer>

    <section class="footer">
        <h3>Współpracuję z nami</h3>
        <a href="http://sklep.pl/">Sklep 1</a>
    </section>

    <section class="footer">
        <h3>Nasi top klienci</h3>
        <ol>
            <?php
            foreach($points as $point) {
            echo "<li>";
            echo $point['imie'] . '';
            echo $point['nazwisko'] . '';
            echo $point['punkty'] . ' pkt.';
            echo '</li>';
            }
            ?>
        </ol>
    </section>

    <section class="footer">
        <h3>Skontaktuj się</h3>
        <p>telefon 111222333</p>
    </section>

    <section class="footer">
        <h3>Autor: qwhebqgeh781</h3>
    </section>
    </footer>


    
</body>
</html>