DISCLAIMER: I'm going to significantly gloss over KML's features here, and also I may be entirely wrong on some things because I have no direct knowledge of the KML spec, I only have a couple of sample KML files to play with and am making inferences based on what those files do. Things may be wrong. I do welcome corrections, but please don't treat this document like any sort of spec :)

# things

One of the experiments I ran when I was trying to figure this out aimed to see what Galileo exported in KML and see if it would import the same KML. It did.

Galileo's KML export has 2 things that are relevant to what we're doing here. It has `<Placemark>` tags, and `<Style><IconStyle>` parts.

It does seem that Galileo exports well formed and usable KML from its app. A sample export from Galileo is in [`galileo-export.kml`](galileo-export.kml). The relevant bits are:

```
<Style id="BookmarkStyle_69">
  <IconStyle>
    <Icon>
      <href>http://shared.galileo-app.com/static/img/bookmark/BookmarkStyle_69.png</href>
    </Icon>
  </IconStyle>
</Style>
<Placemark>
  <gx:TimeStamp>2017-11-17T06:50:44.697Z</gx:TimeStamp>
  <name>GOM native marker</name>
  <styleUrl>BookmarkStyle_69</styleUrl>
  <Point>
    <coordinates>-122.653376,45.51388786,0</coordinates>
  </Point>
</Placemark>
```

My interpretation of this is the `styleUrl` tag on the `Placemark` is a reference to a `Style` id from above. Multiple points can reference the same style, and there can be multiple styles in the file.

Google's equivalent parts look like this (from google-export.kml)

```
<Style id="icon-1603-0288D1-nodesc-normal">
  <IconStyle>
    <color>ffd18802</color>
    <scale>1</scale>
    <Icon>
      <href>http://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png</href>
    </Icon>
  </IconStyle>
  <LabelStyle>
    <scale>0</scale>
  </LabelStyle>
  <BalloonStyle>
    <text><![CDATA[<h3>$[name]</h3>]]></text>
  </BalloonStyle>
</Style>
<Style id="icon-1603-0288D1-nodesc-highlight">
  <IconStyle>
    <color>ffd18802</color>
    <scale>1</scale>
    <Icon>
      <href>http://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png</href>
    </Icon>
  </IconStyle>
  <LabelStyle>
    <scale>1</scale>
  </LabelStyle>
  <BalloonStyle>
    <text><![CDATA[<h3>$[name]</h3>]]></text>
  </BalloonStyle>
</Style>
<StyleMap id="icon-1603-0288D1-nodesc">
  <Pair>
    <key>normal</key>
    <styleUrl>#icon-1603-0288D1-nodesc-normal</styleUrl>
  </Pair>
  <Pair>
    <key>highlight</key>
    <styleUrl>#icon-1603-0288D1-nodesc-highlight</styleUrl>
  </Pair>
</StyleMap>
<Placemark>
  <name>1100 SE 12th Ave</name>
  <styleUrl>#icon-1603-0288D1-nodesc</styleUrl>
  <Point>
    <coordinates>
      -122.6533701,45.5148999,0
    </coordinates>
  </Point>
</Placemark>
```

In this case, Google's kml seems to define multiple `Style`s, groups them in a `StyleGroup` and references that `StyleGroup` id in the `Placemark`.

For what it's worth, neither application supports the other's KML directly. Now that I'm taking a fresh look at this I think I might see a problem with Galileo's KML that could make that the case. The `styleUrl` in Google's KML is prefixed with a `#`, whereas Galileo's is not.

And sure enough, if I change the `styleUrl` to be prefixed with a `#`, it works just fine! Anywho, I digress.

If I modify the style in the galileo-export.kml to be `BookmarkStyle_68`, Galileo correctly imports the file with the updated marker. This lead me to believe that I could convert the Google KML into something Galileo could consume pretty easily.

Further experimenting lead me to find out that Galileo actually doesn't care about *anything* other than the contents of the `styleUrl` tag. If I change `<styleUrl>BookmarkStyle_69</styleUrl>` to `<styleUrl>BookmarkStyle_42</styleUrl>`, without modifying any other part of the file, it works just fine. So I can be extremely lazy and change the `styleUrl` tags in the google output to what GOM expects and it will just work. And for my first iteration, that is exactly what I'm going to do. I'd prefer to keep the file valid and usable for other things, so I'll work on changing that out next, but at first, to get *me* going, I'll just modify th styleUrl in place.


# first iteration

My immediate thinking is "this is XML, I should use XSLT", and that would be correct. But I'll save that for the next iteration. Minimum viable product and such.

So the first iteration is going to be a ruby script which opens the kml file, reads it line by line, finds the `styleUrl` tag, and updates using that mapping (which I'll export as a csv file that the ruby script can consume)
