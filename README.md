# Красичков А.В.

## devops-netology homework
___
### .gitignore в каталоге ./terraform/
````
# Local .terraform directories
# Локальные каталоги .terraform
**/.terraform/*

# .tfstate files
# Все файлы с расширением .tfstate и .tfstate.* 
*.tfstate
*.tfstate.*

# Crash log files
# Логи ошибок/падений
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
# Все файлы с расширением .tfvars и .tfvars.json, хранящие пароли, ключи и др.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
# Все файлы с расширениями override.tf, override.tf.json, *_override.tf и *_override.tf.json, используемые локально.
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# Исключить файл шаблона из игнора
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
# Игнорирование конфигурационных файлов  .terraformrc, terraform.rc
.terraformrc
terraform.rc
````
___