<html>
    <body>
        <pre>
            <?php
                $myfile = fopen("index.php", "r") or die("unable to open file");
                echo fread($myfile, filesize("index.php"));
                fclose($myfile);
            ?>
        </pre>
    </body>
</html>
