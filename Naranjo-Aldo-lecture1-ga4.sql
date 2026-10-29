-- =========================================================
-- IBM 6500 | IC/CP-W04 BigQuery SQL Lecture 1
-- Author: Aldo Naranjo
-- Dataset: bigquery-public-data.ga4_obfuscated_sample_ecommerce
-- =========================================================


-- ---------------------------------------------------------
-- 1) SELECT / FROM / LIMIT
-- Pick columns from a table and return a set number of rows
-- ---------------------------------------------------------
SELECT event_date, event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 20;


-- ---------------------------------------------------------
-- 2) WHERE filters rows
-- Keep only purchase events
-- ---------------------------------------------------------
SELECT event_date, event_name, user_pseudo_id
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
LIMIT 50;


-- ---------------------------------------------------------
-- 3a) ORDER BY sorts results
-- Most recent purchase events first
-- ---------------------------------------------------------
SELECT event_date, event_timestamp, event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
ORDER BY event_timestamp DESC
LIMIT 20;


-- ---------------------------------------------------------
-- 3b) Readable timestamps
-- GA4 timestamps are in microseconds, so convert them
-- ---------------------------------------------------------
SELECT TIMESTAMP_MICROS(event_timestamp) AS event_time,
       event_name
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
ORDER BY event_timestamp DESC
LIMIT 10;


-- ---------------------------------------------------------
-- 4a) COUNT: total events in December 2020
-- ---------------------------------------------------------
SELECT COUNT(*) AS event_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201201' AND '20201231';


-- ---------------------------------------------------------
-- 4b) COUNT: purchase events in December 2020
-- ---------------------------------------------------------
SELECT COUNT(*) AS purchase_events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
  AND _TABLE_SUFFIX BETWEEN '20201201' AND '20201231';


-- ---------------------------------------------------------
-- 5a) GROUP BY: events by day in December 2020
-- ---------------------------------------------------------
SELECT event_date, COUNT(*) AS events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201201' AND '20201231'
GROUP BY event_date
ORDER BY event_date;


-- ---------------------------------------------------------
-- 5b) GROUP BY: top 15 event types in December 2020
-- ---------------------------------------------------------
SELECT event_name, COUNT(*) AS events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201201' AND '20201231'
GROUP BY event_name
ORDER BY events DESC
LIMIT 15;


-- ---------------------------------------------------------
-- 6) HAVING filters after grouping
-- Event types with at least 50,000 events in December 2020
-- ---------------------------------------------------------
SELECT event_name, COUNT(*) AS events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201201' AND '20201231'
GROUP BY event_name
HAVING COUNT(*) >= 50000
ORDER BY events DESC;


-- ---------------------------------------------------------
-- 7) Wildcard tables + _TABLE_SUFFIX
-- Events per day for December 1 to 7, 2020 only
-- ---------------------------------------------------------
SELECT event_date, COUNT(*) AS events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201201' AND '20201207'
GROUP BY event_date
ORDER BY event_date;
