SELECT
	pg_size_pretty(count(*) filter ( 
		where reldatabase is null) * 8192) as free,
	pg_size_pretty(count(*) filter (
		where pinning_backends = 0 and isdirty = 'f') * 8192) as clean,
	pg_size_pretty(count(*) filter (
		where pinning_backends > 0 and isdirty='f') * 8192) as "clean/pinned",
	pg_size_pretty(count(*) filter (
		where pinning_backends = 0 and isdirty='t') * 8192) as dirty,
	pg_size_pretty(count(*) filter (
		where pinning_backends > 0 and isdirty= 't') * 8192) as "dirty/pinned"
from pg_buffercache;

    free    | clean | clean/pinned | dirty  | dirty/pinned
------------+-------+--------------+--------+--------------
 8192 bytes | 11 MB | 0 bytes      | 117 MB | 0 bytes


1. free - Свободные буферы
Буферы, не занятые данными
Готовы для новых страниц

2. clean - Чистые буферы
Данные совпадают с диском
Можно сразу переиспользовать

3. clean/pinned - Залоченные чистые буферы
Чистые данные, но используются сейчас
Нельзя вытеснить

4. dirty - Грязные буферы
Измененные данные (еще не записаны на диск)
Ждут checkpoint или background writer

5. dirty/pinned - Залоченные грязные буферы
Измененные данные + активное использование
Самые "проблемные" буферы

    Много free → кеш недогружен

    Много dirty → возможны проблемы с записью на диск

    Много pinned → высокая конкурентная нагрузка

    Мало free + много dirty → риск нехватки буферов