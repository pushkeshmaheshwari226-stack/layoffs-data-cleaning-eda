-- DATA CLEANING 
SELECT * FROM layoffs;

CREATE TABLE layoffs1
LIKE layoffs;

INSERT INTO layoffs1
SELECT * FROM layoffs;

SELECT * FROM layoffs1;

-- ASSIGN ROW NUMBERS TO layoff1 
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
FROM layoffs1;

WITH duplicate_cte AS
(
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
	FROM layoffs1
)
SELECT * FROM duplicate_cte
WHERE row_num > 1 ;

-- CREATING A NEW TABLE TO DELETE THE DUPLICATE VALUES 
CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs2;

INSERT INTO layoffs2
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
	FROM layoffs1;
    
SELECT * FROM layoffs2
WHERE row_num> 1;

-- DELETING THE DUPLICATE VALUES 
DELETE FROM layoffs2
WHERE row_num> 1;

-- STANDARDIZING THE DATA 
SELECT * FROM layoffs2;

SELECT company FROM layoffs2
ORDER BY 1;
-- REMOVING THE WHITE SPACES 
UPDATE layoffs2
SET company=TRIM(company);

SELECT DISTINCT industry FROM layoffs2
ORDER BY 1;

SELECT * FROM layoffs2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs2
SET industry='Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location FROM layoffs2
ORDER BY 1;

SELECT DISTINCT country FROM layoffs2
ORDER BY 1; # THERE IS ONE ISSUE IN THIS United States IS WRITTEN AS United States. IN ONE PLACE 

UPDATE layoffs2
SET country = 'United States'
WHERE country LIKE 'United States%';

-- CHANGE DATA TYPE OF DATE ( FROM TEXT TO DATE DATA TYPE )
SELECT `date` 
-- STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs2;

UPDATE layoffs2
SET `date`= STR_TO_DATE(`date`,'%m/%d/%Y'); # its still a text to convert it into a date data type we do alter 

ALTER TABLE layoffs2
MODIFY COLUMN `date` DATE;

-- FINDING NULLS AND BLANKS 
SELECT * FROM layoffs2;

SELECT * FROM layoffs2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

SELECT * FROM layoffs2
WHERE industry IS NULL OR industry='';

SELECT * FROM layoffs2
WHERE company LIKE 'Bally%';

-- CHANGE IT TO NULL BEFORE POPULATING IT 
UPDATE layoffs2
SET industry = NULL
WHERE industry='';

-- FILLING BLANK VALUES USING THE OTHER DATA 

SELECT t1.industry,t2.industry FROM layoffs2 t1
JOIN layoffs2 t2 
	ON t1.company=t2.company AND t1.location=t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL ;

UPDATE layoffs2 t1
JOIN layoffs2 t2 
	ON t1.company=t2.company AND t1.location=t2.location
SET t1.industry=t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL ;

-- FOR TOTAL LAID OFF AND PERCENTAGE LAID OFF IF WE HAD THE TOTAL WE COULD DO SOME CALCULATION AND FOR FUNDS RAISED WE CAN GO WEB-SCRAPPING 
SELECT * FROM layoffs2;

SELECT * FROM layoffs2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- DELETING THEM 
DELETE FROM layoffs2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- REMOVING EXTRA COLUMNS 
ALTER TABLE layoffs2
DROP COLUMN row_num;
