CREATE TABLE `dw-midterm-project.gaming_sessions.dim_date` (
    date_key INTEGER PRIMARY KEY,
    date DATE,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    day_of_week STRING,
    weekday_weekend STRING
);