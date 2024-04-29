# Building an Azure Data Warehouse for Bike Share Data Analytics - using Azure Synapse Analytics

Divvy is a bike sharing program in Chicago, Illinois USA that allows riders to purchase a pass at a kiosk or use a mobile application to unlock a bike at stations around the city and use the bike for a specified amount of time. The bikes can be returned to the same station or to another station. The City of Chicago makes the anonymized bike trip data publicly available for projects like this where we can analyze the data. The dataset looks like this:

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/DB.png)

The goal of this project is to develop a data warehouse solution using Azure Synapse Analytics. We will:
- Design a star schema based on the business outcomes listed below;
- Import the data into Synapse;
- Transform the data into the star schema;
- and finally, view the reports from Analytics.

The business outcomes we are designing for are as follows:
1. Analyze how much time is spent per ride
  - Based on date and time factors such as day of week and time of day
  - Based on which station is the starting and / or ending station
  - Based on age of the rider at time of the ride
  - Based on whether the rider is a member or a casual rider
  
2. Analyze how much money is spent
  - Per month, quarter, year
  - Per member, based on the age of the rider at account start
  
3. Analyze how much money is spent per member
  - Based on how many rides the rider averages per month
  - Based on how many minutes the rider spends on a bike per month



## Getting Started
### Step1
Create your Azure resources
![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/postgresql.png)

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/creating%20synaps.png)

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/storage%20account.png)

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/Resources.png)

### Step2
Design a star schema
![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/Star%20Schema.png)

### Step3
Create the data in PostgreSQL

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/creating%20tables.png)

### Step4
EXTRACT the data from PostgreSQL

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/linked%20services.png)

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/task%204%20extract.png)

![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/ingested%20tables.png)

### Step5 
LOAD the data into external tables in the data warehouse
![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/Load%20staging%20table.png)

### Step6
TRANSFORM the data to the star schema using CETAS
![image](https://github.com/DanyaMawed/Azure-Data-Warehouse-Project/blob/dc4651ba27a615b1b429fb6a5b1d596de9cbfbbd/screen%20shots/Transform.png)

## License

[License](LICENSE.txt)
