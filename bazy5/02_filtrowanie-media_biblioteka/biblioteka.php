<?php
$link = new mysqli("localhost","root","","biblio");

?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteka miejska</title>
    <link rel="stylesheet" href="styl.css">
</head>
<body>
    <header>
    <?php
    for ($i = 0; $i<20; $i++){
        echo '<img src="obraz.jpg" alt="">';
    }
    ?>
    </header>

    <main>
       <section class="left">
    <h2>Liryka</h2>

    <form action="biblioteka.php" method="post">
        <label for="liryka"></label>

        <select name="id_ksiazki" id="liryka">
        <?php
        $sql = "SELECT id, tytul 
                FROM ksiazka
                WHERE gatunek = 'liryka'";

        $result = $link->query($sql);

        while ($book = $result->fetch_assoc()){
            echo "<option value='{$book['id']}'>{$book['tytul']}</option>";
        }
        ?>
        </select>

        <button type="submit" name="button_liryka" value="1">
            Rezerwuj
        </button>
    </form>

    <?php
if (isset($_POST['button_liryka'])) {
    $id_ksiazki = (int) $_POST['id_ksiazki'];

    $sql = "SELECT tytul FROM ksiazka
            WHERE id = $id_ksiazki";

    $result = $link->query($sql);
    $book = $result->fetch_assoc();

    if ($book) {
        $sql = "UPDATE ksiazka
                SET rezerwacja = 1
                WHERE id = $id_ksiazki";

        $link->query($sql);

        echo "<p>Książka {$book['tytul']} została zarezerwowana</p>";
    }
}
?>
</section>

<section class="central-left">
    <h2>Epika</h2>

    <form action="biblioteka.php" method="post">
        <label for="epika"></label>

        <select name="id_ksiazki" id="epika">
            <?php
            $sql = "SELECT id, tytul 
                    FROM ksiazka
                    WHERE gatunek = 'epika'";

            $result = $link->query($sql);

            while ($book = $result->fetch_assoc()) {
                echo "<option value='{$book['id']}'>{$book['tytul']}</option>";
            }
?>
        </select>

        <button type="submit" name="button_epika" value="1">
            Rezerwuj
        </button>
    </form>

    <?php
if (isset($_POST['button_epika'])) {
    $id_ksiazki = (int) $_POST['id_ksiazki'];

    $sql = "SELECT tytul FROM ksiazka
            WHERE id = $id_ksiazki";

    $result = $link->query($sql);
    $book = $result->fetch_assoc();

    if ($book) {
        $sql = "UPDATE ksiazka
                SET rezerwacja = 1
                WHERE id = $id_ksiazki";

        $link->query($sql);

        echo "<p>Książka {$book['tytul']} została zarezerwowana</p>";
    }
}
?>
</section>

<section class="central-right">
    <h2>Dramat</h2>

    <form action="biblioteka.php" method="post">
        <label for="dramat"></label>

        <select name="id_ksiazki" id="dramat">
            <?php
            $sql = "SELECT id, tytul 
                    FROM ksiazka
                    WHERE gatunek = 'dramat'";

            $result = $link->query($sql);

            while ($ksiazka = $result->fetch_assoc()) {
                echo "<option value='{$ksiazka['id']}'>{$ksiazka['tytul']}</option>";
}
?>
        </select>

        <button type="submit" name="button_dramat" value="1">
            Rezerwuj
        </button>
    </form>

    <?php
if (isset($_POST['button_dramat'])) {
    $id_ksiazki = (int) $_POST['id_ksiazki'];

    $sql = "SELECT tytul FROM ksiazka
            WHERE id = $id_ksiazki";

    $result = $link->query($sql);
    $book = $result->fetch_assoc();

    if ($book) {
        $sql = "UPDATE ksiazka
                SET rezerwacja = 1
                WHERE id = $id_ksiazki";

        $link->query($sql);

        echo "<p>Książka {$book['tytul']} została zarezerwowana</p>";
    }
}
?>
</section>
    <section class="right">
    <h2>Zaległe książki</h2>

    <ul>
        <?php
        $sql = "SELECT ksiazka.tytul, wypozyczenia.id_cz, wypozyczenia.data_odd
                FROM ksiazka
                INNER JOIN wypozyczenia ON ksiazka.id = wypozyczenia.id_ks
                ORDER BY wypozyczenia.data_odd ASC
                LIMIT 15";

        $result = $link->query($sql);

        while ($row = $result->fetch_assoc()) {
            echo "<li>{$row['tytul']} {$row['id_cz']} {$row['data_odd']}</li>";
        }
        ?>
    </ul>
</section>

    </main>
    
    <footer>
        <p><strong>Autor: 18u923u1238j9</strong></p>
    </footer>
</body>
</html>

<?php
$link->close();
?>