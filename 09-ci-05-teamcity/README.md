# Домашнее задание к занятию "09.05 Teamcity"

## Подготовка к выполнению

1. В Ya.Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`
2. Дождитесь запуска teamcity, выполните первоначальную настройку
3. Создайте ещё один инстанс(2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`
4. Авторизуйте агент
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity)
6. Создать VM (2CPU4RAM) и запустить [playbook](./infrastructure)

## Основная часть

1. Создайте новый проект в teamcity на основе fork

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/1.1.jpg)

</details>

2. Сделайте autodetect конфигурации

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/2.1.jpg)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/2.2.jpg)


</details>

3. Сохраните необходимые шаги, запустите первую сборку master'a
4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/4.1.jpg)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/4.2.jpg)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/4.3.jpg)

</details>

5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/5.1.png)

</details>

6. В pom.xml необходимо поменять ссылки на репозиторий и nexus
7. Запустите сборку по master, убедитесь что всё прошло успешно, артефакт появился в nexus

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/7.1.jpg)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/7.2.png)

</details>

8. Мигрируйте `build configuration` в репозиторий

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/8.1.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/8.2.png)

</details>

9. Создайте отдельную ветку `feature/add_reply` в репозитории
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике
12. Сделайте push всех изменений в новую ветку в репозиторий
13. Убедитесь что сборка самостоятельно запустилась, тесты прошли успешно

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/13.1.png)

</details>

14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/15.1.png)

</details>

16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/16.1.png)

</details>

17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/17.1.png)
![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/17.2.png)

</details>

18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity

<details><summary>Результат выполнения</summary>

![](https://github.com/Sergej1024/mnt-homeworks/blob/MNT-13/09-ci-05-teamcity/image/18.1.png)

</details>

19. В ответ предоставьте [ссылку](https://github.com/Sergej1024/example-teamcity) на репозиторий