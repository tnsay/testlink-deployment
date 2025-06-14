===============================================================
 TestLink - README.plugins
===============================================================

Writing Plugins:

To create a new plugin, create a new folder with the name of the plugin under
"plugins" folder at the base dir, for e.g. TLTest as provided in the
distribution. This should be a unique named plugin in the system. The name of
the folder acts as the name of the plugin.

The structure inside the plugin folder will be
+ plugins
+--< Name of Plugin >
+------ < Plugin Main Class File >
+------ pages
+---------< Smarty Template files >
+---------< PHP Files to process Smarty templates >
+------ lang
+---------< language code >
+------------ strings.txt
+---------< language code >
+------------ strings.txt

Plugin Main Class:
The plugin main class should reside directly under the plugins/<pluginname>
folder. This class should extend from core TestlinkPlugin class and expose
the following properties
* name
* description
* version
* author
* url
These information will be displayed in the Plugins page, which can be used to
enable or disable a plugin in the current Testlink installation (This has not
yet been implemented).

The plugin main class also needs to have the following methods:
* register: The basic information about the plugin including name, description,
  version, author, url are maintained here. This method is mandatory
* config: Returns an array of the default configuration fields that are required
  for the plugin. These values are stored in Globals against the plugin and act
  as defaults whenever they are requested using plugin_config_get (See below)
* hooks: Returns an array of the hooks that this plugin listens to. The list of
  hooks are defined in events_inc.php. The array value will be the method in the
  plugin class that defines what needs to be done when that plugin happens.

Utilities that will help in writing the plugin class and support files:
* $db : This variable will be available for the plugins to do any DB related
  operations. The users can directly do a `doDBConnect($db)` to connect to the
  $db and then use any of the methods available in database.class.php
* plugin_file_path: Function to get an absolute path to a file inside of the
  plugin. For e.g. any reference to a file from one php file to another can be
  done using this. This avoids the user understanding how to reference files
  inside the plugin.
* plugin_config_set: Set a configuration value in the Database. The values are
  stored in the plugins_configuration table. You can set a value at two levels:
  Either at a testproject level or available to all test projects
* plugin_config_get: Get a configuration value from the database. The value will
  be fetched from the requested testprojectId (Passed in as a paramter) and if its
  not there, it will fetch a value available at "All projects" level. If its not
  available there, then it picks it up from the Global Defaults (Setup through the
  `config` method of the plugin) and then default to the "default" parameter provided
  in the method definition. See `plugin_config_get` in `plugin_api.php` for details
* plugin_lang_get: Get a string value according to the language configured in
  TestLink for the current user. See lang directory in TLTest plugin for more info

Writing Templates that will help in Plugin Configuration:
The user might want to create pages that will help in configuring a plugin at a
testproject level or for all projects. These template files will need to reside
inside `pages` folder. We have exported the tlSmarty class so that users can write
smarty templates. The php file to support the smarty templates are also inside the
`pages` folder. Please see config.php and config.tpl inside
plugins/TLTest/pages for an example

