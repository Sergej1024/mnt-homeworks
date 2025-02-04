# Домашнее задание к занятию "08.04 Создание собственных modules"

## Подготовка к выполнению
1. Создайте пустой публичных репозиторий в любом своём проекте: `my_own_collection`
2. Скачайте репозиторий ansible: `git clone https://github.com/ansible/ansible.git` по любому удобному вам пути
3. Зайдите в директорию ansible: `cd ansible`
4. Создайте виртуальное окружение: `python3 -m venv venv`
5. Активируйте виртуальное окружение: `. venv/bin/activate`. Дальнейшие действия производятся только в виртуальном окружении
6. Установите зависимости `pip install -r requirements.txt`
7. Запустить настройку окружения `. hacking/env-setup`
8. Если все шаги прошли успешно - выйти из виртуального окружения `deactivate`
9. Ваше окружение настроено, для того чтобы запустить его, нужно находиться в директории `ansible` и выполнить конструкцию `. venv/bin/activate && . hacking/env-setup`

## Основная часть

Наша цель - написать собственный module, который мы можем использовать в своей role, через playbook. Всё это должно быть собрано в виде collection и отправлено в наш репозиторий.

1. В виртуальном окружении создать новый `my_own_module.py` файл
2. Наполнить его содержимым:
```python
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_test

short_description: This is my test module

# If this is part of a collection, you need to use semantic versioning,
# i.e. the version is of the form "2.5.0" and not "2.4".
version_added: "1.0.0"

description: This is my longer description explaining my test module.

options:
    name:
        description: This is the message to send to the test module.
        required: true
        type: str
    new:
        description:
            - Control to demo if the result of this module is changed or not.
            - Parameter description can be a list as well.
        required: false
        type: bool
# Specify this value according to your collection
# in format of namespace.collection.doc_fragment_name
extends_documentation_fragment:
    - my_namespace.my_collection.my_doc_fragment_name

author:
    - Your Name (@yourGitHubHandle)
'''

EXAMPLES = r'''
# Pass in a message
- name: Test with a message
  my_namespace.my_collection.my_test:
    name: hello world

# pass in a message and have changed true
- name: Test with a message and changed output
  my_namespace.my_collection.my_test:
    name: hello world
    new: true

# fail the module
- name: Test failure of the module
  my_namespace.my_collection.my_test:
    name: fail me
'''

RETURN = r'''
# These are examples of possible return values, and in general should use other names for return values.
original_message:
    description: The original name param that was passed in.
    type: str
    returned: always
    sample: 'hello world'
message:
    description: The output message that the test module generates.
    type: str
    returned: always
    sample: 'goodbye'
'''

from ansible.module_utils.basic import AnsibleModule


def run_module():
    # define available arguments/parameters a user can pass to the module
    module_args = dict(
        name=dict(type='str', required=True),
        new=dict(type='bool', required=False, default=False)
    )

    # seed the result dict in the object
    # we primarily care about changed and state
    # changed is if this module effectively modified the target
    # state will include any data that you want your module to pass back
    # for consumption, for example, in a subsequent task
    result = dict(
        changed=False,
        original_message='',
        message=''
    )

    # the AnsibleModule object will be our abstraction working with Ansible
    # this includes instantiation, a couple of common attr would be the
    # args/params passed to the execution, as well as if the module
    # supports check mode
    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    # if the user is working with this module in only check mode we do not
    # want to make any changes to the environment, just return the current
    # state with no modifications
    if module.check_mode:
        module.exit_json(**result)

    # manipulate or modify the state as needed (this is going to be the
    # part where your module will do what it needs to do)
    result['original_message'] = module.params['name']
    result['message'] = 'goodbye'

    # use whatever logic you need to determine whether or not this module
    # made any modifications to your target
    if module.params['new']:
        result['changed'] = True

    # during the execution of the module, if there is an exception or a
    # conditional state that effectively causes a failure, run
    # AnsibleModule.fail_json() to pass in the message and the result
    if module.params['name'] == 'fail me':
        module.fail_json(msg='You requested this to fail', **result)

    # in the event of a successful module execution, you will want to
    # simple AnsibleModule.exit_json(), passing the key/value results
    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```
Или возьмите данное наполнение из [статьи](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general.html#creating-a-module).

3. Заполните файл в соответствии с требованиями ansible так, чтобы он выполнял основную задачу: module должен создавать текстовый файл на удалённом хосте по пути, определённом в параметре `path`, с содержимым, определённым в параметре `content`.

```python
#!/usr/bin/python

# Copyright: (c) 2018, Terry Jones <terry.jones@example.org>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
import os
from fileinput import filename
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_module

short_description: This is my test module for netology

version_added: "1.0.0"

description: Тестовый модуль для netology, который создаёт файл по пути path, с именем filename и содержимым content.

options:
    path:
        description: Путь к файлу.
        required: true
        type: path
    content:
        description: Содержание файла.
        required: true
        type: str
    filename:
        description: Имя файла.
        required: false
        type: str
        default: file
extends_documentation_fragment:
    - my_own_collection.my_own_module_doc
author:
    - Rozum Sergey
'''

EXAMPLES = r'''
# Create file
- name: Test with a file create
  my_own_collection.my_own_modul.my_own_module::
    path: ./
    content: test content
# Create file with filename new_filename
- name: Test with a file create
  my_own_collection.my_own_modul.my_own_module::
    path: /home/ansible
    content: test
    filename: test_file
'''

RETURN = r'''
# These are examples of possible return values.
msg:
    description: The output message.
    type: str
    returned: always
'''

from ansible.module_utils.basic import AnsibleModule, os


def run_module():
    module_args = dict(
        path=dict(type='path', required=True, aliases=['dest']),
        content=dict(type='str', required=True),
        filename=dict(type='str', required=False, default='file', aliases=['name'])
    )

    result = dict(
        changed=False,
        msg='File created'
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=False
    )


    fullname = os.path.join(module.params['path'], module.params['filename'])

    if os.path.isfile(fullname) and open(fullname, "r").read() == module.params['content']:
        module.exit_json(**result)
    else:
        try:
            with open(fullname, "w") as f:
                f.write(module.params['content'])
        except IOError as e:
            module.fail_json(msg=f"ERROR: {e.strerror}")

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
```

4. Проверьте module на исполняемость локально.

```shell
user@home 10:45:07 ~/git_store/my_own_collection/ansible |devel ?:3 ✗| →  python -m ansible.modules.my_own_module test_file.json 

{"changed": false, "msg": "File created", "invocation": {"module_args": {"path": "/home/user", "content": "hello world", "filename": "file"}}}
```

5. Напишите single task playbook и используйте module в нём.

```shell
user@home 10:53:38 ~/git_store/my_own_collection/ansible |devel ?:4 ✗| →  ansible-playbook site.yml 

PLAY [localhost] ************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [localhost]

TASK [Test with a file create] **********************************************************************************************************************************************************************
ok: [localhost]

PLAY RECAP ******************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

user@home 10:54:37 ~/git_store/my_own_collection/ansible |devel ?:4 ✗| →  
```

6. Проверьте через playbook на идемпотентность.

```shell
user@home 10:54:37 ~/git_store/my_own_collection/ansible |devel ?:4 ✗| →  ansible-playbook site.yml 

PLAY [localhost] ************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [localhost]

TASK [Test with a file create] **********************************************************************************************************************************************************************
ok: [localhost]

PLAY RECAP ******************************************************************************************************************************************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

user@home 10:55:46 ~/git_store/my_own_collection/ansible |devel ?:4 ✗| →  
```

7. Выйдите из виртуального окружения.
8. Инициализируйте новую collection: `ansible-galaxy collection init my_own_namespace.yandex_cloud_elk`
9. В данную collection перенесите свой module в соответствующую директорию.
10. Single task playbook преобразуйте в single task role и перенесите в collection. У role должны быть default всех параметров module
11. Создайте playbook для использования этой role.
12. Заполните всю документацию по collection, выложите в свой репозиторий, поставьте тег `1.0.0` на этот коммит.
13. Создайте .tar.gz этой collection: `ansible-galaxy collection build` в корневой директории collection.
14. Создайте ещё одну директорию любого наименования, перенесите туда single task playbook и архив c collection.
15. Установите collection из локального архива: `ansible-galaxy collection install <archivename>.tar.gz`
16. Запустите playbook, убедитесь, что он работает.
17. В ответ необходимо прислать ссылку на репозиторий с collection

[Репозиторий с коллекцией](https://github.com/Sergej1024/my_own_collection)

## Исправления

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-06-module/img/modul1.png)

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-06-module/img/modul2.png)
Проверил на чужом репозитории найденом в интернете, тем способом что вы проверяите оно не работет, но почему то работает когда скачиваешь файл и потом локально его ставишь. Так как показывали в лекции и написано выше в пунктах выполнения.

## Необязательная часть

1. Реализуйте свой собственный модуль для создания хостов в Yandex Cloud.
2. Модуль может (и должен) иметь зависимость от `yc`, основной функционал: создание ВМ с нужным сайзингом на основе нужной ОС. Дополнительные модули по созданию кластеров Clickhouse, MySQL и прочего реализовывать не надо, достаточно простейшего создания ВМ.
3. Модуль может формировать динамическое inventory, но данная часть не является обязательной, достаточно, чтобы он делал хосты с указанной спецификацией в YAML.
4. Протестируйте модуль на идемпотентность, исполнимость. При успехе - добавьте данный модуль в свою коллекцию.
5. Измените playbook так, чтобы он умел создавать инфраструктуру под inventory, а после устанавливал весь ваш стек Observability на нужные хосты и настраивал его.
6. В итоге, ваша коллекция обязательно должна содержать: clickhouse-role(если есть своя), lighthouse-role, vector-role, два модуля: my_own_module и модуль управления Yandex Cloud хостами и playbook, который демонстрирует создание Observability стека.

