#!/bin/bash

# Оголошуємо змінну для лічильника
counter=0
stat_file="statistics.txt"

# Перевіряємо кількість копій процесу
if [ -z "$COPY_COUNT" ]; then
    copy_count=1
else
    copy_count=$((COPY_COUNT+1))
fi

# Перевіряємо кількість копій процесу і при необхідності завершуємо роботу
if [ $copy_count -gt 10 ]; then
    #echo "Досягнуто максимальну кількість копій процесу. Завершення роботи."
    exit
else
    # Виводимо повідомлення та інформацію про поточний процес
    echo "Копія процесу: $copy_count" >> $stat_file
    mpirun -np 4 ./mpi_hello_world >> $stat_file
    # Затримка в 10 секунд (можна змінити на бажане значення)
    sleep 30

    # Створюємо нову копію процесу
    COPY_COUNT=$copy_count bash "$0" &
    exit
fi

