# GitHub User Listing

A Bash scripting project that uses the GitHub REST API to retrieve and display users with read access to a GitHub repository.

The script authenticates using a GitHub Personal Access Token (PAT), queries the GitHub API, filters the response using `jq`, and displays collaborators who have read (`pull`) permission on the specified repository. The documentation also records the EC2 setup, dependency installation, testing, and publishing workflow. :contentReference[oaicite:0]{index=0}

## Features

- Lists users with read access to a GitHub repository
- Uses the GitHub REST API
- Authenticates using a GitHub Personal Access Token (PAT)
- Filters JSON responses using `jq`
- Accepts repository owner and repository name as arguments
- Reusable for any repository the authenticated user can access

## Technologies Used

- Bash
- GitHub REST API
- curl
- jq
- Git
- Linux (Ubuntu)

## Project Workflow

1. Install the required dependencies.
2. Export GitHub username and Personal Access Token as environment variables.
3. Execute the script by providing the repository owner and repository name.
4. The script connects to the GitHub API.
5. Retrieves collaborator information.
6. Displays users who have read access.

## Requirements

- Linux
- Bash
- Git
- curl
- jq
- GitHub Personal Access Token (PAT)

Install the required packages:

```bash
sudo apt update
sudo apt install -y git curl jq
```

## Environment Variables

Export your GitHub credentials before running the script:

```bash
export username="your-github-username"
export token="your-personal-access-token"
```

## How to Run

Give execute permission:

```bash
chmod +x github_user_listing.sh
```

Run the script:

```bash
./github_user_listing.sh <repository_owner> <repository_name>
```

Example:

```bash
./github_user_listing.sh octocat Hello-World
```

## Sample Output

```text
Listing users with read access to octocat/Hello-World...

Users with read access to octocat/Hello-World:
user1
user2
user3
```

## Project Structure

```text
github-user-listing/
├── github_user_listing.sh
├── README.md
└── documentation.md
```

## Skills Demonstrated

- Bash Scripting
- GitHub REST API
- Linux
- Git
- curl
- jq
- API Authentication
- JSON Processing

## What I Learned

- Writing reusable Bash scripts
- Working with REST APIs
- Authenticating using GitHub Personal Access Tokens
- Parsing JSON using `jq`
- Using environment variables for sensitive credentials
- Passing command-line arguments
- Managing scripts with Git and GitHub

## Future Improvements

- Support GitHub Organizations
- Export results to CSV or JSON
- Add error handling for invalid repositories
- Improve permission filtering
- Add support for additional repository permissions

## Author

**Shaihanath**

This project is part of my Bash scripting, Linux, and GitHub API automation learning journey.
