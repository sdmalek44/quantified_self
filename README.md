# Quantified Self  
Quantified self is an API built in rails that provides information on tracking a users meals, foods, and calories in the form of JSON data. The API also provides the users favorite foods and meals associated with them. The API allows CRUD functions to be performed on meals and foods. The purpose is to provide the bare bones json data for a meal tracking application that a front end can be built on top of easily.  

## Heroku  
* visit https://quantified-self-.herokuapp.com/

## Setup Locally  
Clone down repo locally and move into it
```
$ git clone https://github.com/sdmalek44/quantified_self.git  
$ cd quantified_self
``` 
Install Gems  
``` 
$ bundle install
``` 
Seed the database  
``` 
$ rake db:{create,migrate,seed} 
```  
Start Local Server 
```
$ rails s 
``` 
Go to `localhost:3000` in browser  
Endpoints are accessed by adding them to end of `localhost:3000`  
  
## Setup Using Docker  
Must have docker installed locally https://docs.docker.com/v17.12/docker-for-mac/install/  
```
$ git clone https://github.com/sdmalek44/quantified_self.git  
$ cd quantified_self 
$ git fetch origin
$ git checkout -b docker origin/docker
(start docker)
$ docker-compose up 
```
Go to `localhost:3000` in browser  
Endpoints are accessed by adding them to end of `localhost:3000`  
```
(stop docker)
$ docker-compose down 
``` 

## Endpoints  
### Food Endpoints:   

  
#### GET /api/v1/foods

Returns all foods currently in the database  
``` 
[
  {
      "id": 1,
      "name": "Banana",
      "calories": 150
  },
  {
      "id": 2,
      "name": "Donut",
      "calories": 450
  }
]
``` 
  
#### GET /api/v1/foods/:id  

Returns the food object with the specific :id you’ve passed in or 404 if the food is not found  
  
 
#### POST /api/v1/foods 
Allows creating a new food with the parameters:  
``` 
{ "food": { "name": "Name of food here", "calories": "Calories here"} }  
```
If food is successfully created, the food item will be returned. If the food is not successfully created, a 400 status code will be returned. Both name and calories are required fields.  
#### DELETE /api/v1/foods/:id 

Will delete the food with the id passed in and return a 204 status code. If the food can’t be found, a 404 will be returned.  
  
### Meal Endpoints:  

#### GET /api/v1/meals
 
Returns all the meals in the database along with their associated foods  
```
[
    {
        "id": 1,
        "name": "Breakfast",
        "foods": [
            {
                "id": 1,
                "name": "Banana",
                "calories": 150
            }
        ]
    },
    {
        "id": 2,
        "name": "Snack",
        "foods": [
            {
                "id": 9,
                "name": "Gum",
                "calories": 50
            }
        ]
    }
[
``` 

#### GET /api/v1/meals/:meal_id/foods
  
Returns all the foods associated with the meal with an id specified by :meal_id or a 404 if the meal is not found
```
{
    "id": 1,
    "name": "Breakfast",
    "foods": [
        {
            "id": 6,
            "name": "Yogurt",
            "calories": 550
        },
        {
            "id": 12,
            "name": "Apple",
            "calories": 220
        }
    ]
}
```

#### POST /api/v1/meals/:meal_id/foods/:id 

Adds the food with :id to the meal with :meal_id. If the meal/food cannot be found, a 404 will be returned.
If successful, returns a status code of 201 with following body:  
```
{
    "message": "Successfully added FOODNAME to MEALNAME"
}
```

#### DELETE /api/v1/meals/:meal_id/foods/:id

Removes the food with :id from the meal with :meal_id. If meal/food cannot be found, a 404 will be returned.  
```
{
    "message": "Successfully removed FOODNAME to MEALNAME"
}
```
### Favorites Endpoints:  
#### GET /api/v1/favorite_foods  

Retrieves data on the foods which were eaten most frequently. Includes 3 highest timesEaten values if greater than 1.  
```
[
  {
    "timesEaten": 4,
    "foods":
      [
        {
          "name": "Banana",
          "calories": 200,
          // since Bananas were eaten 4 times but only two meals
          // are in this array, this would mean that Banana was eaten
          // more than once in at least each meal
          "mealsWhenEaten": ["Breakfast", "Dinner"]
        },
  },
  "timesEaten": 3,
  "foods":
    [
      {
        "name": "Strawberries",
        "calories": 200,
        "mealsWhenEaten": ["Breakfast", "Lunch", "Dinner"]
      },
      {
        "name": "Almonds"
        "calories": 800,
        // Since almonds were eaten three times but snacks is the
        // only meal in this array, this would mean that almonds were
        // only eaten as snacks, but three times.
        "mealsWhenEaten": ["Snacks"]
      }
    ]
    ]
  }
  // `"timesEaten": 2` is not listed here because in this example,
  // no snack was eaten exactly two times.
]
```

