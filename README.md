# lamp
Standalone lamp stack cookbook

# lamp-cookbook Description

Standalone cookbook to install and configure a vanilla LAMP stack includes httpd service, mysql (local install), and PHP on Amazon Linux. This cookbook should be used as a base replacement for this tutorial - http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html

## Requirements

You'll need to create a data bag "mysql" with item "password", store your root password there with the json flag "mysql_password"

## Supported Platforms

Amazon Linux

Will add more as time allows


## Recipies 

* lamp::default
* lamp::httpd
* lamp::mysql
* lamp::prep

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['lamp']['mysql']['install_sql']</tt></td>
    <td>Boolean</td>
    <td>Should only run on the first pass to prevent rewriting of your root password</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### lamp::default

Include `lamp` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[lamp::default]"
  ]
}
```

## License and Authors

Author::  Karl Girthofer (karlgirthofer@gmail.com)
License:: GNU GENERAL PUBLIC LICENSE
