<?php
$link =new mysqli ("localhost", "root", "", "remont");

if (isset($_POST['pracownicy'])){
    $pracownicy = $_POST['pracownicy'];

    $sql = "SELECT nazwa_firmy, liczba_pracownikow
        FROM wykonawcy
        WHERE liczba_pracownikow >= $pracownicy";
    $result = $link->query($sql);
    $companies = $result ->fetch_all(1);
}

$sql = "SELECT DISTINCT miasto
    FROM klienci
    GROUP BY miasto";

$result = $link->query($sql);
$cities = $result->fetch_all(1);

if (isset($_POST['miasto']) && isset($_POST['rodzaj'])){
    $city = $_POST['miasto'];
    $type = $_POST['rodzaj'];

    $sql = "SELECT imie, cena
        FROM klienci INNER JOIN zlecenia ON klienci.id_klienta=zlecenia.id_klienta
        WHERE klienci.miasto = '$city' AND zlecenia.rodzaj = '$type'";

    $result = $link->query($sql);
    $customers = $result->fetch_all(1);
}

?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remonty</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
        <h1>Malowanie i gipsowanie</h1>
    </header>

    <main>
        <nav>
            <a href="kontakt.html">Kontakt</a>
            <a href="https://remonty.pl">Partnerzy</a>
        </nav>

        <section class="left">
            <h2>Dla klientów</h2>
            <form action="" method="post">
                <label for="workers">
                    Ilu conajmniej pracowników potrzebujesz?
                </label>
                <input type="number" name="workers" id="workers">
                <button type="submit">Szukaj firm</button>
                <!-- SKRYPT 1 -->
            </form>
            <?php
                if (isset($_POST['pracownicy'])){
                foreach ($companies as $company){
                    echo "<p>{$company['firma']}, {$company['liczba_pracownikow']}</p>";
                }}
                ?>

        </section>

        <section class="mid">
            <h2>Dla wykonawców</h2>
            <form action="" method="post">
            <select name="city" id="city">
                <!-- SKRYPT 2 -->
            <?php
            foreach ($cities as $city){
                echo "
                <option value='{$city['city']}'>{$city['miasto']}</option>";
            }
            ?>
            </select>

            <input type="radio" name="type" id="type"
            value="malowanie" checked>Malowanie

            <input type="radio" name="type" id="type2"
            value="gipsowanie"> Gipsowanie
            <button type="submit">Szukaj klientów</button>
            </label>
            </form>

            <ul>
                <?php
                if (isset($_POST['miasto']) && isset($_POST['rodzaj'])){
                foreach($customers as $customer){
                echo "
                <li>{$customer['imie']} - {$customer['cena']}</li>";
                }}

                ?>
            </ul>
            
        </section>

        <aside>
            <img src="tapeta_lewa.png" alt="usługi">
            <img src="tapeta_prawa.png" alt="usługi">
            <img src="tepeta_lewa.png" alt="usługi">
        </aside>
        
        
    </main>

    <footer>
        <p>Stronę wykonał: 90wqiu90ewu9032yu1her</p>
    </footer>
    
</body>
</html>

