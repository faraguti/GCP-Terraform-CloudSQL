##############################################################
##                                                          ##
##                     MySQL Instance #1                    ##
##                                                          ##
##############################################################

## Define a Google Cloud SQL database instance for MySQL.
resource "google_sql_database_instance" "mysql_instance_1" {
  name             = "mysql-faraguti-development-db1-instance"
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

# Define a MySQL database within the created instance.
resource "google_sql_database" "mysql_database_1" {
  name     = "mysql-faraguti-development-db1"
  instance = google_sql_database_instance.mysql_instance_1.name
}

# Create a MySQL user for database access.
resource "google_sql_user" "user1" {
  name     = "mysql-development-user"
  instance = google_sql_database_instance.mysql_instance_1.name
  password = "password"
}


##############################################################
##                                                          ##
##                  PostGreSQL Instance #1                  ##
##                                                          ##
##############################################################

## Define a Google Cloud SQL database instance for PostgreSQL.
resource "google_sql_database_instance" "postgres_instance_1" {
  name             = "postgres-faraguti-development-db1-instance"
  region           = "us-central1"
  database_version = "POSTGRES_15"
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

## Define a PostgreSQL database within the created instance.
resource "google_sql_database" "postgres_database_1" {
  name     = "postgres-faraguti-development-db1"
  instance = google_sql_database_instance.postgres_instance_1.name
}

## Create a PostgreSQL user for database access.
resource "google_sql_user" "userpg1" {
  name     = "postgres-development-user"
  instance = google_sql_database_instance.postgres_instance_1.name
  password = "password"
}
