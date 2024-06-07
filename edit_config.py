def search_and_replace(file_path):
   with open(file_path, 'r') as file:
      file_contents = file.read()

      updated_contents = file_contents.replace('\n', ' \\n\\\n')

   with open(file_path, 'w') as file:
      file.write(updated_contents)

# Example usage
file_path = 'paper-world-defaults.yml'
search_and_replace(file_path)