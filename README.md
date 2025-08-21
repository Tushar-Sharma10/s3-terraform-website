# Terraform AWS S3 Static Website

This project demonstrates how to host a **static website on AWS S3** using **Terraform**. It includes bucket configuration, public access, versioning, encryption, and uploading multiple website files dynamically.

> ⚠️ Note: This is a **beginner-friendly project**. Some values (like bucket name and file paths) are **hardcoded** for simplicity. Future improvements will include dynamic variables, CDN integration, and other advanced features.

## Features

- Creates an **S3 bucket** with:
  - Versioning enabled
  - Public access block configured
  - Server-side encryption (AES-256)
- Configures **bucket policy** to allow public read access
- Uploads website files (`index.html` and `error.html`) using Terraform `for_each`
- Sets correct **content type** (`text/html`) so HTML files render in browsers
- Configures **S3 website hosting** with index and error documents
- Provides **website URL** as Terraform output

## Prerequisites

- Terraform >= 0.14
- AWS CLI installed and configured with valid credentials
- Basic knowledge of AWS S3 and Terraform

## Project Structure

├── main.tf # Terraform configuration file

├── index.html # Main website file

├── error.html # Error page

├── README.md # Project documentation

└── .gitignore # Git ignore file

## Usage

1. **Clone the repository**

git clone https://github.com/YourUsername/s3-terraform-website.git
cd s3-terraform-website

2. **Initialize Terraform**

Terraform init

3. **Apply the terraform plan**

terrform apply

4. **Access the website**

terraform will output the url


## Notes

Some values (like bucket name and file names) are hardcoded for beginner learning purposes.

## Future improvements will include:

1.) Parameterizing variables

2.) Adding CDN for faster content delivery

3.) Advanced security settings
