-- EXPLORATORY DATA ANALYSIS 
SELECT * FROM layoffs2;

SELECT MAX(total_laid_off),MAX(percentage_laid_off) FROM layoffs2;

SELECT * FROM layoffs2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;	

SELECT company, SUM(total_laid_off) FROM layoffs2
GROUP BY company
ORDER BY 2 DESC ;

SELECT MIN(`date`),MAX(`date`) FROM layoffs2;

SELECT industry, SUM(total_laid_off) FROM layoffs2
GROUP BY industry
ORDER BY 2 DESC ;

SELECT country, SUM(total_laid_off) FROM layoffs2
GROUP BY country
ORDER BY 2 DESC ;

SELECT `date`, SUM(total_laid_off) FROM layoffs2
GROUP BY `date`
ORDER BY 2 DESC ;

SELECT YEAR(`date`) , SUM(total_laid_off) FROM layoffs2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT stage , SUM(total_laid_off) FROM layoffs2
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`,1,7) AS `MONTH` , SUM(total_laid_off) FROM layoffs2
WHERE SUBSTRING(`date`,1,7)  IS NOT NULL 
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- USING CTE FOR ROLLING TOTAL 
WITH Rolling AS 
(
	SELECT SUBSTRING(`date`,1,7) AS `MONTH` , SUM(total_laid_off) TotalSum FROM layoffs2
	WHERE SUBSTRING(`date`,1,7)  IS NOT NULL 
	GROUP BY `MONTH`
	ORDER BY 1 ASC
)
SELECT `MONTH` , TotalSum , SUM(TotalSum) OVER(ORDER BY `MONTH`) AS rolling_total
FROM ROLLING TOTAL;

SELECT company, YEAR(`date`), SUM(total_laid_off) FROM layoffs2
GROUP BY company , YEAR(`date`)
ORDER BY 1 ASC ;

-- ORDER IT IN WAY YEARS ARE LIKE 2021 ALL TOGETHER AND SUM ACCORDINGLY 
WITH Company_Year(comapany, years , total_laid_off) AS 
(
	SELECT company, YEAR(`date`) , SUM(total_laid_off) FROM layoffs2
    WHERE YEAR(`date`) IS NOT NULL
	GROUP BY company , YEAR(`date`)
),
Company_year_rank AS
(
SELECT * , DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC ) AS ranks
FROM Company_Year
)
SELECT * FROM Company_year_rank
WHERE ranks <= 5;