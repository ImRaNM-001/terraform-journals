variable "db_sg_id" {
    description = "Security Group ID for the DB Instance"
    type = string
}

variable "priv_sub_5a_id" {
    description = "Private Subnet for the DB Servers"
    type = string
}

variable "priv_sub_6b_id" {
    description = "Private Subnet for the DB Servers"
    type = string
}

variable "db_username" {
    description = "Database username"
    type = string
}

variable "db_password" {
    description = "Database password"
    type = string
}

variable "db_sub_name" {
    description = "Subnet name where the the DB Instance is hosted"
    type = string
    default = "book-shop-db-subnet-a-b"
}

variable "db_name" {
    description = "Database name"
    type = string
    default = "cloudopsbookdb"
}
