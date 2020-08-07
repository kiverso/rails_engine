
# README

## Technologies:
### Rails 5.2.4
### Ruby 2.5.3
### PostgreSQL


## Rails Engine

This project is a rest API for a hypothetical ecommerce platform. The REST API allows you to create, update, read, and delete merchants and items from the database.

## CRUD
### Items 
GET `api/v1/items` returns all items

GET `api/v1/items/<item id>` returns the item with the corresponding item id. (replace <item id> with the item's id)
  
POST `api/v1/items` will create a new item. Required parameters for this request are `name`, `description`, `unit_price` and `merchant_id`. `merchant_id` must be a valid id of a merchant in the database. This will return the new item upon successful creation.

PATCH `api/v1/items/<item id>` will update an item based on the parameters passed in. The following parameters can be updated through this request: `name`, `description`, `unit_price`, `merchant_id`. Like with item creation, the merchant_id must be a valid merchant id. This will return the new item upon successful update.

### Merchants
GET `api/v1/merchants` returns all merchants

GET `api/v1/merchants/<item id>` returns the merchant with the corresponding merchant id. (replace <merchant id> with the merchant's id)
  
POST `api/v1/merchants` will create a new merchant. Required parameters for this request are `name`. This will return the new item upon successful creation.

PATCH `api/v1/merchants/<item id>` will update an item based on the parameters passed in. The following parameters can be updated through this request: `name`. This will return the new item upon successful update.

## Search
The API also allows for search functionality through the find and find_all endpoints. All find and find_all endpoints are accessed through GET requests

`api/v1/items/find?<attribute>=<search term>` will return the first result matching the search criteria. For example `api/v1/items/find?name=lorem` will return the first item that has a name which includes the string `'lorem'` 

`api/v1/items/find_all?<attribute>=<search term>` will return all results matching the search criteria. For example `api/v1/items/find_all?name=lorem` will return all items that have a name which includes the string `'lorem'`

search endpoints also exist for merchants. The merchant search endpoints function the same as the item search endpoints, but will call `api/v1/merchants/find?<attribute>=<search_term>` and `api/v1/merchants/find?<attribute>=<search_term>` for find, and find_all respectively.

All search endpoints can accept multiple parameters in the following format: `api/v1/items/find_all?<attribute>=<search term>&<another attribute>=<another search term>`. Example: `api/v1/items/find_all?name=lorem&unit_price=693`

Currently the following parameters are supported for the search endpoints:

Item: `name`, `description`, `unit_price`, `merchant_id`, `created_at` and `updated_at`

Merchant: `name`, `created_at` and `updated_at`

## Business Inteligence
The API also includes a few endpoints for business inteligence. All Business inteligence endpoints are accessed through a GET request.

`/api/v1/merchants/most_revenue?quantity=<result limit>` will return the merchants with the most revenue. The quantity parameter controlls how many results you get back. for example `/api/v1/merchants/most_revenue?quantity=5` will return the top 5 merchants with the highest revenue in descending order. `/api/v1/merchants/most_revenue?quantity=1` will return the highest revenue merchant.

### Custom Rake task
This repo also contains a custom rake task to seed the database with entries from csv files. Upon creating these database items, the rake task will reset the database index sequence so that it will pick back up at the proper place when you create new database resources through the API.



### Schema
![Database Schema](
https://user-images.githubusercontent.com/54010239/88701369-2a010280-d0c7-11ea-8879-982e761c231f.png)

### Getting Started
1.  Fork and clone this repo.

2.  Run `Bundle Install` in this repository.

3.  run `rake import_from_csv` to populate the database with data from the csv files in the csv_seeds folder.

4. Run `rails s` in your terminal.

5. Start using the API with your client of choice such as [Postman](https://www.postman.com/).





