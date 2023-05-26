// Establish a MySQLi database connection
$mysqli = new mysqli("hostname", "username", "password", "database");

// Assuming the input is stored in a variable called $input
// Prepare the statement
$stmt = $mysqli->prepare("INSERT INTO table (column) VALUES (?)");

// Bind the input parameter
$stmt->bind_param("s", $input);

// Execute the statement
$stmt->execute();

// Close the statement and database connection
$stmt->close();
$mysqli->close();