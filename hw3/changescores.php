<?php
 
  // display errors!
  ini_set('display_errors', 'On');

  // grab provided name from form. 
  $param_password = $_POST['password'];
  $param_ssn = $_POST['ssn'];
  $param_score = $_POST['score'];

  // create query 
  $query = "CALL ChangeScores('" . $param_password . "', '" . $param_ssn . "', 'Midterm', '" . $param_score . "')";

  if (empty($param_ssn) or empty($param_score))
  {
    echo "You should input all the required input";
    exit;
  }

  if (!is_numeric($param_score))
  {
    echo "The score should be a number";
    exit;
  }
  
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
 
  $row = mysqli_fetch_array($result);

  if (array_key_exists("invalid password", $row))
  {
    echo "Password is not correct";
  }
  else if (array_key_exists("invalid ssn", $row))
  {
    echo "Invalid SSN";
  }
  else if (array_key_exists("invalid score", $row))
  {
    echo "Invalid score";
  }
  else 
  {
    echo "update sccuess";
  }

?>

