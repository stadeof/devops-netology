# Домашнее задание к занятию "1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."
___
1. Виртуализация на уровне ОС позволяет виртуализовать физические серверы на уровне ядра операционной системы. Как пример - докер контейнеры. 

    Аппаратная виртуализация включает в себя установку гипервизора, который задает "направление" между программным обеспечением и железом. Полное распределение ресурсов.

    Паравиртуализация - техника, при которой гостевые ОС подготавливаются для исполнения в виртуализированной среде, общается с гипервизором через api. Происходит изменение ядра гостевой ОС

2. **Высоконагруженная база данных, чувствительная к отказу.** - виртуализация на уровне ОС. k8s кластер будет полезен для распределения ресурсов и отказоустойчивости.

   **Различные web-приложения.** - виртуализация на уровне ОС. Управление стеком веб-приложения, деплой, будет удобнее и логичнее настроить с использованием контейнеров.

   **Windows системы для использования бухгалтерским отделом.** - паравиртуализация

   **Системы, выполняющие высокопроизводительные расчеты на GPU** - физический сервер

3. 1. VMWare позволит создавать множество виртуальных машин с различными операционными системами и будет подходящим вариантом. 
   2. KVM меньше и быстрее чем VirtualBox, но VB является более масштабируемым вариантом. Возможно выбрать из 2х решений, но в данном случае, я бы предпочел KVM.
   3. Для windows инфраструктуры, отличным опенсоурс решением будет Xen.
   4. Возможен вариант гетерогенной виртуализации. Например KVM + docker. 

4. Приведу пример. В гос. учреждениях, как правило, используется свой ЦОД. В свою очередь, виртуалки разбиваются при помощи VMWare. На разбитых виртуалках, применяется виртуализация на уровне ОС, например докер. Из минусов - требование к профессиональной подготовке специалистов, так как взаимодействие аппаратное и на уровне ОС происходит разными людьми. Следовательно - больше расходы. 
Также минусы с точки зрения мониторинга и логирования, так как необходимо мониторить как состояние виртуальных машин, так и контейнеров непосредственно. 