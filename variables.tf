# variables.tf
variable "prefix" {
  type        = string
  description = "Префікс для найменування ресурсів (Формат: ім'я-прізвище-варіант)"
  default     = "kalushka-sofia-09"
}

variable "vpc_cidr" {
  description = "CIDR блок для розгортання VPC"
  type        = string
  default     = "10.9.0.0/16"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr))
    error_message = "Помилка: Необхідно вказати валідний IPv4 CIDR блок (наприклад, 10.1.0.0/16)."
  }
}

variable "subnet_a_cidr" {
  type    = string
  default = "10.9.10.0/24"
}

variable "subnet_b_cidr" {
  type    = string
  default = "10.9.20.0/24"
}

variable "web_port" {
  description = "TCP Порт для доступу до вебсервера Apache"
  type        = number
  default     = 8888
  validation {
    condition     = var.web_port >= 1024 && var.web_port <= 65535
    error_message = "Помилка: Порт повинен знаходитись у безпечному непривілейованому діапазоні (1024-65535)."
  }
}

variable "apache_server_name" {
  type    = string
  default = "lab3-web-server"
}

variable "apache_doc_root" {
  type    = string
  default = "/var/www/lab3-site"
}
