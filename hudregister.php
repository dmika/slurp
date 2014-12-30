<?php
    $host = "slurphud.net.mysql";    
    $user = "slurphud_net"; // replace your user name within the 2x "
    $pass = "fMLEARYa"; // replace your password within the 2x "
    $dbname = "slurphud_net"; // replace the database name within the 2x "
    $tblname = "hudinfo"; // replace the table name within the 2x "



    $uuidkey = $_POST["uuidkey"];
    $firstname = $_POST["firstname"];
    $lastname = $_POST["lastname"];
        
    $con = mysqli_connect("slurphud.net.mysql", $user, $pass, $dbname);
    if (!$con)
    {
        die("Not connected : " . mysqli_error($con));
    }
    else
    {
        $query = "SELECT * FROM `$tblname` WHERE uuidkey = '$uuidkey'";
        $result = mysqli_query($con,$query);
        if (!$result)
        {
            echo 'Could not run query: ' . mysqli_error($con);
        }
        else
        {
            $row = mysqli_fetch_row($result);
            
            if ($row >= 1)
            {
                echo ("key_in_list");
            }
            else
            {
                $query = "
                        INSERT INTO `$dbname`.`$tblname` (
                        `uuidkey` ,
                        `firstname` ,
                        `lastname`                            
                        )
                        VALUES (
                        '$uuidkey', '$firstname', '$lastname'
                        )";                    
                $result = mysqli_query($con,$query);
                echo ("new_key_added");                        
            }
        }
        mysqli_close($con);                        
    }
?>
