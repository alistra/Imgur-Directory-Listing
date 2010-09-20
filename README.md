# Imgur-Directory-Listing

This is a directory listing app for people with slow upload speeds. Each image in the images directory is uploaded to [imgur.com](imgur.com) and each link on the site redirects users to [imgur.com](http://imgur.com).

# How does it work?

It's using incron, to add an image to the database (and to [imgur.com](http://imgur.com)), each time it's added to the images directory. 

## Requirements
* incron installed
* imgur gem installed
* mime-types gem installed
## Installation
Create a file in /etc/incron.d/ directory and add following lines to it:

    /your/images/dir/ IN_CREATE,IN_MOVED_TO /where/this/app/is/script/create.sh $#
    /your/images/dir/ IN_DELETE,IN_MOVED_FROM /where/this/app/is/script/delete.sh $#


