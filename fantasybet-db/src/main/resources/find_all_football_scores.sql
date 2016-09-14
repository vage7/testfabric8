select md.name as 'Match Day', 
       mg.match_date as 'Date',  
       concat(ht.name, ' vs ' ,ate.name) as 'Match', 
       plt.name as 'Team Id',
       a.external_id as 'Player Id', 
       concat( a.name, ' ', a.surname) as 'Player Name', 
       tm.position as 'Position' , fs.score as 'Score', 
       fs.details as 'Score Per Rule'
from team_member_scores fs
join match_days md on md.id = fs.match_day_id
join team_members tm on tm.id = fs.team_member_id
join athletes a on a.id = tm.athlete_id
join match_games mg on mg.id = fs.match_id
join teams ht on ht.id = mg.home_team_id
join teams ate on ate.id = mg.away_team_id
join teams plt on plt.id = tm.team_id
order by mg.match_date, mg.id, plt.name, tm.position, a.name, a.surname
INTO OUTFILE 'C:/temp/test_2.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '\''
LINES TERMINATED BY '\n';