DECLARE @CountryList table
(
Country varchar(30)
)

INSERT INTO @CountryList
VALUES
('Austria'), ('Belgium'), ('Bulgaria'),
('Croatia'), ('Cyprus'), ('Czechia'),
('Denmark'), ('Estonia'), ('Finland'),
('France'), ('Germany'), ('Greece'),
('Hungary'), ('Ireland'), ('Italy'),
('Latvia'), ('Lithuania'), ('Luxembourg'),
('Malta'), ('Netherlands'), ('Poland'),
('Portugal'), ('Romania'), ('Slovakia'),
('Slovenia'), ('Spain'), ('Sweden'),
('EU')

SELECT co.Year, co.Entity, SUM(co.TotalPerCapita) OVER (PARTITION BY co.Entity ORDER BY co.Year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Total
FROM PortfolioProject..co2$ co
UNION
SELECT co.Year, 'EU', AVG(co.TotalPerCapita) OVER (PARTITION BY Year)
FROM PortfolioProject..co2$ co
JOIN @CountryList cl
	ON co.Entity = cl.Country