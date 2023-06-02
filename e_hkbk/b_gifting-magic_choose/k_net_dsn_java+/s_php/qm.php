
$input = $_POST['user_input']; // Assume user input from a form
$escaped_input = mysql_real_escape_string($input);
$query = "SELECT * FROM users WHERE username='$escaped_input'";
// Use the escaped input in the query

