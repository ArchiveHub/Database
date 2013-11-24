<?php
 
  // display errors!
  ini_set('display_errors', 'On');
  $param_ssn = $_POST['ssn'];


  if (empty($param_ssn))
  {
    echo "You should input a SSN";
    exit;
  }
  $query = "CALL ShowRawScore('" . $param_ssn . "')"; 

  // Create connection
  $con=mysqli_connect("dbase.cs.jhu.edu","cs41513_yzhan139","VF32AC","cs41513_yzhan139_db");
  
  // exec query
  $result = mysqli_query($con,$query);
  

  // Check connection
  if (mysqli_connect_errno($con))
  {
    echo "Failed to connect to MySQL: " . mysql_connect_error();
  }
  

  $row = mysqli_fetch_array($result);  

?>

  <html>
  <title>Question (a)</title>
  <body>
    <h3>Print a single student's raw score</h3>
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
      </tr>
      <tr>
        <td>
        <?php echo $row['SSN']; ?>
        </td>
        <td>
        <?php echo $row['LName']; ?>
        </td>
        <td>
        <?php echo $row['FName']; ?>
        </td>
        <td>
        <?php echo round($row['HW1'], 2); ?>
        </td>
        <td>
        <?php echo round($row['HW2a'], 2)?>
        </td>
        <td>
        <?php echo round($row['HW2b'], 2) ?>
        </td>
        <td>
        <?php echo round($row['Midterm'], 2) ?>
        </td>
        <td>
        <?php echo round($row['HW3'], 2) ?>
        </td>
        <td>
        <?php echo round($row['FExam'], 2) ?>
        </td>
    </table>
  </body>
</html>
