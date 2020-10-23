# rs.ios-stage2-task7
Application, which could play and save favourite TED Talks videos.


<img src="https://github.com/gurachevskaya/rs.ios-stage2-task7/blob/main/RSSchool_7/Images/Снимок%20экрана%202020-10-23%20в%2017.04.31.png?raw=true" width="200"><img src="https://github.com/gurachevskaya/rs.ios-stage2-task7/blob/main/RSSchool_7/Images/Снимок%20экрана%202020-10-23%20в%2017.04.55.png?raw=true" width="200">

### About:

1) All the info is loaded from the following URL - https://www.ted.com/themes/rss/id. Afterwards it is parsed as it’s an XML file.
2) There is an application with Tab Bar with 2 tabs:
1 screen: the list of all the videos, each cell represents the name of speaker, title of speech, note that it could be more than 1 speaker), an image and the duration of video.
3) App has search bar and search by the name of video and speaker.
4) Second screen is detailed info about the video, user is navigated here by tapping the cell from the previous screen. The video itself is shown using AVPlayer. Also there is the title of speech, speakers, description, like button, which will save the video in Favourites (screen 3), and share button (so that user could share the link from website to video).
5) The third screen is Favourites tab in the Tab Bar. It looks like the Screen 1. By default it’s empty. In case user tapped “Like” button on the Screen 2, it’s automatically added to the Favourites screen. The list of favourites is storing in Core Data. The video could be removed out of Favourites in case user deselect “Like” button.
6) The code is covered with Unit tests.



### Requirements:
- Feel free to choose any icons from Internet and fonts
- App should support iOS 11 and higher
- ARC
- Autolayout and XIBs, storyboards are not allowed
- UI should look appropriate in all the devices and orientations
- No special UI for iPad, it should look like on iPhone (no split view controllers)
- Note that UI must not be freezed by all loadings, check how the list with videos behaves in case the scrolling is fast
- Core Data for storing favourites
