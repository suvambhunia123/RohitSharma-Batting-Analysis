-- 📅 Create the base table to store Rohit Sharma's batting data
CREATE TABLE Rohit_stats (
    match_date DATE,
    format TEXT,
    year INT,
    opposition TEXT,
    ground TEXT,
    position INT,       
    inns INT,
    runs INT,
    mins INT,
    bf INT,
    fours INT,
    sixes INT,
    sr NUMERIC,
    dismissial TEXT,
    not_out BOOLEAN
);

-- 📊 View 1: Format-wise Summary
CREATE VIEW format_summary AS
SELECT 
    format,
    COUNT(*) AS innings,
    SUM(runs) AS total_runs,
    ROUND(AVG(sr), 2) AS avg_strike_rate,
    COUNT(*) FILTER (WHERE runs >= 50 AND runs < 100) AS fifties,
    COUNT(*) FILTER (WHERE runs >= 100) AS centuries
FROM rohit_stats
GROUP BY format;

-- 📆 View 2: Year-wise Batting Summary
CREATE VIEW yearly_batting_summary AS
SELECT 
    year,
    COUNT(*) FILTER (WHERE runs >= 100) AS centuries,
    COUNT(*) FILTER (WHERE runs >= 50 AND runs < 100) AS fifties,
    SUM(runs) AS total_runs,
    ROUND(AVG(runs), 2) AS avg_score
FROM rohit_stats
GROUP BY year
ORDER BY year;

-- 🆚 View 3: Opposition-wise Performance
CREATE VIEW opposition_performance AS
SELECT 
    opposition,
    COUNT(*) AS innings,
    SUM(runs) AS total_runs,
    ROUND(AVG(runs), 2) AS avg_score,
    COUNT(*) FILTER (WHERE runs >= 100) AS centuries
FROM rohit_stats
GROUP BY opposition
ORDER BY total_runs DESC;
