
# my_gym_book

A new Flutter project.

### Firebase analytics

Segue a lista de logs e seus parâmetros:

| Log                          | Parâmetros                                                                                                                                                                                                                                                     |
|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| welcome                      | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| apple_login_start            | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| google_plus_login_start      | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| facebook_login_start         | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| onboarding_start             | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| onboarding_finish            | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| signup_success               | {<br>&emsp;&emsp;"fullname": "Felipe Baz",<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                        |
| signin_success               | {<br>&emsp;&emsp;"fullname": "Felipe Baz",<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                        |
| forget_password              | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| home                         | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| group                        | {<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                 |
| group_create_start           | {<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                 |
| group_created                | {<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                 |
| group_details                | {<br>&emsp;&emsp;"groupId": "UUID String",<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                        |
| group_add_member_success     | {<br>&emsp;&emsp;"groupId": "UUID String",<br>&emsp;&emsp;"user_added": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                   |
| workout_details              | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_doing                | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| exercises                    | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| exercises_create_finish      | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| exercises_create_bad_request | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z",<br>&emsp;&emsp;"title": "Title",<br>&emsp;&emsp;"series": "series",<br>&emsp;&emsp;"repetitionCount": "repetitionCount",<br>&emsp;&emsp;"weight": "weight",<br>&emsp;&emsp;"interval": "interval"<br>} |
| workout_create_start         | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_create_finish        | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_update_start         | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_update_finish        | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout                      | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_error                | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z",<br>&emsp;&emsp;"error": "error"<br>}                                                                                                                                                                   |
| workout_without_data         | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| workout_delete               | {<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                                                                                                                    |
| group_workout_link_start     | {<br>&emsp;&emsp;"groupId": "UUID String",<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                                                                        |
| group_workout_link_finish    | {<br>&emsp;&emsp;"groupId": "UUID String",<br>&emsp;&emsp;"workoutId": "UUID String",<br>&emsp;&emsp;"email": "fbazmitsuishi@gmail.com",<br>&emsp;&emsp;"datetimeUTC": "2023-05-25T14:30:00Z"<br>}                                                             |