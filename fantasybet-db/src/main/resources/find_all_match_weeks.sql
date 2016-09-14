select hex(mg.id) as match_id, 
       mw.name as 'Match Week', 
       mw.start_date as 'Week Start',
       mw.end_date as 'Week End',
       ht.name as 'Home Team Name', 
       awt.name as 'Away Team Name', 
       mg.match_date as 'Match Date' 
from match_weeks mw 
join match_days md on md.match_week_id = mw.id
join match_games mg on mg.match_day_id = md.id
join teams ht on home_team_id = ht.id
join teams awt on away_team_id = awt.id
join seasons s on s.id = mw.season_id
where s.name = 'Season 2012/2013'
order by 3, 7