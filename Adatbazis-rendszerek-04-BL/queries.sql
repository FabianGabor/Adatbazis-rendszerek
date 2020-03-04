-- 1
--select Result.clubHome, Result.clubGuest from Club, Result where Club.name = 'DVSC';
select Club.name, city  from Club, Result where clubHome = 'DVSC';
