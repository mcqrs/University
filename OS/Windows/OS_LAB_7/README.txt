OS_LAB_7_1A - кривая лаба, так никто её и не завел нормально
Вам может повести и архиктура ПК и размер виртуальных страниц будет
подходить под тот размер с которым здесь работают, однако может и нет

Поэтому, постарался сделать так, чтобы хотя бы ошибок не вылетало

Лаба на прерывание страницы, и запись в виртульную память, поэтому берем и ставим
точку останова на 111 строку где идет запись: char_ptr[i] = 'a'; и по очереди
в цикле показываем как в char_ptr записываются символы и все

OS_LAB_7_23A - использование различных команд работы с виртуальной памятью
В input.txt записан сценарий запуска команд - номер, блок памяти и доступ
В output.txt - мониторинг системы

Работают два потока, один поочередно запускает команды по сценарию,
а второй мониторит систему