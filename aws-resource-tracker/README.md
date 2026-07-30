# AWS Resource Tracker

A Bash scripting project that automates the monitoring of AWS resources using the AWS CLI.

The script collects information about key AWS services and generates a resource usage report. It was deployed on an Amazon EC2 instance and automated using a cron job to run periodically without manual intervention.

## Features

- Lists Amazon S3 buckets
- Lists Amazon EC2 instances
- Lists AWS Lambda functions
- Lists IAM users
- Generates a resource usage report
- Runs automatically using Cron
- Supports unattended monitoring

## AWS Services Used

- Amazon EC2
- Amazon S3
- AWS Lambda
- AWS IAM
- AWS CLI

## Project Workflow

1. Launch an EC2 instance.
2. Install and configure the AWS CLI.
3. Create the Bash script.
4. Grant execute permission to the script.
5. Test the script manually.
6. Schedule the script using Cron.
7. Verify automatic execution through log files.

## Cron Automation

The script is scheduled using **crontab** to run automatically at regular intervals.

Example:

```bash
5 * * * * /home/ubuntu/tracker.sh >> /home/ubuntu/aws_resource_tracker.log 2>&1
```

The cron job writes the output to a log file, allowing the execution history to be reviewed later. The project also includes verification that the scheduled task runs successfully. :contentReference[oaicite:1]{index=1}

## Requirements

- Linux (Ubuntu/Amazon Linux)
- Bash
- AWS CLI
- Configured AWS credentials
- IAM permissions to access AWS resources

Configure the AWS CLI:

```bash
aws configure
```

## How to Run

Give execute permission:

```bash
chmod +x tracker.sh
```

Run the script:

```bash
./tracker.sh
```

## Sample Output

```
AWS RESOURCE TRACKER

S3 Buckets
...

EC2 Instances
...

Lambda Functions
...

IAM Users
...

Report Generated Successfully
```

## Project Structure

```
aws-resource-tracker/
├── tracker.sh
├── README.md
└── documentation.md
```

## Skills Demonstrated

- Bash Scripting
- AWS CLI
- Amazon EC2
- Amazon S3
- AWS Lambda
- IAM
- Cron Job Automation
- Linux Administration
- Cloud Resource Monitoring

## What I Learned

- Writing Bash automation scripts
- Working with AWS CLI commands
- Querying AWS resources
- Automating tasks with Cron
- Managing permissions and execution
- Monitoring cloud infrastructure
- Troubleshooting AWS CLI and Cron issues

## Future Improvements

- Export reports to CSV or JSON
- Add CloudWatch integration
- Send email notifications
- Include additional AWS services
- Generate resource usage summaries

## Author

**Shaihanath**

This project is part of my Bash scripting, Linux, AWS, and Cloud Automation learning journey.
