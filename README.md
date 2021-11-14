### Covid-19 statistics visualized

I downloaded the original dataset from here: https://ourworldindata.org/covid-deaths.

I then created two separate files from this which can be found in the 'datasets' folder.
I loaded them into a Microsoft SQL server and ran the queries found in the 'queries' folder.

I repeated the same in Azure Data Studio because it has an integrated Jupyter Notebook and included those files in the 'queries' folder too.
Here, I ran into a problem where if I download the files from Azure, then the NULL values are converted to zeros which can mess up the Tableau visualization.

I then loaded the excel files into Tableau and created a dashboard that can be seen here: https://public.tableau.com/app/profile/gombos2167/viz/PortfolioProject_16351937521390/Dashboard1

Or as a picture file:

![tableau](https://user-images.githubusercontent.com/72688410/141692475-162b6dc5-8316-4464-af48-877b0df046fb.png)
