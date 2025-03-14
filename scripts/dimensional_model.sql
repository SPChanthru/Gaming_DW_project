-- Create date dimension (Type 1 SCD - doesn't change)
CREATE OR REPLACE TABLE `dw-midterm-project.gaming_sessions.dim_date` AS
SELECT
    ROW_NUMBER() OVER () AS date_key,
    date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    FORMAT_DATE('%A', date) AS day_of_week,
    CASE
        WHEN EXTRACT(DAYOFWEEK FROM date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS weekday_weekend
FROM (
    SELECT DISTINCT DATE(session_date) AS date
    FROM `dw-midterm-project.gaming_sessions.stg_sessions`
);

-- Create player dimension with surrogate key (Type 2 SCD - tracks history)
CREATE OR REPLACE TABLE `dw-midterm-project.gaming_sessions.dim_player` AS
SELECT
    ROW_NUMBER() OVER () AS player_key,
    player_id AS player_source_id,
    username,
    level,
    experience_points,
    region,
    CURRENT_DATE() AS valid_from,
    DATE('9999-12-31') AS valid_to,
    TRUE AS is_current
FROM `dw-midterm-project.gaming_sessions.stg_players`;

-- Create game dimension with surrogate key and is_current flag
CREATE OR REPLACE TABLE `dw-midterm-project.gaming_sessions.dim_game` AS
SELECT
    ROW_NUMBER() OVER () AS game_key,
    game_id AS game_source_id,
    'CyberRace' AS title,          -- Example placeholder
    'Racing' AS genre,             -- Example placeholder
    'DevCo' AS developer,          -- Example placeholder
    CURRENT_DATE() AS release_date, -- Default to today if unknown
    TRUE AS is_current             -- Flag as current 
FROM (
    SELECT 
        game_id,
        'CyberRace' AS title,          -- Example placeholder
        'Racing' AS genre,             -- Example placeholder
        'DevCo' AS developer,          -- Example placeholder
        CURRENT_DATE() AS release_date -- Default to today if unknown
    FROM (
        SELECT DISTINCT game_id 
        FROM `dw-midterm-project.gaming_sessions.stg_sessions`  -- source table
    ) AS source
) AS game_data