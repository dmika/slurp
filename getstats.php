<?php
    
    $host = "slurphud.net.mysql";
    $user = "slurphud_net";
    $pwd = "fMLEARYa";
    $dbname = "slurphud_net";
    $tblname = "hudinfo";
    
    $con = mysqli_connect("slurphud.net.mysql", $user, $pwd, $dbname);
    if (!$con)
    {
        die("Could not connect: " . mysqli_error($con));
    }
    else
    {
        //get key from parameter
        $uuidkey = $_REQUEST['uuidkey'];
    
        //build query to database
        $query = "SELECT * FROM `$tblname` WHERE uuidkey = '$uuidkey'";
        $result = mysqli_query($con,$query);
            if (!$result)
            {
                echo 'Error: Query ' . mysqli_error($con);
            }
            else
            {
                $row = mysqli_fetch_row($result);
            
                if ($row >= 1)
                {
                    echo $row['rpname'].", ".$row['rpage'].", ".$row['deadoralive'].", ".$row['points'].", ".$row['hunger'].", ".$row['energy'].", ".$row['hygiene'].", ".$row['bladder'].", ".$row['comfort'].", ".$row['fun'];
                }
                else
                {
                    echo ("no_row");                        
                }
            }
        //close connection 
        mysql_close($con);
    }   
?>
