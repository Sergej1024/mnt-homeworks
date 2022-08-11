# Домашнее задание к занятию "8.4 Работа с Roles"

## Подготовка к выполнению
1. (Необязательно) Познакомтесь с [lighthouse](https://youtu.be/ymlrNlaHzIY?t=929)
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю в github.

## Основная часть

Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для clickhouse, vector и lighthouse и написать playbook для использования этих ролей. Ожидаемый результат: существуют три ваших репозитория: два с roles и один с playbook.

1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.11.0"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачать себе эту роль.

```bash
sergej@fedora:~/GIT_SORE/mnt-homeworks/08-ansible-04-role/ansible [±|MNT-13 → origin ✓|] $ ansible-galaxy install -r requirements.yml -p roles
```
![]()
3. Создать новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.

```bash
sergej@fedora:~/GIT_SORE $ ansible-galaxy role init Vector-role
```
![]()
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Описать в `README.md` обе роли и их параметры.
7. Повторите шаги 3-6 для lighthouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию Добавьте roles в `requirements.yml` в playbook.
```yml
---
- src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
  scm: git
  version: "1.11.0"
  name: clickhouse 
- src: git@github.com:Sergej1024/Vector-role.git
  scm: git
  version: "1.0.0"
  name: vector-role
- src: git@github.com:Sergej1024/Lighthouse-role.git
  scm: git
  version: "1.0.0"
  name: lighthouse-role
```
9. Переработайте playbook на использование roles. Не забудьте про зависимости lighthouse и возможности совмещения `roles` с `tasks`.
```yml
---
- name: Install Clickhouse
  hosts: clickhouse
  remote_user: centos
  roles:
    - clickhouse

- name: Install Vector
  hosts: vector
  remote_user: centos
  roles:
    - vector-role

- name: Install lighthouse
  hosts: lighthouse
  remote_user: centos
  roles:
    - lighthouse-role
   
```
10. Выложите playbook в репозиторий.
11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

[Ссылка на Vector-role]:(https://github.com/Sergej1024/Vector-role)
[Ссылка на Lighthouse-role]:(https://github.com/Sergej1024/Lighthouse-role)
