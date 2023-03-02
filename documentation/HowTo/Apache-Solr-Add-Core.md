# Apache Solr : Add Core

Apache Solr works with multiple core's as indexing instances. This describes 
how to create a new core. 

## Create new core

Adding a new core to Solr is simple.

Run the following command to add a new core:

```bash
solr create -c CORE_NAME
```

The command line output will indicate that the new core is added:

```text
Created new core 'CORE_NAME'
```

The new core will be located at:

```text
/usr/local/var/lib/solr/CORE_NAME
```

> Note : Solr must be running to create a core through command line because it 
> uses the web API for it.
> 
> Example creating new core 'my_site' using command:
>
> Request:
> `http://localhost:8983/solr/admin/cores?action=CREATE&name=my_site&instanceDir=my_site`
>
> Response:
> ```json
> {
>   "responseHeader":{
>     "status":0,
>     "QTime":1017
>   },
>   "core":"my_site"
> }
> ```

The new core will be available at: `http://localhost:8983/solr/my_site`.

## Update the configuration

The new core has the default Solr schema and configuration. We need a different 
configuration for Drupal.

The configuration depends on the used Drupal search modules:

###  search_api_solr

The Search API Solr module contains a folder with sets of configuration files 
depending on the Solr version. Those files are located at:
`/path/to/sites/all/modules/contrib/search_api_solr/solr-conf-templates`.

> Note : Search api Solr 3.x generates the config files based on the solr
> configuration. Download these files trough the UI and put those in the proper
> Solr core directory.

Copy all those files to the configuration.

```bash
cp -r /path/to/sites/all/modules/contrib/search_api_solr/solr-conf-templates/8.x/* /usr/local/var/lib/solr/CORE_NAME/conf/
```

Restart Solr to pick up the new configuration.

```bash
solr restart
```
