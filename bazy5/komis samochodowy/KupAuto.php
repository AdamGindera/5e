<?php
$link=new mysqli ('localhost','root','','komis_samochodowy');

$sql = "SELECT model, rocznik, przebieg, paliwo, cena, zdjecie
FROM samochody
WHERE id = 10";
$result = $link->query($sql);
$offer = $result->fetch_assoc();

$sql = "SELECT nazwa, model, rocznik, cena, zdjecie
FROM marki INNER JOIN samochody ON marki.id=samochody.marki_id
WHERE wyrozniony = 1";
$result = $link->query($sql);
$proposals = $result->fetch_all(1);

$sql = "SELECT nazwa
FROM marki";
$result = $link->query($sql);
$brands = $result->fetch_all(1);


// TABLICA $_POST, bo tutaj wybiera użytkownik
$brand_f = $_POST['brand'] ?? NULL;
if ($brand_f) {
    $sql = "SELECT nazwa, cena, zdjecie
        FROM marki INNER JOIN samochody ON marki.id=samochody.marki_id
        WHERE nazwa = '$brand_f'";
    $result = $link->query($sql);
    $models = $result->fetch_all(1);
}
?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Komis aut</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
        <h1><em>KupAuto!</em> Internetowy Komis Samochodowy</h1>
    </header>
    
    <main>
        <section class="deal_of_the_day">
            <!-- SELECT model, rocznik, przebieg, paliwo, cena, zdjecie -->
            <!-- <img src='{zdjecie}' alt='oferta dnia'>
            <h4>Oferta dnia: Toyota {model}</h4> 

            <p>
                Rocznik: {rocznik}, 
                Przebieg: {przebieg},
                Rodzaj paliwa: {paliwo}
            </p>

            <h4>Cena: {cena}</h4> -->
            <?php
            echo "
            <img src='{$offer['zdjecie']}' alt='oferta dnia'>
            <h4>Oferta dnia: Toyota {$offer['model']}</h4> 

            <p>
                Rocznik: {$offer['rocznik']}, 
                Przebieg: {$offer['przebieg']},
                Rodzaj paliwa: {$offer['paliwo']}
            </p>

            <h4>Cena: {$offer['cena']}</h4>
            ";

            ?>
        </section>

        <section class="premium_offers">
            <h2>Oferty wyróżnione: </h2>
            <div class="flex">
                <!-- SKRYPT 2 -->
                 <!-- SELECT nazwa, model, rocznik, cena, zdjecie -->
                    <!-- <img src="zdjecie" alt="model">
                    <h4>{nazwa}, {model}</h4>
                    <p>Rocznik: {rocznik}</p>
                    <h4>Cena: {cena}</h4> -->
                 <?php
                    foreach ($proposals as $proposal) {
                    echo "
                    <div class='card'>
                        <img src='{$proposal['zdjecie']}' alt='model'>
                        <h4>{$proposal['nazwa']}, {$proposal['model']} </h4>
                        <p>Rocznik: {$proposal['rocznik']} </p>
                        <h4>Cena: {$proposal['cena']} </h4>
                    </div>
                    ";
                    }
                 ?>
            </div>
            
        </section>

        <section class="brand">
            <h2>Wybierz markę: </h2>
            <form action="" method="post">
                <select name="brand" id="">
                    <option value="">Wybierz markę: </option>
                    <!-- SKRYPT 3 -->
                     <!-- <option value='nazwa'>
                        {nazwa}
                     </option> -->
                     <?php
                     foreach ($brands as $brand){
                        echo "
                        <option value={$brand['nazwa']}>
                        {$brand['nazwa']}
                        </option>
                        ";
                     }
                     ?>
                </select>
            <button type="submit">Wyszukaj</button>
            </form>

            <div class="flex">
                <!-- SKRYPT 4 -->
                <!-- <img src='{zdjecie}' alt='{model}'>
                <h4>{nazwa}, {model}</h4>
                <h4>Cena: {cena}</h4> -->
                <?php
                if (isset($_POST['brand']) && $_POST['brand']){
                    foreach($models as $model){
                    echo "
                    <div class='card'>
                    <img src='{$model['zdjecie']}' alt='{$model['nazwa']}'>
                    <h4>{$model['nazwa']}, {$model['nazwa']}</h4>
                    <h4>Cena: {$model['cena']}</h4>
                    </div>
                    ";
                }}
                ?>
            </div>
        </section>
    </main>

    <footer>
        <p>Stronę wykonał: 182731837213uwdqhjqw</p>
        <p><a href="http://firmy.pl/komis">Znajdź nas także</a></p>
    </footer>
</body>
</html>

<?php
$link->close();
?>