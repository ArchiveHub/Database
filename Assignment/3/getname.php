<?php
 
  // display errors!
  ini_set('display_errors', 'On');

  // grab provided name from form. 
  $param_name = $_POST['name'];

  // create query 
  $query = "SELECT Fname,Lname FROM Rawscores WHERE Fname='" . $param_name . "'";
  
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
 
  
  // iterate over results
  while ($row = mysqli_fetch_array($result))
  {
    echo $row['Fname'] . " " . $row['Lname'] . "<br>";
  }

  // close connection
  mysqli_close($con);
?>
