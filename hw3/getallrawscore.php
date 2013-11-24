<?php
 
  // display errors!
  ini_set('display_errors', 'On');

  // grab provided name from form. 
  $param_password = $_POST['password'];

  
  $query = "SELECT * FROM Rawscores as R WHERE R.SSN != '0001' AND R.SSN != '0002' AND '".$param_password."' IN (SELECT * FROM Passwords) ORDER BY R.Section asc;"; 

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

?>

<html>
  <title>Question (d)</title>
  <body>
    <h3>Print a full table of raw score of students.</h3>
    <table border="1">
      <tr>
        <th>SSN</th>
        <th>LName</th>
        <th>FName</th>
        <th>Section</th>
        <th>HW1</th>
        <th>HW2a</th>
        <th>HW2b</th>
        <th>Midterm</th>
        <th>HW3</th>
        <th>FExam</th>
      </tr>
<?php
  while ($row = mysqli_fetch_array($result))
  {
    if (array_key_exists("invalid", $row))
    {
      echo "Password is not correct";
      exit;
    }

?>
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
        <?php echo $row['Section']; ?>
        </td>
        <td>
        <?php echo round($row['HW1'], 2)?>
        </td>
        <td>
        <?php echo round($row['HW2a'], 2) ?>
        </td>
        <td>
        <?php echo round($row['HW2b'], 2) ?>
        </td>
        <td>
        <?php echo round($row['Midterm'], 2) ?>
        </td>
        <td>
        <?php echo round($row['HW3'], 2)  ?>
        </td>
        <td>
        <?php echo round($row['FExam'], 2) ?>
        </td>
      </tr>
<?php
  }

  // close connection
  mysqli_close($con);
?>
    </table>
  </body>
</html>
