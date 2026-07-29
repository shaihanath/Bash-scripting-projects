# GitHub User Listing

A Bash script that uses the GitHub API to list users who have read access to a repository.

## Technologies Used

- Bash
- GitHub API
- curl
- jq

## How It Works

The script:

1. Connects to the GitHub API.
2. Authenticates using a GitHub username and personal access token.
3. Gets the collaborators of a repository.
4. Checks which users have read (pull) access.
5. Displays the users with read access.

## Usage

Set your GitHub username and token:

```bash
export username="your-github-username"
export token="your-github-token"
