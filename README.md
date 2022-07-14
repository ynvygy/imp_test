How to install/use
1. bundle install
2. rails db:create
3. rails db:migrate
4. rails s
5. go to localhost:3000 and input a post code

Initial requirements
1. This should be a full Ruby on Rails project with, model(s), controller(s), view(s) – and anything else you feel is required.
2. The site should tell the end user whether today is going to be Hot, Warm, or Cold based on the postcode they enter.
3. The application will persist the definitions of Hot, Warm and Cold these can be changed over time but should always exist.
4. There should only be one definition for each of Hot, Warm and Cold in the application.
5. A user will enter the postcode of the area they are interested in and the application will tell them whether it will be Hot, Warm, or Cold today.
6. The application will use a weather API to get the maximum temperature for the required area. Details below.
7. The customer is only interested in providing information for UK postcodes. The application should check that the response from the API is for the UK.
8. The application should be robust.
9. There can be no guarantee the user will enter the format of the postcode correctly or that they will type a valid postcode.

Comments based on the initial requirements
1. point 1 -> there was no need for model(s)
2. points 3 & 4 -> I made an assumption here that we actually only need to set the values for 'Warm'. I didn't see the point in defining them all 

Things that could be improved
1. Tests, especially the DRY part
2. A refactoring towards the ApiService perhaps
3. Catching potential api crashes with a begin/rescue

Other notes
1. Time spent ~2h 50m
