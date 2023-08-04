<p align="center">
  <img src="https://github.com/faraguti/Terraform-Website-S3/assets/5418256/6db52534-33ee-4edd-99ef-db5468e7390d" height="100%" width="100%">
</p>

# Cloud Database Deployment with Terraform on GCP

This Terraform project demonstrates how to deploy MySQL and PostgreSQL database instances on Google Cloud Platform (GCP). Each section below explains the different components and steps involved.

## Table of Contents

- [MySQL Instance Deployment](#mysql-instance-deployment)
- [PostgreSQL Instance Deployment](#postgresql-instance-deployment)
- [Usage](#usage)
- [Notes](#notes)

## MySQL Instance Deployment

### Step 1: Provider Configuration

The `provider.tf` file configures the Google Cloud provider settings for the project, including the project ID, region, and zone.

### Step 2: MySQL Instance Setup

In the following block, a Google Cloud SQL instance for MySQL is defined using the `google_sql_database_instance` resource. Key settings include:

- Instance Name: `mysql_instance_1`
- Region: `us-central1`
- Database Version: `MYSQL_8_0`
- Deletion Protection: `false`
- Instance Tier: `db-f1-micro`

**MySQL Instance Block**
```
resource "google_sql_database_instance" "mysql_instance_1" {
  name             = "mysql-goncalves-development-db1-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  deletion_protection  = "false"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
        authorized_networks {
            name            = "Allowed Network"
            value           = "0.0.0.0/0"
            }
        }
    }
}

```

- The `authorized_networks` setting in the instance configurations allows you to specify which IP addresses are allowed to connect to your database instances. In the provided code, `0.0.0.0/0` is used to allow connections from any IP address. This is often convenient for testing and initial setup, but **extremely insecure for production environments**. It essentially means any IP can potentially access your database.

> [!IMPORTANT]  
> **In real-world scenarios, you should always restrict access by providing a list of trusted IP addresses, subnets, or using other methods like Cloud VPN or Cloud Identity-Aware Proxy (IAP) to ensure that only authorized entities can connect to your databases.
>
> Make sure to follow best practices for managing secrets, such as using environment variables or external secret management tools. Storing sensitive data like passwords directly in code can lead to security vulnerabilities.**

<br></br>
### Step 3: MySQL Database Creation

The `google_sql_database` resource defines a MySQL database (`mysql-goncalves-development-db1`) within the previously created instance.

### Step 4: MySQL User Setup

A MySQL user named `mysql-development-user` is created using the `google_sql_user` resource, associated with the MySQL instance. The user is given the password `password` for database access.

## PostgreSQL Instance Deployment

### Step 1: Provider Configuration

Similar to MySQL, the `provider.tf` file configures the Google Cloud provider settings for the PostgreSQL section.

### Step 2: PostgreSQL Instance Setup

In this section, a Google Cloud SQL instance for PostgreSQL is defined using the `google_sql_database_instance` resource. Key settings include:

- Instance Name: `postgres_instance_1`
- Region: `us-central1`
- Database Version: `POSTGRES_15`
- Deletion Protection: `false`
- Instance Tier: `db-f1-micro`

### Step 3: PostgreSQL Database Creation

The `google_sql_database` resource defines a PostgreSQL database (`postgres-goncalves-development-db1`) within the created instance.

### Step 4: PostgreSQL User Setup

A PostgreSQL user named `postgres-development-user` is created using the `google_sql_user` resource, associated with the PostgreSQL instance. The user is assigned the password `password` for database access.

## Usage

1. Clone the repository and navigate into it.
2. Set up Google Cloud credentials and configure the project in `provider.tf`.
3. Run `terraform init` to initialize the project.
4. Run `terraform plan` to preview changes.
5. Run `terraform apply` to deploy the database instances.
6. Access the databases using the created users.

## Notes

- The `authorized_networks` setting allows connections from any IP address. Adjust this for security.
- Make sure to follow best practices for managing secrets, such as using environment variables or external secret management tools.

