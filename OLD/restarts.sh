#!/bin/bash
#PBS -N Manager_Job
#PBS -l walltime=00:10:00
#PBS -q batch

# Виходити зі скрипту при першій помилці
set -e

# Перевірити кількість перезапусків
if [ -z "$PBS_RESTART_COUNT" ]; then
    restart_count=1
else
    restart_count=$((PBS_RESTART_COUNT+1))
fi

# Перевірити кількість перезапусків і при необхідності завершити роботу
if [ $restart_count -gt 10 ]; then
    echo "Досягнуто максимальну кількість перезапусків. Завершення роботи."
    exit
fi

# Вивести інформацію про виконавче середовище
echo "Running on host: $(hostname)"
echo "Current working directory: $(pwd)"
echo "PBS job ID: $PBS_JOBID"
echo "Number of restarts: $restart_count"

# Затримка в 1 хвилину (60 секунд)
sleep 60

# Перезапустити задачу
qsub $PBS_JOBID