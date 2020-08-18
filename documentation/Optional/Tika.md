# Tika

The Apache Tika™ toolkit detects and extracts metadata and text from over a
thousand different file types (such as PPT, XLS, and PDF). All of these file
types can be parsed through a single interface, making Tika useful for search
engine indexing, content analysis, translation, and much more.

## Requirements

You'll need [JAVA](./Java.md) to run Tika.

## Install Tika

We install Tika trough Homebrew:

```bash
brew install tika
```

This will install the latest Tika version in `/usr/local/bin/tika`.

You can run Tika directly from the command line:

```bash
tika /path/to/file/to/extract
```

## Configure Tika in Drupal

The [search_api_attachments](https://www.drupal.org/project/search_api_attachments) 
module supports extracting (through Tika) document content and store it in the
search engine index.

Set the proper path (`/usr/local/bin/tika`) to Tika in the module settings.
