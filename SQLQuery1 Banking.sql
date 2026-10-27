create database banking_sql_project
go
use banking_sql_project

-- 1 total row count
select count(*) as total_rows from dbo.bank_marketing


-- 2 Table ke columns aur data types verify karna.

SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'bank_marketing'
ORDER BY ORDINAL_POSITION;

-- 3: NULL Values Check (Agar age NULL hai to 1 Agar NULL nahi hai to 0

SELECT
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN job IS NULL THEN 1 ELSE 0 END) AS job_nulls,
    SUM(CASE WHEN marital IS NULL THEN 1 ELSE 0 END) AS marital_nulls,
    SUM(CASE WHEN education IS NULL THEN 1 ELSE 0 END) AS education_nulls,
    SUM(CASE WHEN [default] IS NULL THEN 1 ELSE 0 END) AS default_nulls,
    SUM(CASE WHEN balance IS NULL THEN 1 ELSE 0 END) AS balance_nulls,
    SUM(CASE WHEN housing IS NULL THEN 1 ELSE 0 END) AS housing_nulls,
    SUM(CASE WHEN loan IS NULL THEN 1 ELSE 0 END) AS loan_nulls,
    SUM(CASE WHEN contact IS NULL THEN 1 ELSE 0 END) AS contact_nulls,
    SUM(CASE WHEN day IS NULL THEN 1 ELSE 0 END) AS day_nulls,
    SUM(CASE WHEN month IS NULL THEN 1 ELSE 0 END) AS month_nulls,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_nulls,
    SUM(CASE WHEN campaign IS NULL THEN 1 ELSE 0 END) AS campaign_nulls,
    SUM(CASE WHEN pdays IS NULL THEN 1 ELSE 0 END) AS pdays_nulls,
    SUM(CASE WHEN previous IS NULL THEN 1 ELSE 0 END) AS previous_nulls,
    SUM(CASE WHEN poutcome IS NULL THEN 1 ELSE 0 END) AS poutcome_nulls,
    SUM(CASE WHEN y IS NULL THEN 1 ELSE 0 END) AS y_nulls
FROM dbo.bank_marketing;

-- 4 — unknown values check
select * from dbo.bank_marketing

select count(*) as unknown_count from dbo.bank_marketing
where job ='unknown'

-- 5 Saare unknown values check karna
SELECT
    SUM(CASE WHEN job = 'unknown' THEN 1 ELSE 0 END) AS job_unknown,
    SUM(CASE WHEN marital = 'unknown' THEN 1 ELSE 0 END) AS marital_unknown,
    SUM(CASE WHEN education = 'unknown' THEN 1 ELSE 0 END) AS education_unknown,
    SUM(CASE WHEN [default] = 'unknown' THEN 1 ELSE 0 END) AS default_unknown,
    SUM(CASE WHEN housing = 'unknown' THEN 1 ELSE 0 END) AS housing_unknown,
    SUM(CASE WHEN loan = 'unknown' THEN 1 ELSE 0 END) AS loan_unknown,
    SUM(CASE WHEN contact = 'unknown' THEN 1 ELSE 0 END) AS contact_unknown,
    SUM(CASE WHEN month = 'unknown' THEN 1 ELSE 0 END) AS month_unknown,
    SUM(CASE WHEN poutcome = 'unknown' THEN 1 ELSE 0 END) AS poutcome_unknown,
    SUM(CASE WHEN y = 'unknown' THEN 1 ELSE 0 END) AS y_unknown
FROM dbo.bank_marketing;


-- 6 Duplicate Check using GROUP BY
SELECT age,job,marital,education,balance,housing,loan,contact,day,month,duration,campaign,pdays,previous,poutcome,y,COUNT(*) AS duplicate_count
FROM dbo.bank_marketing
GROUP BY age,job,marital,education,balance,housing,loan,contact,day,month,duration,campaign,pdays,previous,poutcome,y
HAVING COUNT(*) > 1;

-- 7 category distribution samajhna
select * from dbo.bank_marketing

select job,count(*) as categories_count from dbo.bank_marketing
group by job
order by 2 desc


--8 
select marital,count(*) as marital_count from dbo.bank_marketing
group by marital
order by 2 desc

--9
select education,count(*) as education_count from dbo.bank_marketing
group by education
order by 2 desc

-- 10 

select [default],count(*) as default_count from dbo.bank_marketing
group by [default]
order by 2 desc

--11
select balance,count(*) as balance_count from dbo.bank_marketing
group by balance
order by 2 desc

-- 12
select housing,count(*) as housing_count from dbo.bank_marketing
group by housing
order by 2 desc
-- 13
select loan,count(*) as loan_count from dbo.bank_marketing
group by loan
order by 2 desc
--14
select contact,count(*) as contact_count from dbo.bank_marketing
group by contact
order by 2 desc

--15
select month,count(*) as month_count from dbo.bank_marketing
group by month
order by 2 desc

-- 16 Balance ke liye better query:
select MIN(balance)as min_balance,
       MAX(balance) as max_balance,
       AVG(balance)as avg_balance,
       sum(balance) as sum_balance
from dbo.bank_marketing

--17  Campaign Success Analysis
select * from dbo.bank_marketing

SELECT y,COUNT(*) AS customer_count,CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS percentage
FROM dbo.bank_marketing
GROUP BY y
ORDER BY customer_count DESC;

-- 18 Job-wise Campaign Response
SELECT
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY job
ORDER BY response_rate DESC;

--19 — Education-wise Campaign Response
SELECT
    education,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY education
ORDER BY response_rate DESC;

-- 20 Housing Loan vs Campaign Response
SELECT
    housing,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY housing
ORDER BY response_rate DESC;

--21 Step 21 — Personal Loan vs Campaign Response
SELECT
    loan,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY loan
ORDER BY response_rate DESC;


--- 22 — Housing + Personal Loan Combined Analysis
SELECT
    housing,
    loan,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY
    housing,
    loan
ORDER BY response_rate DESC;


--23 — Contact Method vs Campaign Response
SELECT
    contact,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY contact
ORDER BY response_rate DESC;


--24 Campaign Month vs Response Rate
SELECT
    month,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY month
ORDER BY response_rate DESC;


-- 25 — Age Group vs Campaign Response

SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,

    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS response_rate
    FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END
ORDER BY response_rate DESC;

--26 — Balance Group vs Campaign Response
SELECT
    CASE
        WHEN balance < 0 THEN 'Negative Balance'
        WHEN balance = 0 THEN 'Zero Balance'
        WHEN balance BETWEEN 1 AND 1000 THEN '1-1000'
        WHEN balance BETWEEN 1001 AND 5000 THEN '1001-5000'
        WHEN balance BETWEEN 5001 AND 10000 THEN '5001-10000'
        ELSE '10000+'
    END AS balance_group,
    COUNT(*) AS total_customers,
    SUM( CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,

    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0/ COUNT(*)AS DECIMAL(5,2)) AS response_rate
FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN balance < 0 THEN 'Negative Balance'
        WHEN balance = 0 THEN 'Zero Balance'
        WHEN balance BETWEEN 1 AND 1000 THEN '1-1000'
        WHEN balance BETWEEN 1001 AND 5000 THEN '1001-5000'
        WHEN balance BETWEEN 5001 AND 10000 THEN '5001-10000'
        ELSE '10000+'
    END
ORDER BY response_rate DESC;


--27 — Campaign Contact Duration vs Response
SELECT
    CASE
        WHEN duration < 120 THEN 'Less than 2 min'
        WHEN duration BETWEEN 120 AND 299 THEN '2-5 min'
        WHEN duration BETWEEN 300 AND 599 THEN '5-10 min'
        ELSE '10+ min'
    END AS duration_group,

    COUNT(*) AS total_customers,
    SUM( CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)AS DECIMAL(5,2)) AS response_rate

FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN duration < 120 THEN 'Less than 2 min'
        WHEN duration BETWEEN 120 AND 299 THEN '2-5 min'
        WHEN duration BETWEEN 300 AND 599 THEN '5-10 min'
        ELSE '10+ min'
    END
ORDER BY response_rate DESC;



-- 28 28 — Campaign Contacts vs Response
SELECT
    CASE
        WHEN campaign = 1 THEN '1 Contact'
        WHEN campaign BETWEEN 2 AND 3 THEN '2-3 Contacts'
        WHEN campaign BETWEEN 4 AND 5 THEN '4-5 Contacts'
        WHEN campaign BETWEEN 6 AND 10 THEN '6-10 Contacts'
        ELSE '11+ Contacts'
    END AS campaign_group,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)AS DECIMAL(5,2)) AS response_rate

FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN campaign = 1 THEN '1 Contact'
        WHEN campaign BETWEEN 2 AND 3 THEN '2-3 Contacts'
        WHEN campaign BETWEEN 4 AND 5 THEN '4-5 Contacts'
        WHEN campaign BETWEEN 6 AND 10 THEN '6-10 Contacts'
        ELSE '11+ Contacts'
    END
ORDER BY response_rate DESC;


--29 — Previous Contact Status vs Response
SELECT
    CASE
        WHEN pdays = -1 THEN 'Never Contacted'
        ELSE 'Previously Contacted'
    END AS previous_contact_status,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)AS DECIMAL(5,2)) AS response_rate

FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN pdays = -1 THEN 'Never Contacted'
        ELSE 'Previously Contacted'
    END

ORDER BY response_rate DESC;


-- 30 Number of Previous Contacts vs Response
SELECT
    CASE
        WHEN previous = 0 THEN 'No Previous Contact'
        WHEN previous BETWEEN 1 AND 2 THEN '1-2 Contacts'
        WHEN previous BETWEEN 3 AND 5 THEN '3-5 Contacts'
        ELSE '6+ Contacts'
    END AS previous_contact_group,

    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)AS DECIMAL(5,2)) AS response_rate

FROM dbo.bank_marketing
GROUP BY
    CASE
        WHEN previous = 0 THEN 'No Previous Contact'
        WHEN previous BETWEEN 1 AND 2 THEN '1-2 Contacts'
        WHEN previous BETWEEN 3 AND 5 THEN '3-5 Contacts'
        ELSE '6+ Contacts'
    END
ORDER BY response_rate DESC;

-- 31 Previous Campaign Outcome vs Current Response
SELECT
    poutcome,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS response_rate

FROM dbo.bank_marketing
GROUP BY poutcome
ORDER BY response_rate DESC;

--32 — Previous Campaign Status + Current Response
SELECT poutcome,y AS current_response,COUNT(*) AS customer_count,
    CAST(COUNT(*) * 100.0 /SUM(COUNT(*)) OVER (PARTITION BY poutcome)AS DECIMAL(5,2)) AS percentage
FROM dbo.bank_marketing
GROUP BY poutcome,y
ORDER BY poutcome,current_response;


--33 kitne customers ne deposit offer accept kiya aur kitne ne reject
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS rejected_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS response_rate
FROM dbo.bank_marketing;

-- 34 Kaunse job aur education wale customers campaign mein sabse achha response de rahe hai

SELECT
    job,
    education,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    CAST(SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS response_rate
FROM dbo.bank_marketing
GROUP BY job,education
HAVING COUNT(*) >= 100
ORDER BY response_rate DESC;

--35 Kaunse 5 job categories mein campaign response rate sabse zyada hai

WITH JobAnalysis AS
(
    SELECT
        job,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
)
SELECT TOP 5 *
FROM JobAnalysis
ORDER BY response_rate DESC;

--36 Response rate ke basis par har job category ka rank 

WITH JobAnalysis AS
(
    SELECT
        job,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
    )
SELECT
    job,total_customers,accepted_customers,response_rate,
    DENSE_RANK() OVER (ORDER BY response_rate DESC) AS response_rank
FROM JobAnalysis
ORDER BY response_rank;

--37 Har job category ko response rate ke basis par unique serial number

WITH JobAnalysis AS
(
    SELECT
        job,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
)
SELECT
    job,total_customers,accepted_customers,response_rate,
    ROW_NUMBER() OVER (ORDER BY response_rate DESC, job ASC) AS row_num
FROM JobAnalysis
ORDER BY row_num;

-- 38 Har education category ke andar kaunsi job ka response rate sabse zyada hai

WITH JobEducationAnalysis AS
(
    SELECT job,education,COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job, education
    HAVING COUNT(*) >= 100
)
SELECT
    job,education,total_customers,accepted_customers,response_rate,
    DENSE_RANK() OVER (PARTITION BY education ORDER BY response_rate DESC) AS education_rank
FROM JobEducationAnalysis
ORDER BY education, education_rank;

--39 Har job category ke response rate ko usse pehle wali job category ke response rate se compare

WITH JobAnalysis AS
(
    SELECT job,COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
)
SELECT
    job,total_customers,accepted_customers,response_rate,
    LAG(response_rate) OVER (ORDER BY response_rate DESC, job ASC) AS previous_response_rate
FROM JobAnalysis
ORDER BY response_rate DESC, job ASC;

--40 Response rate ke basis par ordered job categories mein current job ke baad aane wali job ka response rate kya hai

WITH JobAnalysis AS
(
    SELECT
        job,COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
)
SELECT job,total_customers,accepted_customers,response_rate,
    LEAD(response_rate) OVER (ORDER BY response_rate DESC, job ASC) AS next_response_rate
FROM JobAnalysis
ORDER BY response_rate DESC, job ASC;

--41 Job aur education ke combination mein kaunse customer segments ka response rate sabse zyada hai

WITH SegmentAnalysis AS
(
    SELECT
        job,education,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job, education
    HAVING COUNT(*) >= 100
),
RankedSegments AS
(
    SELECT
        job,education,total_customers,accepted_customers,response_rate,
        DENSE_RANK() OVER (ORDER BY response_rate DESC) AS segment_rank
    FROM SegmentAnalysis
)
SELECT TOP 5 *
FROM RankedSegments
ORDER BY response_rate DESC, job ASC, education ASC;

-- 42 Kaunsi job categories ka response rate sabhi job categories ke average response rate se zyada hai

SELECT
    job,total_customers,accepted_customers,response_rate FROM
(
    SELECT
        job,COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
) AS JobAnalysis
WHERE response_rate >
(
  SELECT AVG(job_response_rate)
    FROM
    (
       SELECT
            SUM(CASE WHEN y = 'yes' THEN 1.0 ELSE 0 END) * 100 / COUNT(*) AS job_response_rate
        FROM dbo.bank_marketing
        GROUP BY job
    ) AS AverageAnalysis
)
ORDER BY response_rate DESC;

-- 43 Har job category mein kaunse customers ne campaign accept kiya, aur us job ka total accepted customers kitna hai

SELECT
    b.job,b.education,b.age,b.y AS campaign_response,
    (
        SELECT COUNT(*)
        FROM dbo.bank_marketing AS b2
        WHERE b2.job = b.job
          AND b2.y = 'yes'
    ) AS job_accepted_customers
FROM dbo.bank_marketing AS b
WHERE b.y = 'yes'
ORDER BY job_accepted_customers DESC;

-- 44 Kaunse job categories mein kam se kam ek customer ne campaign accept kiya hai

SELECT DISTINCT
    b.job
FROM dbo.bank_marketing AS b
WHERE EXISTS
(
    SELECT 1
    FROM dbo.bank_marketing AS b2
    WHERE b2.job = b.job
      AND b2.y = 'yes'
)
ORDER BY b.job;

-- 45 Kya hum job-wise campaign performance ko baar-baar poori query likhe bina dekh sakte hain

CREATE VIEW dbo.vw_JobCampaignPerformance
AS
SELECT
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
    SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS rejected_customers,
    CAST(
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
        AS DECIMAL(5,2)
    ) AS response_rate
FROM dbo.bank_marketing
GROUP BY job;

--View se data dekhna
SELECT *
FROM dbo.vw_JobCampaignPerformance
ORDER BY response_rate DESC;

-- 46 Agar humein job ke basis par customers search karne hain, toh query performance kaise improve kar sakte hain
--Index create
CREATE NONCLUSTERED INDEX IX_bank_marketing_job
ON dbo.bank_marketing (job);

--Index ko test
SELECT *
FROM dbo.bank_marketing
WHERE job = 'student';

-- 47 job-wise campaign performance ki report ek saved 
--Stored Procedure create
CREATE PROCEDURE dbo.usp_JobCampaignPerformance
AS
BEGIN
    SELECT
        job,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        SUM(CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS rejected_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job
    ORDER BY response_rate DESC;
END;

-- Procedure execute

EXEC dbo.usp_JobCampaignPerformance;

--49 Kya bank_marketing table mein age, balance aur campaign response jaise columns ke andar invalid values
SELECT
    SUM(CASE WHEN age <= 0 THEN 1 ELSE 0 END) AS invalid_age,
    SUM(CASE WHEN job IS NULL OR LTRIM(RTRIM(job)) = '' THEN 1 ELSE 0 END) AS missing_job,
    SUM(CASE WHEN y NOT IN ('yes', 'no') OR y IS NULL THEN 1 ELSE 0 END) AS invalid_response,
    SUM(CASE WHEN campaign < 1 THEN 1 ELSE 0 END) AS invalid_campaign,
    SUM(CASE WHEN duration < 0 THEN 1 ELSE 0 END) AS invalid_duration
FROM dbo.bank_marketing;

--50 Kaunse job aur education segments mein response rate achha hai, aur jahan customers ki sankhya bhi sufficient hai

WITH SegmentAnalysis AS
(
    SELECT
        job,
        education,
        COUNT(*) AS total_customers,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS accepted_customers,
        CAST(
            SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            AS DECIMAL(5,2)
        ) AS response_rate
    FROM dbo.bank_marketing
    GROUP BY job, education
    HAVING COUNT(*) >= 100
)
SELECT
    job,
    education,
    total_customers,
    accepted_customers,
    response_rate,
    DENSE_RANK() OVER (ORDER BY response_rate DESC) AS segment_rank
FROM SegmentAnalysis
WHERE response_rate >= 15
ORDER BY response_rate DESC;


--51 unnecessary calculations aur data processing se bache
--Query 1 — Simple filter
SELECT job,age,balance,y
FROM dbo.bank_marketing
WHERE job = 'student';

--Query 2 — Same filter, lekin unnecessary columns ke bina
SELECT
    job,y
FROM dbo.bank_marketing
WHERE job = 'student';








