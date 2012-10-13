

-- Find duplicate users
select u.*
from (
	SELECT first_name, last_name
	FROM usr
	where status <> 'Deleted'
	GROUP BY first_name, last_name
	HAVING count( * ) >1
) dups, usr u
where u.first_name = dups.first_name
and u.last_name = dups.last_name
order by u.first_name, u.last_name, u.username

select u.*
from (
	SELECT lcase(first_name) first_name, lcase(last_name) last_name
	FROM usr
	where status <> 'Deleted'
	GROUP BY first_name, last_name
	HAVING count( * ) >1
) dups, usr u
where lcase(u.first_name) = dups.first_name
and lcase(u.last_name) = dups.last_name
order by u.last_name, u.first_name, u.username

