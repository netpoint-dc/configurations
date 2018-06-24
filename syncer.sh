#!/bin/bash

REPO_DIR=$1 # где хранится репозиторий
shift
DIRS=$@ # какие каталоги синхронизуем

echo "Repository is located at "$REPO_DIR
echo "Configuration dirs are located at "$DIRS

HOSTNAME=$(hostname)
TODAY=$(date +"%Y-%m-%d")
HOUR=$(date +"%H")

echo "Hostname is "$HOSTNAME
echo "Today is "$TODAY

# выкачаем обновления с сервера
git pull
# переключимся на master ветку, куда добавляем изменения
git checkout master

mkdir -p $REPO_DIR/$HOSTNAME

# добавим новые файлы в репозиторий
rsync -av $DIRS $REPO_DIR/$HOSTNAME/
find $REPO_DIR/* -exec git add {} \;

# сохраним изменения
git commit -a -m "Configuration updated at $(date)"

# отправим изменения на сервер
git push

# если последняя синхронизация в сутках, создадим ветку для сегодняшнего дня
if [ $HOUR = "00" ];
then
    git checkout -b $TODAY
    git push origin $TODAY
    git checkout master
fi

