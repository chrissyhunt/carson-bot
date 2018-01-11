# Welcome to CarsonBot!

CarsonBot is a versatile home inventory management system built using Sinatra, ActiveRecord, ActiveSupport, bcrypt, and Rack Flash.


## Installation

Run ``bundle install`` to install all required gems.


## To Run Locally

Run ``shotgun`` in root directory. (Default port is 9393. Application will error if port is in use.)

Open browser and navigate to http://localhost:9393/. Application landing page will appear.


## File Structure

``config.ru`` - Specifies files to use and run.

``/config`` - Contains ``environment.rb``, which establishes database connection and contains custom ``ActiveSupport::Inflector`` specifications.

``/app`` - Contains Sinatra MVC files for app.

``/db`` - Contains database, migrations, and seeds.

``/public`` - Contains custom CSS and UI assets.


## Routes and Features

``/`` - Landing page, will direct you to log in or sign up.

``/users`` - Shows the logged in user's home dashboard, with a summary of the user's available items and lists.

``/locations`` - Shows all of a logged in user's items organized by location. Users can select one of the provided default locations (which are protected from editing) when creating a new item, or create their own custom location. Custom locations are automatically deleted when they have no items assigned to them.

``/categories`` - Shows all of a logged in user's items organized by category. Users can select one of the provided default categories (which are protected from editing) when creating a new item, or create their own custom categories. Custom categories are automatically deleted when they have no items assigned to them.

``/lists`` - Shows all lists belonging to a user. Users can create entirely customized lists, or automatically generate new lists from several default list type (e.g. "Shopping List"), which will auto-populate the list with items based on each item's stored data. Lists can be deleted by the user, and will also automatically be deleted when they have no list items assigned to them.


## Disclaimer

Downton Abbey and the character of Carson the Butler are not my property. This is a non-profit student portfolio project and is in no way affiliated with the Downton Abbey TV show or its owners.
