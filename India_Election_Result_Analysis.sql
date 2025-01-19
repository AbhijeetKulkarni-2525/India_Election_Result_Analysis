--Checking the available data
SELECT 
  * 
FROM 
  [dbo].[constituencywise_details] 


SELECT 
  * 
FROM 
  [dbo].[constituencywise_results] 


SELECT 
  * 
FROM 
  [dbo].[partywise_results] 


SELECT 
  * 
FROM 
  [dbo].[states] 


SELECT 
  * 
FROM 
  [dbo].[statewise_results]



--Find out the total seats
SELECT 
  DISTINCT(
    COUNT(parliament_constituency)
  ) AS total_seats 
FROM 
  constituencywise_results

     

--What are total number of seats available for election in each state?
SELECT 
  s.state AS state_name, 
  COUNT(
    DISTINCT(sr.Parliament_Constituency)
  ) AS total_seats_available 
FROM 
  states AS s 
  JOIN statewise_results as sr ON s.State_ID = sr.State_ID 
GROUP BY 
  s.state 
ORDER BY 
  s.state



--Find out total number of seats won by NDA Alliance
SELECT 
  SUM(
    CASE WHEN Party IN (
      'Bharatiya Janata Party - BJP', 
      'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 
      'Shiv Sena - SHS', 'AJSU Party - AJSUP', 
      'Apna Dal (Soneylal) - ADAL', 'Asom Gana Parishad - AGP', 
      'Hindustani Awam Morcha (Secular) - HAMS', 
      'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 
      'Lok Janshakti Party(Ram Vilas) - LJPRV', 
      'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM', 
      'Nationalist Congress Party - NCP'
    ) THEN [Won] ELSE 0 END
  ) AS NDA_total_seats_won 
FROM 
  partywise_results



--Find out total number of seats won by EACH PARTY in NDA Alliance
SELECT 
  Party AS party_name, 
  SUM(Won) AS seats_won_by_each_party 
FROM 
  partywise_results 
WHERE 
  Party IN (
    'Bharatiya Janata Party - BJP', 
    'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 
    'Shiv Sena - SHS', 'AJSU Party - AJSUP', 
    'Apna Dal (Soneylal) - ADAL', 'Asom Gana Parishad - AGP', 
    'Hindustani Awam Morcha (Secular) - HAMS', 
    'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 
    'Lok Janshakti Party(Ram Vilas) - LJPRV', 
    'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM', 
    'Nationalist Congress Party - NCP'
  ) 
GROUP BY 
  Party 
ORDER BY 
  SUM(Won) DESC



--Find out total number of seats won by I.N.D.I.A. Alliance
SELECT 
  SUM(
    CASE WHEN Party IN (
      'Indian National Congress - INC', 
      'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 
      'Bharat Adivasi Party - BHRTADVSIP', 
      'Communist Party of India  (Marxist) - CPI(M)', 
      'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 
      'Communist Party of India - CPI', 
      'Dravida Munnetra Kazhagam - DMK', 
      'Indian Union Muslim League - IUML', 
      'Jammu & Kashmir National Conference - JKN', 
      'Jharkhand Mukti Morcha - JMM', 
      'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK', 
      'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 
      'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 
      'Revolutionary Socialist Party - RSP', 
      'Samajwadi Party - SP', 'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 
      'Viduthalai Chiruthaigal Katchi - VCK'
    ) THEN [Won] ELSE 0 END
  ) 
FROM 
  partywise_results




--Find out total number of seats won by EACH PARTY in I.N.D.I.A. Alliance
SELECT 
  Party AS party_name, 
  SUM(Won) AS total_seats_won_by_each_party 
FROM 
  partywise_results 
WHERE 
  Party IN(
    'Indian National Congress - INC', 
    'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 
    'Bharat Adivasi Party - BHRTADVSIP', 
    'Communist Party of India  (Marxist) - CPI(M)', 
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 
    'Communist Party of India - CPI', 
    'Dravida Munnetra Kazhagam - DMK', 
    'Indian Union Muslim League - IUML', 
    'Jammu & Kashmir National Conference - JKN', 
    'Jharkhand Mukti Morcha - JMM', 
    'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK', 
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 
    'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 
    'Revolutionary Socialist Party - RSP', 
    'Samajwadi Party - SP', 'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 
    'Viduthalai Chiruthaigal Katchi - VCK'
  ) 
GROUP BY 
  Party 
ORDER BY 
  SUM(Won) DESC



--Add a colmn called Party_Alliance to show parties belonging to both alliance (parties with no alliance to be called "OTHER"
ALTER TABLE 
  partywise_results 
ADD 
  Party_Alliance VARCHAR(100)

UPDATE 
  partywise_results 
SET 
  Party_Alliance = 'I.N.D.I.A.' 
WHERE 
  Party IN(
    'Indian National Congress - INC', 
    'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 
    'Bharat Adivasi Party - BHRTADVSIP', 
    'Communist Party of India  (Marxist) - CPI(M)', 
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 
    'Communist Party of India - CPI', 
    'Dravida Munnetra Kazhagam - DMK', 
    'Indian Union Muslim League - IUML', 
    'Jammu & Kashmir National Conference - JKN', 
    'Jharkhand Mukti Morcha - JMM', 
    'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK', 
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 
    'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 
    'Revolutionary Socialist Party - RSP', 
    'Samajwadi Party - SP', 'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 
    'Viduthalai Chiruthaigal Katchi - VCK'
  )



UPDATE 
  partywise_results 
SET 
  Party_Alliance = 'NDA' 
WHERE 
  Party IN (
    'Bharatiya Janata Party - BJP', 
    'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 
    'Shiv Sena - SHS', 'AJSU Party - AJSUP', 
    'Apna Dal (Soneylal) - ADAL', 'Asom Gana Parishad - AGP', 
    'Hindustani Awam Morcha (Secular) - HAMS', 
    'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 
    'Lok Janshakti Party(Ram Vilas) - LJPRV', 
    'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM', 
    'Nationalist Congress Party - NCP'
  )



UPDATE 
  partywise_results 
SET 
  Party_Alliance = 'OTHER' 
WHERE 
  Party_Alliance IS NULL


SELECT 
  Party_Alliance, 
  SUM(Won) AS total_seats_won 
FROM 
  partywise_results 
GROUP BY 
  Party_Alliance 
ORDER BY 
  SUM(Won) DESC




--Find out winning cadidate name, their party name, total votes and margin of victory (for a specific state or constituency)
SELECT 
  cr.Winning_Candidate, 
  pr.Party, 
  cr.Total_Votes, 
  cr.Margin, 
  s.State, 
  cr.Constituency_Name 
FROM 
  constituencywise_results AS cr 
  JOIN partywise_results AS pr ON pr.Party_ID = cr.Party_ID 
  JOIN statewise_results as sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
  JOIN states AS s ON s.State_ID = sr.State_ID 
WHERE 
  cr.Constituency_Name = 'PUNE'





--Find out the distribution of EVM votes versus postal votes for candidates (for a specific constituency)
SELECT 
  cr.Constituency_Name, 
  cd.Candidate, 
  cd.EVM_Votes, 
  cd.Postal_Votes, 
  cd.Total_Votes 
FROM 
  constituencywise_results AS cr 
  JOIN constituencywise_details AS cd ON cd.Constituency_ID = cr.Constituency_ID 
WHERE 
  cr.Constituency_Name = 'NASHIK'




--Find out seats won by each party in a given state
SELECT 
  pr.Party AS party_name, 
  COUNT(pr.Won) AS total_seats_won 
FROM 
  partywise_results as pr 
  JOIN constituencywise_results AS cr ON cr.Party_ID = pr.Party_ID 
  JOIN statewise_results as sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
  JOIN states AS s ON s.State_ID = sr.State_ID 
WHERE 
  s.State = 'Andhra Pradesh' 
GROUP BY 
  pr.Party 
ORDER BY 
  COUNT(pr.Won) DESC




--Find out the total number of seats won by each alliance in a given state
SELECT 
  pr.Party_Alliance, 
  COUNT(pr.Won) AS total_seats_won 
FROM 
  partywise_results AS pr 
  JOIN constituencywise_results as cr ON cr.Party_ID = pr.Party_ID 
  JOIN statewise_results AS sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
  JOIN states AS s ON s.State_ID = sr.State_ID 
WHERE 
  s.State = 'Rajasthan' 
GROUP BY 
  pr.Party_Alliance 
ORDER BY 
  SUM(pr.Won) DESC



--Show total number of seats won by each alliance for each state
SELECT 
  s.State, 
  SUM(
    CASE WHEN pr.Party_Alliance = 'NDA' THEN 1 ELSE 0 END
  ) AS NDA_seats_won, 
  SUM(
    CASE WHEN pr.Party_Alliance = 'I.N.D.I.A.' THEN 1 ELSE 0 END
  ) AS INDIA_seats_won, 
  SUM(
    CASE WHEN pr.Party_Alliance = 'OTHER' THEN 1 ELSE 0 END
  ) AS OTHER_seats_won 
FROM 
  partywise_results AS pr 
  JOIN constituencywise_results as cr ON cr.Party_ID = pr.Party_ID 
  JOIN statewise_results AS sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
  JOIN states AS s ON s.State_ID = sr.State_ID 
GROUP BY 
  s.State



--Show which 10 candidates who received highest number of EVM votes
SELECT 
  TOP 10 cd.Candidate, 
  cd.Constituency_ID, 
  cd.EVM_Votes, 
  cr.Constituency_Name 
FROM 
  constituencywise_details as cd 
  JOIN constituencywise_results AS cr ON cr.Constituency_ID = cd.Constituency_ID 
WHERE 
  cd.EVM_Votes = (
    SELECT 
      MAX(cd1.EVM_Votes) 
    FROM 
      constituencywise_details AS cd1 
    WHERE 
      cd1.Constituency_ID = cd.Constituency_ID
  ) 
ORDER BY 
  cd.EVM_Votes DESC



--Find out winner and 1st runner up for each constituency for a given state
WITH RankedCandidates AS(
  SELECT 
    cd.Constituency_ID, 
    cd.Candidate, 
    cd.Party, 
    cd.EVM_Votes, 
    cd.Postal_Votes, 
    cd.EVM_Votes + cd.Postal_Votes AS Total_Votes, 
    ROW_NUMBER() OVER (
      PARTITION BY cd.Constituency_ID 
      ORDER BY 
        cd.EVM_Votes + cd.Postal_Votes DESC
    ) AS VoteRank 
  FROM 
    constituencywise_details AS cd 
    JOIN constituencywise_results AS cr ON cr.Constituency_ID = cd.Constituency_ID 
    JOIN statewise_results sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
    JOIN states AS s ON s.State_ID = sr.State_ID 
  WHERE 
    s.State = 'Tamil Nadu'
	)

SELECT 
  cr.Constituency_Name, 
  MAX(
    CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END
  ) AS Winning_Candidtae, 
  MAX(
    CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END
  ) AS Runnerup_Candidtae 
FROM 
  RankedCandidates AS rc 
  JOIN constituencywise_results AS cr ON rc.Constituency_ID = cr.Constituency_ID 
GROUP BY 
  cr.Constituency_Name 
ORDER BY 
  cr.Constituency_Name



--Find out for the state of Maharashtra- total number of seats, total number of candidates, total number of parties, 
--total votes(both EVM and Postal) and breakdown of EVM and Postal votes
SELECT 
  COUNT(
    DISTINCT(cr.Constituency_ID)
  ) AS total_number_of_seats, 
  COUNT(cd.Candidate) AS total_number_of_candidtaes, 
  COUNT(
    DISTINCT(p.Party)
  ) AS total_number_of_parties, 
  SUM(cd.EVM_Votes) AS total_EVM_Votes, 
  SUM(cd.Postal_Votes) AS total_postal_votes, 
  SUM(cd.EVM_Votes + cd.Postal_Votes) AS total_Votes 
FROM 
  constituencywise_details AS cd 
  JOIN constituencywise_results AS cr ON cr.Constituency_ID = cd.Constituency_ID 
  JOIN statewise_results AS sr ON sr.Parliament_Constituency = cr.Parliament_Constituency 
  JOIN states AS s ON s.State_ID = sr.State_ID 
  JOIN partywise_results AS p ON p.Party_ID = cr.Party_ID 
WHERE 
  s.State = 'Maharashtra'






       
       

 

