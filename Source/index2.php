<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="POST">
        <?php
            echo $_SERVER['PHP_SELF']; 
            echo "Hola.<br>";
        ?>
        CI: <br> <input type="text" name="ci" size="12" value="CI" placeholder="CI"> <br><br> <!-- <p></p> -->
        
        Nombre: <br> <input type="text" name="nombre"> <br><br>
        
        Apellidos: <br>
        <input type="text" name="ci" size="12" placeholder="Paterno">
        <input type="text" name="ci" size="12" placeholder="Materno"> <br><br>
        
        Fecha de Nacimineto: <br>
        <input type="text" name="nac" size="2" placeholder="DD">
        <input type="text" name="nac" size="2" placeholder="MM">
        <input type="text" name="nac" size="2" placeholder="YY"><br><br>

        <input type="submit" name="submit">
    </form>
</body>
</html>