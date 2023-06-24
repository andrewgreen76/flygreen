# The regular expression for capturing just the file extension of a filename can be written as follows:

#```regex
\.[^.]+$

#```

#Here's a breakdown of the regular expression:
#- `\.` matches a literal dot character, which is the start of the file extension.
#- `[^.]+` matches one or more characters that are not a dot, representing the file extension itself.
#- `$` asserts the end of the string, ensuring there are no characters after the file extension.

#Here's an example of how you can use this regular expression in Bash to capture the file extension:

#```bash
filename="example.txt"
if [[ $filename =~ \.([^./]+)$ ]]; then
    extension="${BASH_REMATCH[1]}"
    echo "File extension: $extension"
fi
#```

#In this example, the regular expression is used with the `=~` operator in a Bash `[[` conditional expression. The captured file extension is stored in the `BASH_REMATCH` array, specifically `BASH_REMATCH[1]`, which represents the captured group within the parentheses. The code then echoes the file extension.

