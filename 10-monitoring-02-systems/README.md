# Домашнее задание к занятию "10.02. Системы мониторинга"

## Обязательные задания

1. Опишите основные плюсы и минусы pull и push систем мониторинга.

- Push (передача данных осуществляется через агенты)

    Плюсы:
    - Выше скорость обработки и ниже размер передаваемых данных за счет использования UDP-протокола
    - Возможность работы за NAT без "проброса" портов
    - Возможно указать резервные ноды системы мониторинга в конфигурации агентов
    - Возможна индивидуальная настройка агентов, что позволяет настроить их более гибко
    - Отсутствие привязки к адресу или dns-имени хоста (данные будут отправляться даже при их изменении)
    - Возможность получения данных за период недоступности обозреваемого хоста (в случае сбоев в передаче данных на сети)

    Минусы:
    - Уникальная настройка агентов, в т.ч. в плане сетевого взаимодействия
    - Отсутсвует контроль частоты и объема отправляемых данных на сервере
    - Некорректно настроенный агент может устроить DDoS-атаку
    - Возможны потери при передаче данных из-за использования UDP-протокола 

- Pull (сервер собирает данные за счет собственных ресурсов)

    Плюсы:
    - Система мониторинга самостоятельно собирает данные, что исключает возможность перегрузки очередей
    - Проще контролировать подлинность данных, т.к. информация собирается только с указанных хостов
    - Возможность получения данных по http (упрощение отладки данных), в т.ч. за NAT'ом при условии "проброса" портов или проксировании соединений
    - Возможность использования TLS для защиты передаваемых данных
    - Используется протокол TCP, что дает гарантию целостности данных при их доставке

    Минусы:
    - В случае изменения адреса или dns-имени обозреваемого хоста потребуется перенастройка на актуальные данные
    - Нет возможности получения данных за период недоступности обозреваемого хоста (в случае сбоев в передаче данных на сети)

2. Какие из ниже перечисленных систем относятся к push модели, а какие к pull? А может есть гибридные?

    - Prometheus 
    - TICK
    - Zabbix
    - VictoriaMetrics
    - Nagios

|Система мониторинга|Используемая модель|
|:---|:---|
|Prometheus|Pull, Push с Pushgateway|
|TICK|Push|
|Zabbix|Push, Pull с Zabbix Proxy|
|VictoriaMetrics|Push, Pull (в зависимости от источника)|
|Nagios|Pull|

3. Склонируйте себе [репозиторий](https://github.com/influxdata/sandbox/tree/master) и запустите TICK-стэк, 
используя технологии docker и docker-compose.

В виде решения на это упражнение приведите выводы команд с вашего компьютера (виртуальной машины):

    - curl http://localhost:8086/ping
    - curl http://localhost:8888
    - curl http://localhost:9092/kapacitor/v1/ping

А также скриншот веб-интерфейса ПО chronograf (`http://localhost:8888`). 

P.S.: если при запуске некоторые контейнеры будут падать с ошибкой - проставьте им режим `Z`, например
`./data:/var/lib:Z`

```bash
sergej@fedora:~/GIT_SORE/sandbox [±|master U:1 ✗|] $ curl http://localhost:8086/ping
sergej@fedora:~/GIT_SORE/sandbox [±|master U:1 ✗|] $ curl http://localhost:8888
<!DOCTYPE html><html><head><link rel="stylesheet" href="/index.c708214f.css"><meta http-equiv="Content-type" content="text/html; charset=utf-8"><title>Chronograf</title><link rel="icon shortcut" href="/favicon.70d63073.ico"></head><body> <div id="react-root" data-basepath=""></div> <script type="module" src="/index.e81b88ee.js"></script><script src="/index.a6955a67.js" nomodule="" defer></script> </body></html>sergej@fedora:~/GIT_SORE/sandbox [±|master U:1 ✗|] $ curl http://localhost:9092/kapacitor/v1/ping
sergej@fedora:~/GIT_SORE/sandbox [±|master U:1 ✗|] $ 
```
![Cкриншот веб-интерфейса ПО chronograf](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/10-monitoring-02-systems/imag/3.1.png)

4. Перейдите в веб-интерфейс Chronograf (`http://localhost:8888`) и откройте вкладку `Data explorer`.

    - Нажмите на кнопку `Add a query`
    - Изучите вывод интерфейса и выберите БД `telegraf.autogen`
    - В `measurments` выберите mem->host->telegraf_container_id , а в `fields` выберите used_percent. 
    Внизу появится график утилизации оперативной памяти в контейнере telegraf.
    - Вверху вы можете увидеть запрос, аналогичный SQL-синтаксису. 
    Поэкспериментируйте с запросом, попробуйте изменить группировку и интервал наблюдений.

Для выполнения задания приведите скриншот с отображением метрик утилизации места на диске 
(disk->host->telegraf_container_id) из веб-интерфейса.

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/10-monitoring-02-systems/imag/4.1.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/10-monitoring-02-systems/imag/4.2.png)

5. Изучите список [telegraf inputs](https://github.com/influxdata/telegraf/tree/master/plugins/inputs). 
Добавьте в конфигурацию telegraf следующий плагин - [docker](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/docker):
```
[[inputs.docker]]
  endpoint = "unix:///var/run/docker.sock"
```

Дополнительно вам может потребоваться донастройка контейнера telegraf в `docker-compose.yml` дополнительного volume и 
режима privileged:
```
  telegraf:
    image: telegraf:1.4.0
    privileged: true
    volumes:
      - ./etc/telegraf.conf:/etc/telegraf/telegraf.conf:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
    links:
      - influxdb
    ports:
      - "8092:8092/udp"
      - "8094:8094"
      - "8125:8125/udp"
```

После настройке перезапустите telegraf, обновите веб интерфейс и приведите скриншотом список `measurments` в 
веб-интерфейсе базы telegraf.autogen . Там должны появиться метрики, связанные с docker.

Факультативно можете изучить какие метрики собирает telegraf после выполнения данного задания.

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/10-monitoring-02-systems/imag/5.1.png)

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

В веб-интерфейсе откройте вкладку `Dashboards`. Попробуйте создать свой dashboard с отображением:

    - утилизации ЦПУ
    - количества использованного RAM
    - утилизации пространства на дисках
    - количество поднятых контейнеров
    - аптайм
    - ...
    - фантазируйте)
    
    ---

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/10-monitoring-02-systems/imag/6.png)