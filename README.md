# Project 2 - *Yelp*

**Yelp** is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is completed:

-  Search results page
   -  Table rows should be dynamic height according to the content height.
   -  Custom cells should have the proper Auto Layout constraints.
   -  Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
-  Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   -  The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   -  The filters table should be organized into sections as in the mock.
   -  You can use the default UISwitch for on/off states.
   -  Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   -  Display some of the available Yelp categories (choose any 3-4 that you want).

The following **optional** features are implemented:

-  Search results page
   -  Implement map view of restaurant results.
- Filter page
   - Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).

The following **additional** features are implemented:

- Added annotations to maps
- Added progress Indicator (MBProgressHUD - cocoa pod)


## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](movies_walkthrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Hiding and showing table cells dynamically took a lot of time
