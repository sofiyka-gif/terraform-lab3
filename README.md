# Terraform Lab 3 - Variant 9

## Опис проєкту
Цей проєкт створює базову інфраструктуру в AWS:
- VPC: 10.9.0.0/16
- Дві підмережі:
  - Subnet A: 10.9.10.0/24 (eu-central-1a)
  - Subnet B: 10.9.20.0/24 (eu-central-1b)
- EC2 інстанс з Apache на порті 8888
- Використання S3 бакету для зберігання Terraform state:
  `tf-state-lab3-kalushka-sofia-09`

## Передумови (Prerequisites)
- AWS акаунт та IAM користувач з ключами доступу
- Встановлений AWS CLI
- Встановлений Terraform v1.5.7 або новіший
- Homebrew (для macOS)
- Git

## Використання Terraform
1. Ініціалізація робочого простору:
```bash
terraform init
