--1 What are the names of the players whose salary is greater than 100,000?
SELECT player_name
FROM challenge_2.players
WHERE salary > 100000;

--2 What is the team name of the player with player_id = 3?
SELECT team_name
FROM challenge_2.teams
WHERE team_id = (SELECT team_id FROM challenge_2.players WHERE player_id = 3);

--3 What is the total number of players in each team?
SELECT 
	team_name, 
	COUNT(player_id) AS total_players
FROM 
	challenge_2.teams
LEFT JOIN 
	challenge_2.players 
		ON teams.team_id = players.team_id
GROUP BY 
	team_name;

--4 What is the team name and captain name of the team with team_id = 2?
SELECT 
	team_name, 
	player_name AS captain_name
FROM 
	challenge_2.teams
LEFT JOIN 
	challenge_2.players 
		ON teams.captain_id = players.player_id
WHERE 
	teams.team_id = 2;

--5 What are the player names and their roles in the team with team_id = 1?
SELECT 
	player_name, 
	role
FROM 
	challenge_2.players
WHERE 
	team_id = 1;

--6 What are the team names and the number of matches they have won?
SELECT 
	team_name, 
	COUNT(winner_id) AS matches_won
FROM 
	challenge_2.teams
LEFT JOIN 
	challenge_2.matches 
		ON teams.team_id = matches.winner_id
GROUP BY 
	team_name;

--7 What is the average salary of players in the teams with country 'USA'?
SELECT 
	AVG(salary) AS average_salary
FROM 
	challenge_2.players
WHERE 
	team_id IN (
		SELECT 
			team_id 
		FROM 
			challenge_2.teams
		WHERE 
			country = 'USA'
		);

--8 Which team won the most matches?
SELECT 
	team_name
FROM 
	challenge_2.teams
WHERE 
	team_id = (
		SELECT 
			winner_id
	   	FROM 
	   		challenge_2.matches
	    	GROUP BY 
	    		winner_id
	    	ORDER BY 
	    		COUNT(*) DESC
	    	LIMIT 1
		);

--9 What are the team names and the number of players in each team whose salary is greater than 100,000?
SELECT 
	team_name, 
	COUNT(player_id) AS high_salary_players
FROM 
	challenge_2.teams
LEFT JOIN 
	challenge_2.players
		ON teams.team_id = players.team_id
WHERE 
	salary > 100000
GROUP BY 
	team_name;

--10 What is the date and the score of the match with match_id = 3?
SELECT 
	match_date, 
	score_team1, 
	score_team2
FROM 
	challenge_2.matches
WHERE 
	match_id = 3;

