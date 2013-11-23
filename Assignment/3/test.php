<?php

  ini_set('display_errors', 'On');

  //Create connection
  $con = mysqli_connect("dbase.cs.jhu.edu", "cs4513_jbw", "newpass", "cs41513_jbwdb");

  //Check connection
  if (mysqli_connect_errorn($con))
  {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

  $query = "SELECT Fname, Lname FROM Student";

  //exec query
  $result = mysqli_query($con, $query);

  //iterate over results
  while ($row = mysqli_fetch_array($result))
  {
    echo $row['Fanem'] . " " . $row['Lname'] . "<br>";
  }

  mysqli_close($con);
?>
