<?php
 
  // display errors!
  ini_set('display_errors', 'On');

  // grab provided name from form. 
  $param_password = $_POST['password'];

  // create query 
  $query = "SELECT * FROM Passwords WHERE CurPaasswords = '" . $param_password . "')";
  
  // Create connection
  $con=mysqli_connect("dbase.cs.jhu.edu","cs41513_wangshi","SPO901","cs41513_wangshi_db");
  echo $query . "<br>";
  
  // exec query
  $result = mysqli_query($con,$query);
  

  // Check connection
  if (mysqli_connect_errno($con))
  {
    echo "Failed to connect to MySQL: " . mysql_connect_error();
  }
 
  
  $query = "CALL 

  // close connection
  mysqli_close($con);
?>
