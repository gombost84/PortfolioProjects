--Get a feel of the dataset
--Filtering out everything that is not a country to get global stats

SELECT location, MAX(CAST(total_deaths AS INT)) as TotalDeaths
FROM PortfolioProject..CovidDeaths$

WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'International')

GROUP BY location
ORDER BY TotalDeaths desc


--The ones that are countries have continent as NOT NULL so, it's easier to filter on that
--There are some weird datatypes too so cast is needed

SELECT location, MAX(CAST(total_deaths AS INT)) as TotalDeaths
FROM PortfolioProject..CovidDeaths$

WHERE continent IS NOT NULL

GROUP BY location
ORDER BY TotalDeaths desc

--Create a window to have cumulative stats

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc

FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date

WHERE cd.continent = 'Europe'
ORDER BY cd.continent, cd.location, cd.date

--Create CTE to be used to further explore the data

WITH my_table (Continent, Country, Date, Population, NewVaccinations, RollingTotalVacc) as

(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'
)

SELECT *, (RollingTotalVacc/Population)*100 AS PopPercentVaxxed
FROM my_table
ORDER BY Country, Date

--Create temporary table in case CTE is not sufficient

DROP TABLE IF EXISTS #my_temp_table
CREATE TABLE #my_temp_table

(
Continent nvarchar(255),
Country nvarchar(255),
Date datetime,
Population numeric,
NewVaccinations numeric,
RollingTotalVacc numeric
)

INSERT INTO #my_temp_table
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'

SELECT TOP (500) *
FROM #my_temp_table

--Create views for visualisation
--Continent level view

USE PortfolioProject
GO

CREATE VIEW WorkingView AS
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'

SELECT TOP (50) *
FROM WorkingView
GROUP BY continent, location, date, population, new_vaccinations, TotalVacc
ORDER BY location, date
=======
--Get a feel of the dataset
--Filtering out everything that is not a country to get global stats

SELECT location, MAX(CAST(total_deaths AS INT)) as TotalDeaths
FROM PortfolioProject..CovidDeaths$

WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'International')

GROUP BY location
ORDER BY TotalDeaths desc


--The ones that are countries have continent as NOT NULL so, it's easier to filter on that
--There are some weird datatypes too so cast is needed

SELECT location, MAX(CAST(total_deaths AS INT)) as TotalDeaths
FROM PortfolioProject..CovidDeaths$

WHERE continent IS NOT NULL

GROUP BY location
ORDER BY TotalDeaths desc

--Create a window to have cumulative stats

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
SUM(CAST(cv.new_vaccinations AS INT)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc

FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date

WHERE cd.continent = 'Europe'
ORDER BY cd.continent, cd.location, cd.date

--Create CTE to be used to further explore the data

WITH my_table (Continent, Country, Date, Population, NewVaccinations, RollingTotalVacc) as

(
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'
)

SELECT *, (RollingTotalVacc/Population)*100 AS PopPercentVaxxed
FROM my_table
ORDER BY Country, Date

--Create temporary table in case CTE is not sufficient

DROP TABLE IF EXISTS #my_temp_table
CREATE TABLE #my_temp_table

(
Continent nvarchar(255),
Country nvarchar(255),
Date datetime,
Population numeric,
NewVaccinations numeric,
RollingTotalVacc numeric
)

INSERT INTO #my_temp_table
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'

SELECT TOP (500) *
FROM #my_temp_table

--Create views for visualisation
--Continent level view

USE PortfolioProject
GO

CREATE VIEW WorkingView AS
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, SUM(CONVERT(INT, cv.new_vaccinations)) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) as TotalVacc
FROM PortfolioProject..CovidDeaths$ cd
JOIN PortfolioProject..CovidVaccinations$ cv
    ON cd.location = cv.location
    and cd.date = cv.date
WHERE cd.continent = 'Europe'

SELECT TOP (50) *
FROM WorkingView
GROUP BY continent, location, date, population, new_vaccinations, TotalVacc
ORDER BY location, date
