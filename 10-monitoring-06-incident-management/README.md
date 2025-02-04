# Домашнее задание к занятию "10.06. Инцидент-менеджмент"

## Задание 1

Составьте постмотрем, на основе реального сбоя системы Github в 2018 году.

Информация о сбое доступна [в виде краткой выжимки на русском языке](https://habr.com/ru/post/427301/) , а
также [развёрнуто на английском языке](https://github.blog/2018-10-30-oct21-post-incident-analysis/).


|Вопросы | Комментарии
|:------:|:---|
|Краткое описание инцидента|В 22:52 UTC 21 октября несколько служб на GitHub.com были затронуты сетевым переключением и последующим сбоем базы данных, что привело к противоречивой информации, представленной на веб-сайте.|
|Предшествующие события|Плановые работы по техническому обслуживанию для замены вышедшего из строя оптического оборудования 100G.|
|Причина инцидента|Из-за временной сетевой недоступности Orchestrator провел кворум и собрал кластер на западном побережье США. Серверы баз данных в центре обработки данных на Восточном побережье США содержали короткий период записей, которые не были реплицированы на объект на Западном побережье США. Поскольку кластеры баз данных в обоих центрах обработки данных теперь содержали записи, которых не было в другом центре обработки данных, инженеры не смогли безопасно перенести основной сервер обратно в центр обработки данных на Восточном побережье США.|
|Воздействие|Возник риск потери пользовтаельских данных. Во время восстановления на Западном побережье наблюдались проблемы с доступностью сервиса. Была приостановлена доставка webhook и сборки GitHub Pages.|
|Обнаружение|21 октября 2018 22:54 UTC Системы мониторинга начали генерировать предупреждения, указывающие на то, что в системах возникли многочисленные сбои.|
|Реакция| В 23:07 UTC инженеры из команды первого реагирования определили, что топологии для многочисленных кластеров баз данных находятся в неожиданном состоянии.|
|Восстановление|Команда реагирования вручную заблокировала внутренний инструмент развертывания, чтобы предотвратить внесение каких-либо дополнительных изменений. Было прекращено выполнение заданий, которые записывают метаданные о таких вещах, как push. Инжененры баз данных запустили создание резервной копии БД с последующим ее восстаностановлением на сбойных нодах для восстановления синхронизации реплики в обоих сайтах.|
|Время|События|
|21.10.2018, 22:52 UTC|Потеря связи между серверами кластера БД MySQL на 43 секунды, в течении которого произошел переход первичных сервисов БД на реплики, в результате некорректной настройки согласованности конфигурации Orchestrator'а с работой на уровне приложения после восстановления соединения не получилось выполнить репликацию данных между узлами кластера|
|21.10.2018, 22:54 UTC|Внутренние системы мониторинга начали генерировать предупреждения, указывающие на многочисленные сбои в системах|
|21.10.2018, 23:02 UTC|Инженеры группы быстрого реагирования определили, что топологии многочисленных кластеров баз данных находятся в непредвиденном состоянии|
|21.10.2018, 23:07 UTC|Отвечающая команда решила вручную заблокировать внутренний инструмент развертывания|
|21.10.2018, 23:09 UTC|Команда респондентов поместила сайт в желтый статус и система эскалации переводит запрос в инцидент и направляет предупреждение координатору инцидентов|
|21.10.2018, 23:11 UTC|Координатор присоединился к команде|
|21.10.2018, 23:13 UTC|Координатор изменяет статус решения на красный, вызваны дополнительные инженеры из группы разработки баз данных| 
|21.10.2018, 23:19 UTC|Принято решение приостановить доставку веб-хуков и сборки GitHub Pages для сохранения целостности данных|
|22.10.2018, 00:05 UTC|Инженеры, участвующие в группе реагирования на инциденты, начали разработку плана по устранению несоответствий данных и внедрению процедур аварийного переключения для MySQL, оповещение пользователей о предстоящем контролируемом переходе на другой ресурс внутренней СХД|
|22.10.2018, 00:41 UTC|Инициирован процесс восстановления из резервных копирований для всех затронутых кластеров MySQL|
|22.10.2018, 06:51 UTC|Несколько кластеров завершили восстановление из резервных копий и начали репликацию новых данных, более крупные кластеры находятся в процессе восстановления|
|22.10.2018, 07:46 UTC|GitHub опубликовал сообщение в блоге , чтобы предоставить больше контекста|
|22.10.2018, 11:12 UTC|Восстановился основной кластер БД, но множество реплик БД продолжали отставать от основной на несколько часов, это приводило к тому что, пользователи видели несогласованные данные при взаимодействии со службами сайта|
|22.10.2018, 13:15 UTC|Пик нагрузки трафика на сайт, принято решение разворачивания дополнительных реплик на чтение|
|22.10.2018, 16:24 UTC|Реплики были синхронизированы, выполнено аварийное переключение на исходную топологию|
|22.10.2018, 16:45 UTC|Начался процесс обработки накопившихся событий|
|22.10.2018, 23:03 UTC|Все ожидающие сборки вебхуков и страниц были обработаны, подтверждена целостность и правильная работа всех систем. Статус сайта обновлен до зеленого|
|Вопросы | Комментарии
|Последующие действия|Организационные инициативы. Этот инцидент привел к изменению нашего мышления в отношении надежности сайта. Мы узнали, что ужесточение оперативного контроля или увеличение времени реагирования являются недостаточными гарантиями надежности сайта в такой сложной системе сервисов, как наша. Чтобы поддержать эти усилия, мы также начнем систематическую практику проверки сценариев сбоев до того, как они смогут повлиять на вас. Эта работа будет включать в себя будущие инвестиции в разработку инструментов для устранения неисправностей и разработки хаоса на GitHub. Технические инициативы: 1. Настройте конфигурацию Orchestrator, чтобы предотвратить распространение праймериз базы данных через региональные границы. Действия Orchestrator вели себя так, как было настроено, несмотря на то, что наш уровень приложений не смог поддержать это изменение топологии. Выборы лидера в регионе, как правило, безопасны, но внезапное введение межстрановой задержки стало основным фактором, способствующим этому инциденту. 2.Ускорить переход на новый механизм отчетности о состоянии.|
