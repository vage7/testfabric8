select md.name as 'Match Day', 
       mg.match_date as 'Date',  
       concat(ht.name, ' vs ' ,ate.name) as 'Match', 
       plt.name as 'Team Id',
       a.external_id as 'Player Id', 
       concat( a.name, ' ', a.surname) as 'Player Name', 
       fs.position as 'Position',
       fs.minutes_played,
        fs.goals_scored,
        fs.goal_assists,
        Case when fs.clean_sheet = 0 Then "N" Else "Y" end as 'Clean Sheet',
        fs.shots_saved,
        fs.penalty_save,
        fs.penalty_miss,
        fs.goals_conceded,
        fs.yellow_cards,
        fs.red_cards,
        fs.own_goals,
        fs.kick_shots as 'Offside Provoked',
        fs.shots_off_target,
        fs.fouls_won,
        fs.fouls_committed 
from football_stats fs
join match_days md on md.id = fs.match_day_id
join team_members tm on tm.id = fs.team_member_id
join athletes a on a.id = tm.athlete_id
join match_games mg on mg.id = match_id
join teams ht on ht.id = mg.home_team_id
join teams ate on ate.id = mg.away_team_id
join teams plt on plt.id = tm.team_id
order by mg.match_date, plt.name, fs.position, a.name, a.surname
INTO OUTFILE 'C:/temp/test_1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';