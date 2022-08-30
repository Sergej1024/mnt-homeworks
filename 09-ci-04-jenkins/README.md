# Домашнее задание к занятию "09.04 Jenkins"

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.
2. Установить jenkins при помощи playbook'a.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

<details><summary>Результат выполнения</summary>
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/start_jenkins.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/start_jenkins2.png)
</details>

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

```shell
[centos@jenkins-master-01 ~]$ sudo su jenkins
[jenkins@jenkins-master-01 centos]$ cd ~
[jenkins@jenkins-master-01 ~]$ git ls-remote -h git@github.com:Sergej1024/Vector-role.git HEAD
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
ECDSA key fingerprint is MD5:7b:99:81:1e:4c:91:a5:0d:5a:2e:2e:80:13:3f:24:ca.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,140.82.121.4' (ECDSA) to the list of known hosts.
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
[jenkins@jenkins-master-01 ~]$ 
```
<details><summary>Результат выполнения</summary>
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/jenkins.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/jenkins1.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/jenkins2.png)
</details>

2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

<details><summary>Результат выполнения</summary>
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/declarat1.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/declarat2.png)
</details>

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.

<details><summary>Результат выполнения</summary>
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/multibranch.png)
</details>

5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).

<details><summary>Результат выполнения</summary>
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/image/scripted.png)
</details>

6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

[Jenkinsfile](https://github.com/Sergej1024/Vector-role/tree/main)

[ScriptedJenkinsfile](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-04-jenkins/src/ScriptedJenkinsfile)
