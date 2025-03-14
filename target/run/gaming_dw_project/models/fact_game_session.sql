-- back compat for old kwarg name
  
  
        
            
	    
	    
            
        
    

    

    merge into `dw-midterm-project`.`gaming_sessions`.`fact_game_session` as DBT_INTERNAL_DEST
        using (

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

        ) as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.session_id = DBT_INTERNAL_DEST.session_id))

    
    when matched then update set
        `session_id` = DBT_INTERNAL_SOURCE.`session_id`,`player_key` = DBT_INTERNAL_SOURCE.`player_key`,`game_key` = DBT_INTERNAL_SOURCE.`game_key`,`date_key` = DBT_INTERNAL_SOURCE.`date_key`,`session_duration_minutes` = DBT_INTERNAL_SOURCE.`session_duration_minutes`,`etl_timestamp` = DBT_INTERNAL_SOURCE.`etl_timestamp`
    

    when not matched then insert
        (`session_id`, `player_key`, `game_key`, `date_key`, `session_duration_minutes`, `etl_timestamp`)
    values
        (`session_id`, `player_key`, `game_key`, `date_key`, `session_duration_minutes`, `etl_timestamp`)


    