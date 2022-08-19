# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.5.2"`

```shell
user@home 09:08:48 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role |MNT-13 → origin U:2 ?:1 ✗| →  molecule --version
molecule 4.0.1 using python 3.10 
    ansible:2.12.7
    delegated:4.0.1 from molecule
    docker:2.0.0 from molecule_docker requiring collections: community.docker>=3.0.0-a2
user@home 09:10:28 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role |MNT-13 → origin U:2 ?:1 ✗| → 
```

2. Выполните `docker pull aragast/netology:latest` -  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри

```shell
user@home 08:46:07 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role |MNT-13 → origin U:2 ✗| →  docker pull aragast/netology:latest
latest: Pulling from aragast/netology
f70d60810c69: Pull complete 
545277d80005: Pull complete 
3787740a304b: Pull complete 
8099be4bd6d4: Pull complete 
78316366859b: Pull complete 
a887350ff6d8: Pull complete 
8ab90b51dc15: Pull complete 
14617a4d32c2: Pull complete 
b868affa868e: Pull complete 
1e0b58337306: Pull complete 
9167ab0cbb7e: Pull complete 
907e71e165dd: Pull complete 
6025d523ea47: Pull complete 
6084c8fa3ce3: Pull complete 
cffe842942c7: Pull complete 
Digest: sha256:aa756f858732773c37e443ee13b46b0925bab33775709417e581d99948c08efc
Status: Downloaded newer image for aragast/netology:latest
docker.io/aragast/netology:latest
user@home 08:46:36 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role |MNT-13 → origin U:2 ✗| → 
```

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.

```shell
user@home 08:57:59 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse |MNT-13 → origin U:2 ✗| →  molecule test -s centos_7
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/user/.cache/ansible-compat/7e099f/modules:/home/user/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/user/.cache/ansible-compat/7e099f/collections:/home/user/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/user/.cache/ansible-compat/7e099f/roles:/home/user/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/user/.cache/ansible-compat/7e099f/roles/alexeysetevoi.clickhouse symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > dependency
INFO     Running ansible-galaxy collection install -v --pre community.docker:>=3.0.0-a2
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > lint
/bin/bash: строка 1: yamllint: команда не найдена
/bin/bash: строка 2: ansible-lint: команда не найдена
/bin/bash: строка 3: flake8: команда не найдена
WARNING  Retrying execution failure 127 of: y a m l l i n t   . 
 a n s i b l e - l i n t 
 f l a k e 8 

CRITICAL Lint failed with error code 127
WARNING  An error occurred during the test sequence action: 'lint'. Cleaning up.
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/user/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/user/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
user@home 08:58:22 ~/git_store/mnt-homeworks/08-ansible-05-testing/ansible/roles/clickhouse |MNT-13 → origin U:2 ✗| →
```

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

```shell

```

3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

```shell
sergej@fedora:~/GIT_SORE/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role [±|MNT-13 → origin U:1 ✗|] $ molecule test --driver-name docker
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/sergej/.cache/ansible-compat/f5bcd7/modules:/home/sergej/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/sergej/.cache/ansible-compat/f5bcd7/collections:/home/sergej/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/sergej/.cache/ansible-compat/f5bcd7/roles:/home/sergej/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/sergej/.cache/ansible-compat/f5bcd7/roles/my_namespace.my_role symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/sergej/GIT_SORE/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '172678109756.2319787', 'results_file': '/home/sergej/.ansible_async/172678109756.2319787', 'changed': True, 'item': {'command': '/sbin/init', 'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
[WARNING]: Timeout exceeded when getting mount info for /etc/hosts
[WARNING]: Timeout exceeded when getting mount info for /etc/hostname
[WARNING]: Timeout exceeded when getting mount info for /etc/resolv.conf
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Download Vector distrib] ***********************************
changed: [centos7]

TASK [vector-role : Install Vector packages] ***********************************
changed: [centos7]

TASK [vector-role : Copy Vector config] ****************************************
changed: [centos7]

TASK [vector-role : Vector change systemd unit] ********************************
changed: [centos7]

RUNNING HANDLER [vector-role : Start Vector service] ***************************
fatal: [centos7]: FAILED! => {"changed": false, "cmd": "/bin/systemctl", "msg": "Failed to get D-Bus connection: No such file or directory", "rc": 1, "stderr": "Failed to get D-Bus connection: No such file or directory\n", "stderr_lines": ["Failed to get D-Bus connection: No such file or directory"], "stdout": "", "stdout_lines": []}

NO MORE HOSTS LEFT *************************************************************

PLAY RECAP *********************************************************************
centos7                    : ok=5    changed=4    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

WARNING  Retrying execution failure 2 of: ansible-playbook --inventory /home/sergej/.cache/molecule/vector-role/default/inventory --skip-tags molecule-notest,notest /home/sergej/GIT_SORE/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role/molecule/default/converge.yml
CRITICAL Ansible return code was 2, command was: ['ansible-playbook', '--inventory', '/home/sergej/.cache/molecule/vector-role/default/inventory', '--skip-tags', 'molecule-notest,notest', '/home/sergej/GIT_SORE/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role/molecule/default/converge.yml']
WARNING  An error occurred during the test sequence action: 'converge'. Cleaning up.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
sergej@fedora:~/GIT_SORE/mnt-homeworks/08-ansible-05-testing/ansible/roles/vector-role [±|MNT-13 → origin U:2 ✗|] $ 
```

4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Ссылка на репозиторий являются ответами на домашнее задание. Не забудьте указать в ответе теги решений Tox и Molecule заданий.

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли lighthouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории. В ответ приведите ссылки.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
