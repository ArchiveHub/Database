<?php
 
  // display errors!
  ini_set('display_errors', 'On');

  // grab provided name from form. 
  $param_ssn = $_POST['ssn'];

  // create query 
  $query = "CALL ShowPercentages('" . $param_ssn . "');";

  if (empty($param_ssn))
  {
    echo "You should input a SSN";
    exit;
  }
  
  // Create connection
  $con=mysqli_connect("dbase.cs.jhu.edu","cs41513_wangshi","SPO901","cs41513_wangshi_db");
  echo $query . "<br>";
  
  // exec query
  $result = mysqli_multi_query($con,$query);

  // Check connection
  if (mysqli_connect_errno($con))
  {
    echo "Failed to connect to MySQL: " . mysql_connect_error();
  }
 
  
  // iterate over results
  $result = mysqli_store_result($con);
  while ($row = mysqli_fetch_array($result))
  {
    #echo $row['SSN'] . " " . $row['HW1'] . " " . $row['HW2a'] . "<br>";
    $percentage_array = $row;
  }

  mysqli_next_result($con);
  $result = mysqli_store_result($con);
  while ($row = mysqli_fetch_array($result))
  {
    #echo $row['FName'] . " " . $row['LName'] . " " . $row['CumAvg'] . "<br>";
    $weight_array = $row;
  }
  // close connection
  mysqli_close($con);
?>

<html>
  <title>Question (b)</title>
  <body>
    <h3>Print a single student's percentage scores and wieghted average</h3>
    <table border="1">
      <tr>
        <th>SSN</th>
        <th>LName</th>
        <th>FName</th>
        <th>HW1</th>
        <th>HW2a</th>
        <th>HW2b</th>
        <th>Midterm</th>
        <th>HW3</th>
        <th>FExam</th>
        <th>CumAvg</th>
      </tr>
      <tr>
        <td>
        <?php echo $percentage_array['SSN']; ?>
        </td>
        <td>
        <?php echo $weight_array['LName']; ?>
        </td>
        <td>
        <?php echo $weight_array['FName']; ?>
        </td>
        <td>
        <?php echo round($percentage_array['HW1'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($percentage_array['HW2a'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($percentage_array['HW2b'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($percentage_array['Midterm'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($percentage_array['HW3'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($percentage_array['FExam'], 2) . "%"; ?>
        </td>
        <td>
        <?php echo round($weight_array['CumAvg'], 2) . "%"; ?>
        </td>
    </table>
  </body>
</html>
  
