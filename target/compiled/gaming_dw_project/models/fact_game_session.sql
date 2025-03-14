

SELECT
    s.session_id,
    dp.player_key,
    dg.game_key,
    dd.date_key,
    s.duration AS session_duration_minutes,
    CURRENT_TIMESTAMP() AS etl_timestamp
FROM `dw-midterm-project.gaming_sessions.stg_sessions` s
JOIN `dw-midterm-project.gaming_sessions.dim_player` dp 
    ON s.player_id = dp.player_source_id AND dp.is_current = TRUE
JOIN `dw-midterm-project.gaming_sessions.dim_game` dg 
    ON s.game_id = dg.game_source_id AND dg.is_current = TRUE
JOIN `dw-midterm-project.gaming_sessions.dim_date` dd 
    ON DATE(s.session_date) = dd.date


WHERE s.session_id NOT IN (
    SELECT session_id FROM `dw-midterm-project.gaming_sessions.fact_game_session`
)
