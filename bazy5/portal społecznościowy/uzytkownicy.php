<?php
$link=new mysqli ('localhost','root','','portal');

$sql = "SELECT COUNT(*) AS liczba
FROM dane";
$result =$link->query($sql);
$number = $result->fetch_assoc();

?>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portal społecznościowy</title>
    <link rel="stylesheet" href="styl5.css">
</head>
<body>
<header>
    <section class="header-left">
        <h2>Nasze osiedle</h2>
    </section>

    <section class="header-right">
    <h5>Licza użytkowników portalu:
        
        <?php
        echo $number['liczba'];
        ?>
    </h5>
    </section>
</header>

<main>
    <section class="left">
        <h3>Logowanie</h3>
        <form action="" method="post">
            <label for="login">Login:</label><br>
            <input type="text" name="login" id="login"><br>
            <label for="password">Hasło:</label><br>
            <input type="password" name="password" id="password"><br>
            <button type="submit">Zaloguj</button>
        </form>
    </section>

    <section class="right">
        <h3>Wizytówka</h3>
        <section class="card">
            <?php
            $login_f = $_POST['login'] ?? NULL;
            $password_f = $_POST['password'] ?? NULL;
            
            // var_dump($login_f);
            if ($login_f && $password_f) {
                $sql = "SELECT haslo
                    FROM uzytkownicy
                    WHERE login = '$login_f'";
                $result = $link->query($sql);
                if ($result->num_rows == 0){
                  echo "login nie istnieje";
            }
                else {
                    // echo "$password_f";
                    // login istnieje
                    $password_d = $result->fetch_assoc();
                    if ($password_d != sha1($password_f)){
                        echo "hasło nieprawidłowe ";
                    }
                    else {
                        // hasła się zgadzają
                        $sql = "SELECT login, rok_urodz, przyjaciol, hobby, zdjecie
                                FROM uzytkownicy INNER JOIN dane ON uzytkownicy.id=dane.id
                                WHERE login = '$login_f'";
                        $result = $link->query($sql);
                        $data = $result->fetch_assoc();
                        $age = date("Y") - $data['rok_urodz'];
                        echo "
                        <img src='{$data['zdjecie']}' alt='osoba'>
            <h4>{$data['login']} ($age)</h4>
            <p>hobby:{hobby}</p>
            <h1><img src='icon-on.png' alt=''>({przyjaciol})</h1>
            <button><a href='dane.html'>więcej informacji</a></button>
                        ";
                    }
                }
            }

            ?>
            <!-- <img src='{zdjecie}' alt='osoba'>
            <h4>{login} ($age)</h4>
            <p>hobby:{hobby}</p>
            <h1><img src='icon-on.png' alt=''>({przyjaciol})</h1>
            <button><a href='dane.html'>więcej informacji</a></button> -->
        </section>
    </section>
</main>

<footer>
    Stronę wykonał: 00000
</footer>
    
</body>
</html>