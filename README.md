#How to make this run?

##Backend

The Backend Code is in *./backend*.

You should place it on a server with php and a mysql-database.

Add your database credentials to *./backend/config/database.php*, for that the code can acces your database.

To set up the database import *./backend/ecal_db.sql* in phpmyadmin.

##Frontend

The frontend Code is in ./

First add the url where the backend-code ishosted to *./App.js*:
Write the url there to this.state = { host: [YOURHOSTHERE]}.

To add the frontend-code to the server copy all ements from ./build to the root directory ./ of the server.

To run the frontend locally,  run **npm start** in a console in ./.
Note: Frontend-code and backend have to be on the same server, since Cross-Origin is not allowed.

To make a new build run **npm run build** in ./, then again copy the content of .*/build/* to the root of the server.


