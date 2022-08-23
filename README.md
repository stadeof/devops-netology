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

# ДЗ по теме "Инструменты Git"
___

1. commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Update CHANGELOG.md
2. tag: v0.12.23
3. Два. 58dcac4b79 ffbcf55817
4. Вывод коммитов с тэгами снизу
``` 
33ff1c03bb960b332be3af2e333462dde88b279e, v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89, [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e, Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf, registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353, website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5, Update CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80, command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed, Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35, Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e, Cleanup after v0.12.23 release
85024d3100126de36331c6982bfaac02cdab9e76, v0.12.23
```
5.  8c928e83589d90a031f811fae52a81be7153e82f
6.  Вывод коммитов ниже
``` 
125eb51dc4 Remove accidentally-committed binary
22c121df86 Bump compatibility version to 1.3.0 for terraform core release (#30988)
35a058fb3d main: configure credentials from the CLI config file
c0b1761096 prevent log output during init
8364383c35 Push plugin discovery down into command package
```
7. 5ac311e2a9, **Martin Atkins**, Wed May 3 16:25:41 2017 -0700