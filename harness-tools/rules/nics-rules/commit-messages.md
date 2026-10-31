# Commit Message format specification
1. Commits MUST be prefixed with a type, which consists of a descriptor from the set specified below, followed by a project reference ID enclosed in parentheses, and REQUIRED terminal colon and space.
2. The set of type descriptors are as follows: 
    - type major MUST be used when a commit adds a new major feature to your application or library.
    - type minor MUST be used when a commit adds a new minor feature to your application or library.
    - type patch MUST be used when a commit adds a new patch to your application or library.
    - type fix MUST be used when a commit represents a bug fix for your application.
3. A type MUST consist of a project reference ID surrounded by parenthesis
    - e.g.  minor(ReReading):
    - if no project reference ID has been specified by the user, you MUST ask for one before committing anything
4. A description MUST immediately follow the colon and space after the type prefix. The description is a short summary of the code changes
    - e.g.  minor(ReReading): array parsing issue when multiple spaces were contained in string.
    - the first line containing the type and short summary must not exceed 72
      characters
5. A longer commit body providing additional contextual information about the code changes MUST be provided after the short description
    - the body MUST begin one blank line after the description.
    - the body MUST wrap each line at 80 characters 
    - the body MUST only describe the changes made in the corresponding commit
    - the body MUST NOT include code references or file paths


# Example commit message:

minor(ReReading): added new note rereading feature

Updated the existing frontend application to inlcude functionality for
displaying a set of randomly selected notes to the user. Strictly frontend
chagnes made. 
