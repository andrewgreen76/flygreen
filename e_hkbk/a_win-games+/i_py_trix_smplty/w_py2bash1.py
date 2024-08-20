import subprocess

# Execute a Bash command
result = subprocess.run(['ls', '-l'], capture_output=True, text=True)

# Print the command output
print(result.stdout)
