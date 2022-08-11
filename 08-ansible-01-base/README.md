# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.

```shell
[sergej@Fedora playbook]$ ansible --version
ansible [core 2.13.2]
```

2. Создайте свой собственный публичный репозиторий на github с произвольным именем.

Репозиторий для выполнения заданий по [Ansible](https://github.com/Sergej1024/mnt)

3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ***********************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [localhost]

TASK [Print OS] *****************************************************************************************************
ok: [localhost] => {
    "msg": "Fedora"
}

TASK [Print fact] ***************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP **********************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/test.yml site.yml

PLAY [Print os facts] ***********************************************************************************************

TASK [Gathering Facts] **********************************************************************************************
ok: [localhost]

TASK [Print OS] *****************************************************************************************************
ok: [localhost] => {
    "msg": "Fedora"
}

TASK [Print fact] ***************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP **********************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
```shell
[sergej@Fedora playbook]$ docker run --name centos7 -d centos:7 sleep 600000000
8aab3e5e1ccf8c5b365e293e933853153681362a563e235cd0b5f4069830540a
[sergej@Fedora playbook]$ docker run --name ubuntu -d ubuntu:latest sleep 600000000
0a51f5349890d098d9d356c408e8833e7794c0c22297c5087967102a860edc77
```
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Prepare deb host] *****************************************************************************************************************************************************************************

TASK [Install Python] *******************************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[sergej@Fedora playbook]$ 
```
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Prepare deb host] *****************************************************************************************************************************************************************************

TASK [Install Python] *******************************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml

PLAY [Prepare deb host] *****************************************************************************************************************************************************************************

TASK [Install Python] *******************************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
```shell
[sergej@Fedora playbook]$ ansible-vault encrypt group_vars/deb/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
[sergej@Fedora playbook]$ ansible-vault encrypt group_vars/el/examp.yml
New Vault password: 
Confirm New Vault password: 
Encryption successful
[sergej@Fedora playbook]$ 
```
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/deb_vault.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/el-vault.png)

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Prepare deb host] *****************************************************************************************************************************************************************************

TASK [Install Python] *******************************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] *******************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] *************************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ***********************************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ******************************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```shell
[sergej@Fedora playbook]$ ansible-doc -t connection -l
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                                                                                 
ansible.netcommon.libssh       (Tech preview) Run tasks using libssh for ssh connection                                                                                                         
ansible.netcommon.napalm       Provides persistent connection using NAPALM                                                                                                                      
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                                                                                      
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                                                                                             
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                                                                                      
community.aws.aws_ssm          execute via AWS Systems Manager                                                                                                                                  
community.docker.docker        Run tasks in docker containers                                                                                                                                   
community.docker.docker_api    Run tasks in docker containers                                                                                                                                   
community.docker.nsenter       execute on host running controller container                                                                                                                     
community.general.chroot       Interact with local chroot                                                                                                                                       
community.general.funcd        Use funcd to connect to target                                                                                                                                   
community.general.iocage       Run tasks in iocage jails                                                                                                                                        
community.general.jail         Run tasks in jails                                                                                                                                               
community.general.lxc          Run tasks in lxc containers via lxc python library                                                                                                               
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                                                                                          
community.general.qubes        Interact with an existing QubesOS AppVM                                                                                                                          
community.general.saltstack    Allow ansible to piggyback on salt minions                                                                                                                       
community.general.zone         Run tasks in a zone instance                                                                                                                                     
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                                                                                          
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                                                                                       
community.okd.oc               Execute tasks in pods running on OpenShift                                                                                                                       
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                                                                                       
community.zabbix.httpapi       Use httpapi to run command on network appliances                                                                                                                 
containers.podman.buildah      Interact with an existing buildah container                                                                                                                      
containers.podman.podman       Interact with an existing podman container                                                                                                                       
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes                                                                                                                      
local                          execute on controller                                                                                                                                            
paramiko_ssh                   Run tasks via python ssh (paramiko)                                                                                                                              
psrp                           Run tasks over Microsoft PowerShell Remoting Protocol                                                                                                            
ssh                            connect via SSH client binary                                                                                                                                    
winrm                          Run tasks over Microsoft's WinRM                                                                                                                                 
(END)
```
                                                                             
Для подключения к `control node` можно использовать модуль local

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/prod-local.png)

11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Prepare deb host] **************************************************************************************************************************************************************

TASK [Install Python] ****************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] ****************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **********************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [localhost] => {
    "msg": "Fedora"
}

TASK [Print fact] ********************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ***************************************************************************************************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

[Ссылка на playbook](https://github.com/Sergej1024/mnt)

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.

```shell
[sergej@Fedora playbook]$ ansible-vault decrypt group_vars/deb/examp.yml 
Vault password: 
Decryption successful
[sergej@Fedora playbook]$ ansible-vault decrypt group_vars/el/examp.yml 
Vault password: 
Decryption successful
[sergej@Fedora playbook]$
```
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/deb_decript.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/el-decript.png)


2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.

```shell
[sergej@Fedora playbook]$ ansible-vault encrypt_string
New Vault password: 
Confirm New Vault password: 
Reading plaintext input from stdin. (ctrl-d to end input, twice if your content does not already have a newline)
PaSSw0rd  
Encryption successful
!vault |
          $ANSIBLE_VAULT;1.1;AES256
          37396633356335636534633638366634613138383738666630623330316565656134366663346430
          6162343062316165643662393730396631366333623865610a343963363338633461656338333863
          30333364336239666137633761363737616537623666333030373666303061386437303463376663
          6165333033313835370a346236646438653738396361303436323865383333366430643761626663
          6332
[sergej@Fedora playbook]$ 
```
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/08-ansible-01-base/image/enc_str.png)

3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.

```shell
TASK [Print vault_key] ********************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "PaSSw0rd"
}
ok: [ubuntu] => {
    "msg": "PaSSw0rd"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
```

4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](latest).

```shell
[sergej@Fedora playbook]$ ansible-playbook -i inventory/prod.yml site.yml --ask-vault-password
Vault password: 

PLAY [Prepare deb host] **************************************************************************************************************************************************************

TASK [Install Python] ****************************************************************************************************************************************************************
changed: [ubuntu]

PLAY [Print os facts] ****************************************************************************************************************************************************************

TASK [Gathering Facts] ***************************************************************************************************************************************************************
ok: [localhost]
ok: [fedora]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **********************************************************************************************************************************************************************
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos7] => {
    "msg": "CentOS"
}
ok: [localhost] => {
    "msg": "Fedora"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] ********************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [fedora] => {
    "msg": "Fedora the best"
}

TASK [Print vault_key] ***************************************************************************************************************************************************************
ok: [centos7] => {
    "msg": "PaSSw0rd"
}
ok: [ubuntu] => {
    "msg": "PaSSw0rd"
}
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [fedora] => {
    "msg": "PaSSw0rd"
}

PLAY RECAP ***************************************************************************************************************************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[sergej@Fedora playbook]$ 
```

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.

6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.
[Ссылка на репозиторий](https://github.com/Sergej1024/mnt/tree/master/playbook)

