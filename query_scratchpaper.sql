-- Which county has the most spending overall per capita?
SELECT county
    , AVG(population) AS population
    , SUM(total_drug_cost) AS total_drug_spending
FROM prescription AS rx
    LEFT JOIN prescriber ON rx.npi = prescriber.npi
    JOIN zip_fips AS zf ON prescriber.nppes_provider_zip5 = zf.zip
    JOIN population AS pop ON zf.fipscounty = pop.fipscounty
    JOIN fips_county AS fc ON pop.fipscounty = fc.fipscounty
GROUP BY county;

-- Which county has the highest overdose deaths per capita?
SELECT county
, AVG(overdose_deaths) AS avg_od_deaths
, AVG(population) AS population
FROM overdose_deaths AS odd
    JOIN fips_county AS fc ON odd.fipscounty = fc.fipscounty::int
    LEFT JOIN population AS pop ON odd.fipscounty = pop.fipscounty::int
GROUP BY county;

-- Which county has the most spending on opioids per capita?
SELECT county
    , AVG(population) AS population
    , SUM(total_drug_cost) AS total_opioid_spending
FROM prescription AS rx
    LEFT JOIN prescriber ON rx.npi = prescriber.npi
    JOIN zip_fips AS zf ON prescriber.nppes_provider_zip5 = zf.zip
    JOIN population AS pop ON zf.fipscounty = pop.fipscounty
    JOIN fips_county AS fc ON pop.fipscounty = fc.fipscounty
    LEFT JOIN drug ON rx.drug_name = drug.drug_name
WHERE opioid_drug_flag = 'Y'
GROUP BY county;