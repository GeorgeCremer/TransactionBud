#### Thought process around image caching:
- I decided to split the network manager and the image caching objects. I wanted to fetch the images directly from cellForRowAt, ensuring only required images would attempt to be fetched from either the cache or sever. This seemed difficult to achieve with the MVP model relying on delegation (I would love to know how you would tackle this).
- The image cache is just a demo; it isn't persisted beyond the app's life cycle but could easily be written to disk. Obviously, there are pros and cons of doing so; would be happy to discuss.

#### Some little extras:
- Delete button takes into account the bottom safe area and adjusts for older / new phones.
- I wasn't sure if the red highlights in the design were just an illustration or the actual design, so I took the liberty of deviating a little. I thought it looked cleaner to have a red check mark (and have the cells dynamically contract) instead of highlighting the whole cell. - Included a custom alert class for error handling across the app.
- Added a menu button to allow for resetting the app and triggering a new network call. Also, to simulate error messages generated randomly (hopefully, you do not see error's outside of this!).

#### Things to improve:
- Handle errors in ImageCache.retrieveImage(); at the moment, I just send back a placeholder image but don't trigger or log an alert if something goes wrong.
- When deleting the cells, I kept track of the transaction IDs to filter out unwanted results from the API (whilst leaving the API data intact and not needing to delete at the source). At the moment transactionIdToHide: [String] = [] is written to, but is not yet used to filter.
- Testing needs to be expanded but hopefully is enough for the scope of this task. 
- Add activity indicator whilst fetching data
