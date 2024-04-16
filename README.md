# Social Media Post Application
### Swift project using application flow for any sample scoial media app


![social-media-app](https://raw.githubusercontent.com/kishorepran/social-media-app/master/social-media-demo.gif)


## About the application
The app consists of 2 screens, where the user can see the list of posts. we have used a select author button at the top of the page to help support switch between authors internally, also we have provided a ahndy switcher at the bottm of the screen to help users switch from one user view to other. i.e. see posts from all users vs. see post from my self only. Note that this `my self` is dynamic which user can change with the help of select author button. Further the users have the chance to craete a post by using the create button in the navigation bar right hand side.

## Usage
Xcode : 15+
SDK: iOS 17.0
Cocoapods : No
Architecture: MVVM
Any 3rd Paryy libs used: Yes
Name of lib if used: Kingfisher

## Feature done
2. Splash screen with label
3. Table view with list of posts loaded from local json for showing some initial data.
1. User can switch betwene authors using the select author button
4. User can switch between all post and only mine post view.
5. Users can create a post with the current selected user and the newly added post will be reflected in the list.



## Assumptions
1. Start with a list of data from local JOSN


## TODO's

1. Write unit tests for code coverage.
2. Write UI tests and docC documentation.
