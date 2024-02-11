--Test queries to look at the data. Data can be found https://ourworldindata.org/coronavirus
--SELECT *
--FROM PortfolioProjectCovid..CovidDeaths$
--Order by location, date

--SELECT *
--FROM PortfolioProjectCovid..CovidVaccinations$
--Order by location, date

--Select data we will be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProjectCovid..CovidDeaths$
Order by location, date

--Total Cases vs Total Deaths 
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectCovid..CovidDeaths$
Order by location, date

--Leads to error because total deaths is nvarchar for some reason. Altered Column
--Alter table PortfolioProjectCovid..CovidDeaths$ alter column total_cases float null
--Alter table PortfolioProjectCovid..CovidDeaths$ alter column total_deaths float null
Alter table PortfolioProjectCovid..CovidVaccinations$ alter column new_vaccinations float null

--Looking at the United States for the likelihood of dying in the country if contracting Covid
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjectCovid..CovidDeaths$
where location = 'United States' AND 
total_cases is not null 
Order by location, date

--Looking at total cases vs population. Which percentage got covid
SELECT location, date, total_cases, Population, (total_deaths/population)*100 as ContractedPercentage
FROM PortfolioProjectCovid..CovidDeaths$
where location = 'United States' AND 
total_cases is not null 
Order by location, date

--Countries with highest infection rates compared to population. Needs group by.
SELECT location, Population, MAX(total_cases) as HighestCases,  Max((total_cases/population))*100 as ContractedPercentage
FROM PortfolioProjectCovid..CovidDeaths$
Group by location, population
Order by ContractedPercentage desc

--Showing Countries with Highest Death Rate per Population
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProjectCovid..CovidDeaths$
Where continent is not null
Group by location
Order by TotalDeathCount desc


--SELECT location, MAX(total_deaths) as TotalDeathCount
SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProjectCovid..CovidDeaths$
Where continent is not null
Group by continent
Order by TotalDeathCount desc


--Total population vs vaccinations.
Select death.continent, death.location, death.date, death.population, vacs.new_vaccinations
FROM CovidDeaths$ death
	Join CovidVaccinations$ vacs
	On death.location = vacs.location
	and death.date = vacs.date
Where death.continent is not null
order by continent, location, date


---Rolling count of vaccinations over the days. Can also use Cast or Convert instead of alter table.
Select death.continent, death.location, death.date, death.population, vacs.new_vaccinations,
SUM(vacs.new_vaccinations) OVER (Partition by death.location Order by death.location, death.date) as RollingCount
FROM CovidDeaths$ death
	Join CovidVaccinations$ vacs
	On death.location = vacs.location
	and death.date = vacs.date
Where death.continent is not null
order by 2,3

--CTE Where we look at vaccinations for Covid compared to the entire population. Number of columns must match in CTE and Select.
With VactoPop (Continent, Location, Date, Population,New_Vaccinations, RollingCount)
as
(
Select death.continent, death.location, death.date, death.population, vacs.new_vaccinations,
SUM(vacs.new_vaccinations) OVER (Partition by death.location Order by death.location, death.date) as RollingCount
FROM CovidDeaths$ death
	Join CovidVaccinations$ vacs
	On death.location = vacs.location
	and death.date = vacs.date
Where death.continent is not null

)
Select *, (RollingCount/Population)*100
FROM VactoPop

--Temp Table to look at the same
DROP Table if exists #PercentPopulationVaccinated
CREATE Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingCount numeric
)

Insert into #PercentPopulationVaccinated
Select death.continent, death.location, death.date, death.population, vacs.new_vaccinations,
SUM(vacs.new_vaccinations) OVER (Partition by death.location Order by death.location, death.date) as RollingCount
FROM CovidDeaths$ death
	Join CovidVaccinations$ vacs
	On death.location = vacs.location
	and death.date = vacs.date
Where death.continent is not null

Select *, (RollingCount/Population)*100
From #PercentPopulationVaccinated


--Creating view to store for later visual. Related to Tableau
Create View PercentPopulationVaccinated as
Select death.continent, death.location, death.date, death.population, vacs.new_vaccinations,
SUM(vacs.new_vaccinations) OVER (Partition by death.location Order by death.location, death.date) as RollingCount
FROM CovidDeaths$ death
	Join CovidVaccinations$ vacs
	On death.location = vacs.location
	and death.date = vacs.date
Where death.continent is not null

--Query off view
SELECT *
FROM PercentPopulationVaccinated