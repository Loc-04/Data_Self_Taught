OLTP : Online Transaction Processing
- Keyword : ACID Compliance, Normalization
- Optimize for Write operation such as INSERT, UPDATE, DELETE
- Azure Map : Azure SQL Database, PostgreSQL on Azure

OLAP : Online Analytical Processing
- Keyword : Denormalization, Columnar Storage
- Optimize for read operation such as SELECT, Aggerate
- Azure Map : Azure Synapse Analytics (Dedicated SQL Pool)

Star Schema is used for better understanding for human, also faster for computer to retrieve.
Including Fact table as center and Dimension table around and connect to that center :\
- Fact table :
  - Contain key to dimensional table
  - Contain numbers for kind of "How much" question
  - Have more rows
- Dimensional table :
  - Contain answer for kind of "What-Who-Where-When" question
  - Used to filter data
  - Have more columns

Data Mart is to answer only 1 subject or area
Surrogate Key is a fake simple integer number to replace the complex original index
Write Dim_ to remind that table is a dimensional one, which hold descriptive data
Write Fact_ to remind that table is a center one, which hold numeric measurement

To identify the fact and dimensional table base on scenario
- What happened, what action  - > Fact table
  - Each row represent for what action ? Ex : For hotel, a booking
  - What need to be measured in that action ? Ex : For hotel, how long does it last, how much does it cost, how much is the discount
  - > Fact table will include these measured number

  - Apply the 4W-question for dimensional table, each for each, group them by their own attribute


Using SQL Set Operations instead of for loop for faster and bigger dataset
- Instead of execute the same query again and again which cost more, we can just add those rows into a staging table then run only 1 query to execute all
- To solve this issue, we using MERGE sentence inn SQL Server (the same logic in Spark)
- Enterprise Process :
  - Extract : Python read file, push row into a stage table by using pandas.to_sql(chunksize)
  - Transform & Load : Python call to a stored procedure which include MERGE for auto-update, insert

In SQL, SET is only use in UPDATE, and SELECT is use in INSERT
Use CAST(<Field> AS <data_type>) to change data type of something need to compare