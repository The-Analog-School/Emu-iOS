Emu-iOS
=======

Sample app that helps plan social events.

## Setup

* This project uses Cocoapods. You must run a `pod install` before use.
* You must include your own copy of the Parse.framework. Visit http://parse.com to download that.
* You must supply a `keys.plist` file that contains the following key-value pairs to authenticate with the Parse SDK and the Foursquare API. Make sure to put your own keys in the file below.

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>foursquare-client-id</key>
	<string></string>
	<key>foursquare-secret</key>
	<string></string>
	<key>parse-app-id</key>
	<string></string>
	<key>parse-client-key</key>
	<string></string>
</dict>
</plist>

```

