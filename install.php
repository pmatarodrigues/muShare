<?php

$dbhost = 'localhost';
$dbuser = 'root';
$dbpass = '';
$dbname = 'muShare';
$conn = mysqli_connect($dbhost, $dbuser, $dbpass);
$file  = "muShare.sql";
$path = "/var/www/html/muShare/";
$filePath = $path + $file;

// 'morre' se nao se conseguir conectar
if(! $conn ) {
    die('Could not connect: ' . mysqli_error());
 }
 echo 'Conectado com sucesso';
 
 // cria base de dados
 $sql = 'CREATE Database test_db';
 $retval = mysqli_query( $conn, $sql);
 
 // 'morre' se nao conseguir criar base de dados
 if(! $retval ) {
    die('Could not create database: ' . mysqli_error());
 }
 echo "Criado com sucesso\n";
 mysqli_close($conn);

 $conn = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
 if(! $conn ) {
    die('Could not connect: ' . mysqli_error());
 }
 echo 'Reconectado com sucesso';
 
function restoreMysqlDB($filePath, $conn)
{
    $sql = '';
    $error = '';
    
    if (file_exists($filePath)) {
        $lines = file($filePath);
        
        foreach ($lines as $line) {
            
            // Ignoring comments from the SQL script
            if (substr($line, 0, 2) == '--' || $line == '') {
                continue;
            }
            
            $sql .= $line;
            
            if (substr(trim($line), - 1, 1) == ';') {
                $result = mysqli_query($conn, $sql);
                if (! $result) {
                    $error .= mysqli_error($conn) . "\n";
                }
                $sql = '';
            }
        } // end foreach
        
        if ($error) {
            $response = array(
                "type" => "error",
                "message" => $error
            );
        } else {
            $response = array(
                "type" => "success",
                "message" => "Restore completado com sucesso"
            );
        }
    } // end if file exists
    return $response;
}

function nodeStart($path){
    $path='~/Projects/SIR2/mShare';
    exec("cd ". $path. " && nodemon bin/www 2>&1", $out, $err);
}

restoreMysqlDB($filePath,$conn);
nodeStart($path);
?>