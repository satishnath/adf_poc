# metadata-repository
Repo for the Metadata of a Metadata-driven Extraction Framework

# Development

## Project Setup
The objects of the Metadata Repository are defined within T-SQL scripts. The Metadata Repository's core is a __Microsoft SQL Server__, specifically an __Azure SQL Database__.

The T-SQL scripts when executed within the __Azure SQL Database__ create the database objects needed to store the metadata used by & for the Metadata-driven Extraction Framework in the database.

The various database objects' scripts are grouped based on the object's type (_views, tables, schemas, roles, etc._). Some objects, which also have a schema, are further split into sub-groups based on their schemas. These sub-groups are sub-folders within the main folder, which is the type of the database objects:
 - Table `[metadata].[SourceSystem]` --> `app/tables/metadata/SourceSystem.sql`
 - Schema `[metadata]` --> `app/schemas/schemas.sql`
 - View `[metadata].[vw_CompletedJobs]` --> `app/views/metadata/vw_CompletedJobs.sql`

## Extend
To extent or further develop the project, follow the current convention of grouping the new objects' SQL scripts into the main (_based on the type of the object_) & sub-folders (_based on the schema of the object, if it has one_).

# Deployment
The deployment is the execution of the T-SQL scripts __in the following order__:

## Schemas
Execute the SQL scripts in the `app/schemas` folder, to create the schemas which will contain the Metadata Repository's objects.

## Roles
Execute the SQL scripts in the `app/roles` folder, to create the roles with the proper permissions, that'll be assigned to the users - both actual & technical - of the Metadata Repository.

## Users
Execute the SQL scripts in the `app/users` folder, to create the users - both actual & technical - of the Metadata Repository with the proper roles.

## Tables
Execute the SQL scripts in the `app/tables` folder & its subfolders, to create the table objects of the Metadata Repository.

## Views
Execute the SQL scripts in the `app/views` folder & its subfolders, to create the view objects of the Metadata Repository.

## Programmability
Execute the SQL scripts in the `app/programmability` folder & its subfolders, to create the function & stored procedure objects of the Metadata Repository.