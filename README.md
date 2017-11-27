kml-icon-converter

For my New Zealand trip I'm using Google My Maps to create a map of the trail and points of interest along it (resupply points, huts, etc). Unfortunately, Google Maps on iOS does not support offline access to My Maps functionality, despite having offline support for map data.

Because of this, instead of Google Maps, I'll be using Galileo Offline Maps. It has support for importing and exporting KML files. Google's My Maps supports exporting KML. So I can export from My Maps and import into Galileo and have the offline access to my maps that I want.

The only problem is the icons don't make it over. So if I make changes to icons in My Maps, they don't make it into Galileo, you just get the same icon for everything.

Galileo does support custom icons in their KML import though. So long as they're ones Galileo itself supports. So this tool aims to convert a subset of the My Maps icons into ones that Galileo will import, so I can continue to use the My Maps interface as my source of truth, but be able to import it into Galileo.

I enumerated all of the icons that Galileo supports, at least the ones that are available from their website and created a simple mapping to Google Maps styles. I have put this mapping into [a spreadsheet](https://docs.google.com/spreadsheets/d/1sz3eeuDwWoZvHwnfQ2M-AtNEaEQYHRD5H-PB8AKetI4/edit?usp=sharing), at least to get started.

I wrote a blog post about this tool and how I'm using it (including screenshots) here: https://words.kitchen.io/2017/11/25/google-my-maps-to-galileo-offline-maps/
